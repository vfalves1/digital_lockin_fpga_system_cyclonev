// =========================================================================
// MÓDULO: SUPERVISOR DE SINTONIA DA PLL (PURA MÁQUINA DE ESTADOS / WATCHDOG)
// =========================================================================
// Este bloco recebe a frequência instantânea já calculada pelo Zero-Crossing,
// estabiliza a leitura, dá o "chute inicial" no NCO, configura os parâmetros 
// dinâmicos de malha (K e shifts) e monitoriza desvios para reiniciar a PLL.
// =========================================================================

module prf_pll_supervisor (
    clk,
    reset,
    freq_instantanea_zc,
    novo_dado_freq,
    K_amostras,
    shift_gain,
    shift_integral,
    pll_reset_out,
    nco_center_frequency
);

// 2. DECLARAÇÃO DE DIREÇÕES E TIPOS (FORA DA LISTA)
input  wire        clk;                  // Clock do sistema (50 MHz)
input  wire        reset;                // Reset global do sistema

// Interface com o módulo externo do Zero-Crossing
input  wire [31:0] freq_instantanea_zc;  // O 'resultado_div' vindo do teu Zero-Crossing
input  wire        novo_dado_freq;       // Pulso de 1 ciclo indicando nova divisão pronta

// Saídas de Configuração para o Filtro de Malha (prf_pll_loop_filter)
output wire [6:0]  K_amostras;           // Janela do CIC (16, 32 ou 64)
output wire [2:0]  shift_gain;           // Normalização do CIC
output wire [4:0]  shift_integral;       // Escalonamento do ganho do PI
output wire        pll_reset_out;        // Linha de Reset dedicada para limpar o Filtro de Malha

// Saída de Sintonia para o NCO
output reg  [31:0] nco_center_frequency; // Frequência Central (O "Chute Inicial")

// =========================================================================
// 1. DECLARAÇÃO DE ESTADOS E REGISTOS INTERNOS
// =========================================================================
localparam [1:0] ST_ACQUISITION   = 2'b00,
					  ST_BOOTSTRAP     = 2'b01,
					  ST_LOCK_WATCHDOG = 2'b10;

reg [1:0] state_reg;

// Filtros e Âncoras de Monitorização
reg [34:0] acumulador_freq = 35'd0; 
wire [31:0] f_media_zc;

reg signed [31:0] f_chute_ancora;
reg [2:0]         cont_estabilizacao;

reg [31:0] dist_instantanea;
reg [31:0] dist_watchdog;

wire [31:0] janela_estabilizacao; // Tolerância para captura inicial
wire [31:0] janela_watchdog;       // Tolerância máxima operacional antes de desarmar

// Registos de saída controlados pela FSM
reg [6:0] K_amostras_reg;
reg [2:0] shift_gain_reg;
reg [4:0] shift_integral_reg;
reg       pll_internal_reset;

// Atribuições combinatórias diretas para o Filtro de Malha
assign K_amostras     = K_amostras_reg;
assign shift_gain     = shift_gain_reg;
assign shift_integral = shift_integral_reg;
assign pll_reset_out  = pll_internal_reset;

// =========================================================================
// 2. FILTRO SUAVIZADOR DA LEITURA DO ZERO-CROSSING
// =========================================================================
assign f_media_zc = acumulador_freq[34:3];

always @(posedge clk) begin
    if (reset) begin
        acumulador_freq <= 35'd0;
    end 
	 else if (novo_dado_freq) begin
			if (acumulador_freq == 35'd0) begin
            // Carrega instantaneamente o primeiro dado sintonizado (multiplicado por 8)
            acumulador_freq <= {freq_instantanea_zc, 3'b000}; 
         end else begin
				acumulador_freq <= acumulador_freq + freq_instantanea_zc - (acumulador_freq >>> 3);
			end
	 end
end

// =========================================================================
// 3. FSM SUPERVISORA: BOOTSTRAP E WATCHDOG DE SEGURANÇA
// =========================================================================
// janela_estabilizacao = f_media_zc / 32 (Equivale a uma tolerância de ~3,12% da Frequência Atual)
assign janela_estabilizacao = f_media_zc >> 5;

// janela_watchdog = f_chute_ancora / 16 (Equivale a uma tolerância total de ~6,25% em torno da âncora estável)
assign janela_watchdog       = f_chute_ancora >> 4;

always @(posedge clk) begin
    if (reset) begin
        state_reg            <= ST_ACQUISITION;
        f_chute_ancora       <= 32'd0;
        cont_estabilizacao   <= 3'd0;
        pll_internal_reset   <= 1'b1;         // Começa com a PLL congelada em reset
        nco_center_frequency <= 32'd0;
        
        // Configurações por defeito seguras
        K_amostras_reg       <= 7'd64;
        shift_gain_reg       <= 3'd6;
        shift_integral_reg   <= 5'd12;
        
        dist_instantanea     <= 32'd0;
        dist_watchdog        <= 32'd0;
    end else begin
        
        // --- CÁLCULO DE VALORES ABSOLUTOS (PROTEÇÃO CONTRA UNDERFLOW UNSIGNED) ---
        // 1. Distância entre a frequência instantânea e a média filtrada
        if (freq_instantanea_zc > f_media_zc)
            dist_instantanea <= freq_instantanea_zc - f_media_zc;
        else
            dist_instantanea <= f_media_zc - freq_instantanea_zc;

        // 2. Distância entre a média atual e a âncora do chute inicial
        if (f_media_zc > f_chute_ancora)
            dist_watchdog <= f_media_zc - f_chute_ancora;
        else
            dist_watchdog <= f_chute_ancora - f_media_zc;


        // --- CONTROLO DA MÁQUINA DE ESTADOS PRINCIPAL ---
        case (state_reg)
            
            // -----------------------------------------------------------------
            // ST_ACQUISITION: Garante que a frequência lida está estável na rede
            // -----------------------------------------------------------------
            ST_ACQUISITION: begin
                pll_internal_reset <= 1'b1;   // Mantém o filtro de malha limpo (Reset ativo)
                
                if (novo_dado_freq) begin
                    // Usamos a distância absoluta limpa: verifica se o desvio é menor que a uma tolerância de ~3,12% da Frequência Atual
                    if (dist_instantanea < janela_estabilizacao) begin
                        cont_estabilizacao <= cont_estabilizacao + 1'b1;
                        
                        // Se 7 medições consecutivas forem estáveis, assume a frequência
                        if (cont_estabilizacao == 3'd7) begin
                            state_reg <= ST_BOOTSTRAP;
                        end
                    end else begin
                        cont_estabilizacao <= 3'd0; // Sinal oscilou, reinicia janela de teste
                    end
                end
            end

            // -----------------------------------------------------------------
            // ST_BOOTSTRAP: Aplica os Ganhos Ideais e Liberta o Chute Inicial
            // -----------------------------------------------------------------
            ST_BOOTSTRAP: begin
                f_chute_ancora <= f_media_zc; // Define a âncora para a monitorização de desvios futuros
                
                // --- MAPEAMENTO DOS PARÂMETROS ADAPTATIVOS DO LOOP ---
                if (f_media_zc > 32'h40000000) begin
                    // Frequência Alta: Janela curta para máxima velocidade (K=16)
                    K_amostras_reg     <= 7'd16;
                    shift_gain_reg     <= 3'd4;
                    shift_integral_reg <= 5'd0;  
                end 
                else if (f_media_zc > 32'h20000000) begin
                    // Frequência Média: Janela intermédia equilibrada (K=32)
                    K_amostras_reg     <= 7'd32;
                    shift_gain_reg     <= 3'd5;
                    shift_integral_reg <= 5'd6;  
                end 
                else begin
                    // Frequência Baixa: Janela longa para matar ruído em Hz (K=64)
                    K_amostras_reg     <= 7'd64;
                    shift_gain_reg     <= 3'd6;
                    shift_integral_reg <= 5'd12; 
                end

                // O Chute Inicial: Despacha a frequência central para o NCO
                nco_center_frequency <= f_media_zc; 

                // Liberta o reset do filtro. A PLL arranca perfeitamente em cima do alvo!
                pll_internal_reset   <= 1'b0; 
                cont_estabilizacao   <= 3'd0;
                state_reg            <= ST_LOCK_WATCHDOG;
            end

            // -----------------------------------------------------------------
            // ST_LOCK_WATCHDOG: Monitorização passiva de saltos abruptos
            // -----------------------------------------------------------------
            ST_LOCK_WATCHDOG: begin
                pll_internal_reset <= 1'b0;   // PLL trabalha livre e trancada

                if (novo_dado_freq) begin
                    // Se a rede der um salto e se afastar do chute inicial além de 6,25% do valor inicial:
                    if (dist_watchdog > janela_watchdog) begin
                        state_reg <= ST_ACQUISITION; // Força um reset geral na PLL para re-captura limpa
                    end
                end
            end

            default: state_reg <= ST_ACQUISITION;
        endcase
    end
end

endmodule

