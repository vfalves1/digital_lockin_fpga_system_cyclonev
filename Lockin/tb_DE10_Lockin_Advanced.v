`timescale 1ns / 1ps

module tb_DE10_Lockin_Advanced;

    // ========================================================
    // 1. SINAIS DO SISTEMA
    // ========================================================
    reg CLOCK_50;
    reg [3:0] KEY;
    reg [9:0] SW;
    wire ADC_CONVST, ADC_SCLK, ADC_DIN;
    reg  ADC_DOUT;
    
    wire [9:0] LEDR;
    wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    DE10_Standard_GHRD uut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .SW(SW),
        .LEDR(LEDR),
        .ADC_CONVST(ADC_CONVST),
        .ADC_SCLK(ADC_SCLK),
        .ADC_DIN(ADC_DIN),
        .ADC_DOUT(ADC_DOUT)
    );

    always #10 CLOCK_50 = ~CLOCK_50; // 50 MHz

    // ========================================================
    // 2. PARÂMETROS MATEMÁTICOS DO MUNDO REAL
    // ========================================================
    real PI = 3.14159265358979323846;
    
    // Configurações da Experiência
    real freq_sinal    = 2500.0;    // Frequência de 2.5 kHz
    real amplitude     = 1000.0;    // Amplitude (em LSBs do ADC, max 2048)
    real offset_dc     = 2048.0;    // Centro da escala do ADC (12 bits -> 2048)
    real fase_graus    = 45.0;      // Desfasamento que o Lock-in tem de descobrir!
    
    // Variáveis internas da simulação
    real tempo_segundos;
    real fase_radianos;
    real valor_ref_real;
    real valor_sig_real;
    integer ruido;
    
    reg [11:0] shift_reg_out;
    integer i;

    initial begin
        fase_radianos = (fase_graus * PI) / 180.0;
    end

    // ========================================================
    // 3. MODELO AVANÇADO DO ADC LTC2308 (Amostragem Real-Time)
    // ========================================================
    always @(negedge ADC_CONVST) begin
        // 1. Descobrir o tempo atual da simulação em Segundos
        tempo_segundos = $realtime / 1_000_000_000.0; 
        
        // 2. Gerar o Ruído Aleatório (entre -32 e +31 LSBs)
        ruido = ($random % 64) - 32; 
        
        // 3. Calcular Equações da Onda
        // Referência: A * sin(wt) + DC
        valor_ref_real = (amplitude * $sin(2.0 * PI * freq_sinal * tempo_segundos)) + offset_dc;
        
        // Sinal: A * sin(wt + Fase) + Ruído + DC
        valor_sig_real = (amplitude * $sin((2.0 * PI * freq_sinal * tempo_segundos) + fase_radianos)) + offset_dc + ruido;
        
        // 4. Limitar aos 12 bits do ADC (0 a 4095) e empacotar
        if (uut.controlador_adc.measure_ch == 3'b000) begin
            // Canal do Sinal
            shift_reg_out = valor_sig_real;
        end else begin
            // Canal da Referência
            shift_reg_out = valor_ref_real;
        end
        
        // Clipping de segurança (saturação do ADC)
        if (valor_sig_real > 4095) shift_reg_out = 12'd4095;
        if (valor_sig_real < 0)    shift_reg_out = 12'd0;

        #1500; // Tempo de conversão do ADC (1.5 us)
        
        // 5. Transmitir os bits pelo SCLK do SPI
        for (i = 11; i >= 0; i = i - 1) begin
            @(negedge ADC_SCLK);
            ADC_DOUT = shift_reg_out[i];
        end
        
        @(negedge ADC_SCLK);
        ADC_DOUT = 0;
    end

    // ========================================================
    // 4. CONTROLO DA SIMULAÇÃO
    // ========================================================
    initial begin
        CLOCK_50 = 0;
        KEY = 4'b0000; // Reset Ativo
        ADC_DOUT = 0;
        
        $display("=====================================================");
        $display(" INICIANDO SIMULACAO LOCK-IN (ALTA FIDELIDADE)       ");
        $display(" Frequencia: %0.1f Hz | Fase Injetada: %0.1f graus", freq_sinal, fase_graus);
        $display("=====================================================");

        #500;
        KEY = 4'b1111; // Liberta o Reset
        
        // Aguarda pelo PLL
        wait(uut.pll_locked == 1'b1);
        $display("[%0t] PLL Locked. ADC a iniciar amostragem...", $time);

        // Deixa a simulação correr por tempo suficiente para os filtros CIC e FIR
        // estabilizarem (O FIR precisa de muitos ciclos para encher o pipeline).
        // 10 milisegundos de simulação (50 MHz clock -> 500,000 ciclos)
        #10_000_000; 

        $display("=====================================================");
        $display(" SIMULACAO CONCLUIDA.");
        $display(" Verifica os sinais I e Q, e as saidas do CORDIC.");
        $display(" O CORDIC deve mostrar uma Fase proxima de %0.1f graus", fase_graus);
        $display("=====================================================");
        $stop;
    end

endmodule