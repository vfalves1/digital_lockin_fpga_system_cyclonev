module prf_pll_loop_filter (
    // 1. LISTA PURA DE PORTAS
    clk,
    reset,
    sample_valid,     
    d_erro_bruto,
    nco_freq_word,
    
    // Configuração Estática Fixada pelo Arranque/Zero-Crossing
    K_amostras,       // Tamanho da janela do CIC (7'd16, 7'd32 ou 7'd64)
    shift_gain,       // Ganho de normalização do CIC (3'd4, 3'd5 ou 3'd6)
    shift_integral,   // Escalonamento do ganho do PI (5'd0, 5'd6 ou 5'd12)
    
    // Parâmetros de Controle Dinâmico
    kp_gain,
    ki_gain,
    
    // Coeficientes do Filtro Biquad DF-IIt
    b0, 
	 b1, 
	 b2,
    a1, 
	 a2,
    
    // Saída de controle corretiva para o NCO
    nco_freq_mod,
	 out_valid
);


// 2. DEFINIÇÃO DE DIREÇÕES E BARRAMENTOS
input  wire        clk;
input  wire        reset;
input  wire        sample_valid;      // Ativo por 1 ciclo quando há nova amostra

input  wire signed [27:0] d_erro_bruto;   
input  wire        [31:0] nco_freq_word;

input  wire 		 [6:0]  K_amostras;        
input  wire 		 [2:0]  shift_gain;        
input  wire 		 [4:0]  shift_integral;  

input  wire        [31:0] kp_gain;        
input  wire        [31:0] ki_gain;        

input  wire signed [31:0] b0;             
input  wire signed [31:0] b1;             
input  wire signed [31:0] b2;             
input  wire signed [31:0] a1;             
input  wire signed [31:0] a2;             

output reg  signed [31:0] nco_freq_mod; 
output reg  		 out_valid;  

// --- SINAIS DE PIPELINE DE VALIDAÇÃO (Casamento de atraso entre blocos) ---
reg biquad_valid;
reg pi_trigger;


// =========================================================================
// 3. LÓGICA INTERNA PROTEGIDA PELA TAXA DE AMOSTRAGEM
// =========================================================================

//// =========================================================================
//// 1. CAMADA DO FILTRO SINC DINÂMICO COM HISTERESE TEMPORAL ANTI-OSCILAÇÃO
//// =========================================================================
//reg signed [27:0] sinc_mem [0:127]; 
//reg [6:0] wr_ptr;
//reg [6:0] rd_ptr;
//reg signed [34:0] sinc_acc;
//reg signed [27:0] d_sinc_out;
//
//// --- GESTÃO DE K COM LOCKOUT TEMPORAL CORRIGIDO ---
//reg [6:0]  K_amostras;
//reg [2:0]  shift_gain;
//reg [6:0]  K_amostras_antigo;
//reg [9:0]  lockout_timer;     // Contador de guarda (1024 amostras de bloqueio)
//reg [1:0]  freeze_counter;
//wire       integrador_ready;
//
//// Sinais auxiliares para simplificar a leitura dos limiares do NCO
//wire nco_alto_para_16 = (nco_freq_word > 32'h40000000);
//wire nco_baixo_para_32 = (nco_freq_word < 32'h38000000);
//wire nco_alto_para_32 = (nco_freq_word > 32'h20000000);
//wire nco_baixo_para_64 = (nco_freq_word < 32'h18000000);
//
//always @(posedge clk) begin
//    if (reset) begin
//        K_amostras    <= 7'd64;
//        shift_gain    <= 3'd6;
//        lockout_timer <= 10'd0;
//    end else if (sample_valid) begin
//        
//        // Se o temporizador de guarda estiver ativo, ele decrementa e bloqueia mudanças
//        if (lockout_timer > 10'd0) begin
//            lockout_timer <= lockout_timer - 1'b1;
//        end else begin
//            // SÓ AVALIA A MUDANÇA SE O TIMER ESTIVER A ZERO (MALHA ESTABILIZADA)
//            case (K_amostras)
//                7'd64: begin
//                    if (nco_alto_para_32) begin
//                        K_amostras    <= 7'd32;
//                        shift_gain    <= 3'd5;
//                        lockout_timer <= 10'd1023; // Tranca a decisão por 1024 amostras!
//                    end
//                end
//                7'd32: begin
//                    if (nco_alto_para_16) begin
//                        K_amostras    <= 7'd16;
//                        shift_gain    <= 3'd4;
//                        lockout_timer <= 10'd1023; // Tranca!
//                    end else if (nco_baixo_para_64) begin
//                        K_amostras    <= 7'd64;
//                        shift_gain    <= 3'd6;
//                        lockout_timer <= 10'd1023; // Tranca!
//                    end
//                end
//                7'd16: begin
//                    if (nco_baixo_para_32) begin
//                        K_amostras    <= 7'd32;
//                        shift_gain    <= 3'd5;
//                        lockout_timer <= 10'd1023; // Tranca!
//                    end
//                end
//                default: K_amostras <= 7'd64;
//            endcase
//        end
//    end
//end
//
//// --- DETETOR DE TRANSIÇÃO E CONTROLO DE BLANKING (IGUAL) ---
//always @(posedge clk) begin
//    if (reset) begin
//        K_amostras_antigo <= 7'd64;
//        freeze_counter    <= 2'd0;
//    end else if (sample_valid) begin
//        K_amostras_antigo <= K_amostras;
//        
//        if (K_amostras != K_amostras_antigo) begin
//            freeze_counter <= 2'd3; // Aumentado ligeiramente para garantir purga
//        end else if (freeze_counter > 2'd0) begin
//            freeze_counter <= freeze_counter - 1'b1;
//        end
//    end
//end
//
//assign integrador_ready = (freeze_counter == 2'd0);
//
//// --- MATEMÁTICA DO SINC (IGUAL) ---
//always @(posedge clk) begin
//    if (reset) begin
//        wr_ptr     <= 7'd0;
//        rd_ptr     <= 7'd0;
//        sinc_acc   <= 35'd0;
//        d_sinc_out <= 28'd0;
//    end else if (sample_valid) begin 
//        rd_ptr           <= wr_ptr - K_amostras + 1'b1;
//        sinc_mem[wr_ptr] <= d_erro_bruto;
//        wr_ptr           <= wr_ptr + 1'b1;
//        
//        sinc_acc   <= sinc_acc + d_erro_bruto - sinc_mem[rd_ptr];
//        d_sinc_out <= (sinc_acc >>> shift_gain); 
//    end
//end


// --- CAMADA DO FILTRO SINC (BOXCAR ESTÁTICO) ---
reg signed [27:0] sinc_mem [0:127]; 
reg        [6:0] wr_ptr;
//reg       [6:0] rd_ptr;
wire       [6:0] rd_ptr;
reg signed [34:0] sinc_acc;
wire signed [34:0] sinc_shifted;
reg signed [27:0] d_sinc_out;

assign rd_ptr = wr_ptr - K_amostras + 1'b1;
assign sinc_shifted = (sinc_acc + d_erro_bruto - sinc_mem[rd_ptr]) >>> shift_gain;

always @(posedge clk) begin
    if (reset) begin
        wr_ptr     <= 7'd0;
        //rd_ptr     <= 7'd0;
        sinc_acc   <= 35'd0;
        d_sinc_out <= 28'd0;
		  biquad_valid <= 1'b0;
    end else begin
		  biquad_valid <= sample_valid;
		  if (sample_valid) begin 
			  //rd_ptr           <= wr_ptr - K_amostras + 1'b1;
			  sinc_mem[wr_ptr] <= d_erro_bruto;
			  wr_ptr           <= wr_ptr + 1'b1;
			  
			  sinc_acc   <= sinc_acc + d_erro_bruto - sinc_mem[rd_ptr];
			  d_sinc_out <= sinc_shifted[27:0]; 
		   end
	 end
end



// --- CAMADA BIQUAD: DIRECT FORM II TRANSPOSED ---
// Barramentos internos dimensionados para acomodar o crescimento de bits (30 bits dado + 18 bits coef)
reg signed [60:0] w1; // Primeiro registador de estado (atraso z^-1)
reg signed [60:0] w2; // Segundo registador de estado (atraso z^-2)

wire signed [27:0] biquad_in;
reg  signed [27:0] d_biquad_out;
wire signed [60:0] y_full;

assign biquad_in = d_sinc_out;

// Na DF-IIt, a saída atual é a entrada multiplicada por b0 somada ao estado anterior w1
// Ajustamos o alinhamento fracionário (truncatura em 18 bits para manter ganho unitário se Q18)
assign y_full = (biquad_in * b0) + w1;

always @(posedge clk) begin
    if (reset) begin
        w1           <= 60'd0;
        w2           <= 60'd0;
        d_biquad_out <= 28'd0;
		  pi_trigger   <= 1'b0;
    end else begin
	     pi_trigger <= biquad_valid;
		  if (biquad_valid) begin
			  // Atualiza a saída do filtro truncando os bits inferiores extras da multiplicação
			  d_biquad_out <= y_full[45:18]; 
			  
			  // Equações de estado transpostas (Soma os produtos diretamente nos registadores de atraso)
			  w1 <= (biquad_in * b1) - (y_full[45:18] * a1) + w2;
			  w2 <= (biquad_in * b2) - (y_full[45:18] * a2);
		  end
    end
end


// --- CAMADA DO FILTRO PI COM PIPELINE MICRO-SÍNCRONO ---
reg signed  [63:0] integrador;
reg signed  [63:0] prop_term;
reg signed  [63:0] int_term;
reg 			[1:0] valid_fase;
wire signed [63:0] next_integrador;
wire signed [63:0] pi_sum_instantaneo;

localparam signed [63:0] INT_MAX = 64'h7FFFFFFFFFFFFFFF;
localparam signed [63:0] INT_MIN = 64'h8000000000000000;

assign next_integrador = integrador + int_term;

assign pi_sum_instantaneo = prop_term + integrador;

always @(posedge clk) begin
    if (reset) begin
        integrador   <= 64'd0;
        prop_term    <= 64'd0;
        int_term     <= 64'd0;
        nco_freq_mod <= 32'd0;
        valid_fase   <= 2'b0;
		  out_valid    <= 1'b0;
    end else begin
        valid_fase  <= {valid_fase[0],pi_trigger}; 
		  out_valid <= 1'b0; 
		  
        if (pi_trigger) begin
            prop_term <= d_biquad_out * $signed({1'b0, kp_gain});
            int_term  <= (d_biquad_out * $signed({1'b0, ki_gain})) >>> shift_integral;
        end

        if (valid_fase[0]) begin
   		   if (int_term[63] == 1'b0 && integrador[63] == 1'b0 && next_integrador[63] == 1'b1) begin
                integrador <= INT_MAX; 
            end else if (int_term[63] == 1'b1 && integrador[63] == 1'b1 && next_integrador[63] == 1'b0) begin
                integrador <= INT_MIN; 
            end else begin
                integrador <= next_integrador; 
            end
        end

        if (valid_fase[1]) begin
            nco_freq_mod <= pi_sum_instantaneo[63:32];
				out_valid <= 1'b1;
        end
    end
end

endmodule


