// ============================================================================
// Copyright (c) 2016 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Tue Sep 27 10:46:00 2016
// ============================================================================

`define ENABLE_HPS
//`define ENABLE_HSMC

module DE10_Standard_GHRD(


      ///////// CLOCK /////////
      input              CLOCK2_50,
      input              CLOCK3_50,
      input              CLOCK4_50,
      input              CLOCK_50,

      ///////// KEY /////////
      input    [ 3: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LED /////////
      output   [ 9: 0]   LEDR,

      ///////// Seg7 /////////
      output   [ 6: 0]   HEX0,
      output   [ 6: 0]   HEX1,
      output   [ 6: 0]   HEX2,
      output   [ 6: 0]   HEX3,
      output   [ 6: 0]   HEX4,
      output   [ 6: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// Video-In /////////
      input              TD_CLK27,
      input              TD_HS,
      input              TD_VS,
      input    [ 7: 0]   TD_DATA,
      output             TD_RESET_N,

      ///////// VGA /////////
      output             VGA_CLK,
      output             VGA_HS,
      output             VGA_VS,
      output   [ 7: 0]   VGA_R,
      output   [ 7: 0]   VGA_G,
      output   [ 7: 0]   VGA_B,
      output             VGA_BLANK_N,
      output             VGA_SYNC_N,

      ///////// Audio /////////
      inout              AUD_BCLK,
      output             AUD_XCK,
      inout              AUD_ADCLRCK,
      input              AUD_ADCDAT,
      inout              AUD_DACLRCK,
      output             AUD_DACDAT,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// ADC /////////
      output             ADC_SCLK,
      input              ADC_DOUT,
      output             ADC_DIN,
      output             ADC_CONVST,

      ///////// I2C for Audio and Video-In /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout    [35: 0]   GPIO,

`ifdef ENABLE_HSMC
      ///////// HSMC /////////
      input              HSMC_CLKIN_P1,
      input              HSMC_CLKIN_N1,
      input              HSMC_CLKIN_P2,
      input              HSMC_CLKIN_N2,
      output             HSMC_CLKOUT_P1,
      output             HSMC_CLKOUT_N1,
      output             HSMC_CLKOUT_P2,
      output             HSMC_CLKOUT_N2,
      inout    [16: 0]   HSMC_TX_D_P,
      inout    [16: 0]   HSMC_TX_D_N,
      inout    [16: 0]   HSMC_RX_D_P,
      inout    [16: 0]   HSMC_RX_D_N,
      input              HSMC_CLKIN0,
      output             HSMC_CLKOUT0,
      inout    [ 3: 0]   HSMC_D,
      output             HSMC_SCL,
      inout              HSMC_SDA,
`endif /*ENABLE_HSMC*/

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LCM_BK,
      inout              HPS_LCM_D_C,
      inout              HPS_LCM_RST_N,
      output             HPS_LCM_SPIM_CLK,
      output             HPS_LCM_SPIM_MOSI,
      output             HPS_LCM_SPIM_SS,
		input 				 HPS_LCM_SPIM_MISO,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/
      ///////// IR /////////
      output             IRDA_TXD,
      input              IRDA_RXD
);


//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  REG/WIRE declarations
//=======================================================
  wire  hps_fpga_reset_n;
  wire [3:0] fpga_debounced_buttons;
  wire [8:0]  fpga_led_internal;
  wire [2:0]  hps_reset_req;
  wire        hps_cold_reset;
  wire        hps_warm_reset;
  wire        hps_debug_reset;
  wire [27:0] stm_hw_events;
  wire        fpga_clk_50;
// connection of internal logics
  assign LEDR[9:1] = fpga_led_internal;
  assign stm_hw_events    = {{4{1'b0}}, SW, fpga_led_internal, fpga_debounced_buttons};
  assign fpga_clk_50=CLOCK_50;
  
// --- REG/WIRE Declarations ---
	wire lockin_reset;
	assign lockin_reset = !hps_fpga_reset_n;

	wire clk_20;      // Clock do ADC
	wire pll_locked;  // Clock estável

	(* keep *) reg adc_start = 1'b0;
	(* keep *) reg [2:0] adc_channel = 3'b000;
	(* keep *) wire adc_ready;
	(* keep *) wire [11:0] adc_data;
	
	reg adc_first_run = 1'b1;
	reg [2:0] adc_ready_sync;
	(* keep *) wire adc_finished_pulse;
	(* keep *) reg lockin_update_pulse = 1'b0;
	(* keep *) reg lockin_sinal_pulse = 1'b0;
	
	(* keep *) reg [11:0] sinal_1; // Armazenam os sinais
	(* keep *) reg [11:0] ref_1;   // Armazenam as referências
	
	reg [21:0] acumulador_ref;    // Para calcular a média da referência
	(* keep *) wire [11:0] media_ref;         // O centro real da sua onda de referência
	reg [31:0] timer_50mhz=32'b0;
	wire [31:0] periodo_inst;
	reg [31:0] tempo_ultima_borda=32'b0;
	(* keep *) reg [39:0] acc_periodo_media;
	(* keep *) reg [6:0]  cont_ciclos;
	reg ref_estado;               // Indica se a onda está acima ou abaixo da média
	// (* keep *) reg [31:0] proximo_phi;
	(* keep *) wire [31:0] phi_inc_reg;
	wire [31:0] resultado_div;
	(* keep *) reg  [39:0] den_reg;
	(* keep *) reg update_nco = 1'b0;
	(* keep *) reg [31:0] delay_divisor = 32'b0;
	
	reg [31:0] phi_inc_zc;            // Liga a saída 'resultado_div' ao Supervisor
	reg        phi_inc_zc_valid = 1'b0;     // Liga o pulso de 'update' ao Supervisor

	// Sinais de Controlo que o Supervisor envia para o Filtro de Malha (Loop Filter)
	wire [6:0]  w_K_amostras;
	wire [2:0]  w_shift_gain;
	wire [4:0]  w_shift_integral;
	wire        w_pll_reset_fsm;      // Reset dinâmico gerado pela FSM para limpar o PI

	// Sinal de Sintonia enviado para o NCO
	wire [31:0] phi_inc_0;    // O "Chute Inicial" estático
	
	
	
	(* keep *) wire signed [15:0] nco_sin;
	(* keep *) wire signed [15:0] nco_cos;
	
	// --- Fios para o multiplicador ---
	//reg [3:0] valid_delay;   // Atraso para o pulso de validade
	//reg [3:0] channel_delay; // Atraso para a identificação do canal
	//wire resultado_mult_pronto = valid_delay[3];
	//wire eh_canal_sinal   = channel_delay[3];
	reg [1:0] dsp_valid;
	(* keep *) wire fir_sink_valid;
	(* keep *) wire signed [27:0] mixer_I;
	(* keep *) wire signed [27:0] mixer_Q;
	
	// Filtros CIC E FIR_II
	wire signed        cic_out_I_valid;
	wire signed [27:0] cic_out_I_data;
	wire signed        cic_out_Q_valid;
	wire signed [27:0] cic_out_Q_data;
	wire signed [51:0] fir_out_I_data;
	wire signed        fir_out_I_valid;
	wire signed [51:0] fir_out_Q_data;   
	wire signed        fir_out_Q_valid;
	
	wire signed [52:0] fir_I_rounded;
	wire signed [52:0] fir_Q_rounded;
	(* keep *) reg signed [23:0] cordic_in_I;
	(* keep *) reg signed [23:0] cordic_in_Q;
	(* keep *) reg               cordic_in_valid;
	
	wire [24:0] magnitude_R_FIR;
	wire [25:0] fase_theta_FIR;
	reg [31:0] cordic_latency_pipe;
	(* keep *) reg [24:0] magnitude_hps_reg = 25'd0;
	(* keep *) reg [25:0] fase_hps_reg = 26'd0;
	
	
//=======================================================
//  Structural coding
//=======================================================
soc_system u0 (      
		  .clk_clk                               (CLOCK_50),                             //                clk.clk
		  .reset_reset_n                         (1'b1),                                 //                reset.reset_n
		  //HPS ddr3
		  .memory_mem_a                          ( HPS_DDR3_ADDR),                       //                memory.mem_a
        .memory_mem_ba                         ( HPS_DDR3_BA),                         //                .mem_ba
        .memory_mem_ck                         ( HPS_DDR3_CK_P),                       //                .mem_ck
        .memory_mem_ck_n                       ( HPS_DDR3_CK_N),                       //                .mem_ck_n
        .memory_mem_cke                        ( HPS_DDR3_CKE),                        //                .mem_cke
        .memory_mem_cs_n                       ( HPS_DDR3_CS_N),                       //                .mem_cs_n
        .memory_mem_ras_n                      ( HPS_DDR3_RAS_N),                      //                .mem_ras_n
        .memory_mem_cas_n                      ( HPS_DDR3_CAS_N),                      //                .mem_cas_n
        .memory_mem_we_n                       ( HPS_DDR3_WE_N),                       //                .mem_we_n
        .memory_mem_reset_n                    ( HPS_DDR3_RESET_N),                    //                .mem_reset_n
        .memory_mem_dq                         ( HPS_DDR3_DQ),                         //                .mem_dq
        .memory_mem_dqs                        ( HPS_DDR3_DQS_P),                      //                .mem_dqs
        .memory_mem_dqs_n                      ( HPS_DDR3_DQS_N),                      //                .mem_dqs_n
        .memory_mem_odt                        ( HPS_DDR3_ODT),                        //                .mem_odt
        .memory_mem_dm                         ( HPS_DDR3_DM),                         //                .mem_dm
        .memory_oct_rzqin                      ( HPS_DDR3_RZQ),                        //                .oct_rzqin
       //HPS ethernet		
	     .hps_0_hps_io_hps_io_emac1_inst_TX_CLK ( HPS_ENET_GTX_CLK),       //                             hps_0_hps_io.hps_io_emac1_inst_TX_CLK
        .hps_0_hps_io_hps_io_emac1_inst_TXD0   ( HPS_ENET_TX_DATA[0] ),   //                             .hps_io_emac1_inst_TXD0
        .hps_0_hps_io_hps_io_emac1_inst_TXD1   ( HPS_ENET_TX_DATA[1] ),   //                             .hps_io_emac1_inst_TXD1
        .hps_0_hps_io_hps_io_emac1_inst_TXD2   ( HPS_ENET_TX_DATA[2] ),   //                             .hps_io_emac1_inst_TXD2
        .hps_0_hps_io_hps_io_emac1_inst_TXD3   ( HPS_ENET_TX_DATA[3] ),   //                             .hps_io_emac1_inst_TXD3
        .hps_0_hps_io_hps_io_emac1_inst_RXD0   ( HPS_ENET_RX_DATA[0] ),   //                             .hps_io_emac1_inst_RXD0
        .hps_0_hps_io_hps_io_emac1_inst_MDIO   ( HPS_ENET_MDIO ),         //                             .hps_io_emac1_inst_MDIO
        .hps_0_hps_io_hps_io_emac1_inst_MDC    ( HPS_ENET_MDC  ),         //                             .hps_io_emac1_inst_MDC
        .hps_0_hps_io_hps_io_emac1_inst_RX_CTL ( HPS_ENET_RX_DV),         //                             .hps_io_emac1_inst_RX_CTL
        .hps_0_hps_io_hps_io_emac1_inst_TX_CTL ( HPS_ENET_TX_EN),         //                             .hps_io_emac1_inst_TX_CTL
        .hps_0_hps_io_hps_io_emac1_inst_RX_CLK ( HPS_ENET_RX_CLK),        //                             .hps_io_emac1_inst_RX_CLK
        .hps_0_hps_io_hps_io_emac1_inst_RXD1   ( HPS_ENET_RX_DATA[1] ),   //                             .hps_io_emac1_inst_RXD1
        .hps_0_hps_io_hps_io_emac1_inst_RXD2   ( HPS_ENET_RX_DATA[2] ),   //                             .hps_io_emac1_inst_RXD2
        .hps_0_hps_io_hps_io_emac1_inst_RXD3   ( HPS_ENET_RX_DATA[3] ),   //                             .hps_io_emac1_inst_RXD3
       //HPS QSPI  
		  .hps_0_hps_io_hps_io_qspi_inst_IO0     ( HPS_FLASH_DATA[0]    ),     //                               .hps_io_qspi_inst_IO0
        .hps_0_hps_io_hps_io_qspi_inst_IO1     ( HPS_FLASH_DATA[1]    ),     //                               .hps_io_qspi_inst_IO1
        .hps_0_hps_io_hps_io_qspi_inst_IO2     ( HPS_FLASH_DATA[2]    ),     //                               .hps_io_qspi_inst_IO2
        .hps_0_hps_io_hps_io_qspi_inst_IO3     ( HPS_FLASH_DATA[3]    ),     //                               .hps_io_qspi_inst_IO3
        .hps_0_hps_io_hps_io_qspi_inst_SS0     ( HPS_FLASH_NCSO    ),        //                               .hps_io_qspi_inst_SS0
        .hps_0_hps_io_hps_io_qspi_inst_CLK     ( HPS_FLASH_DCLK    ),        //                               .hps_io_qspi_inst_CLK
       //HPS SD card 
		  .hps_0_hps_io_hps_io_sdio_inst_CMD     ( HPS_SD_CMD    ),           //                               .hps_io_sdio_inst_CMD
        .hps_0_hps_io_hps_io_sdio_inst_D0      ( HPS_SD_DATA[0]     ),      //                               .hps_io_sdio_inst_D0
        .hps_0_hps_io_hps_io_sdio_inst_D1      ( HPS_SD_DATA[1]     ),      //                               .hps_io_sdio_inst_D1
        .hps_0_hps_io_hps_io_sdio_inst_CLK     ( HPS_SD_CLK   ),            //                               .hps_io_sdio_inst_CLK
        .hps_0_hps_io_hps_io_sdio_inst_D2      ( HPS_SD_DATA[2]     ),      //                               .hps_io_sdio_inst_D2
        .hps_0_hps_io_hps_io_sdio_inst_D3      ( HPS_SD_DATA[3]     ),      //                               .hps_io_sdio_inst_D3
       //HPS USB 		  
		  .hps_0_hps_io_hps_io_usb1_inst_D0      ( HPS_USB_DATA[0]    ),      //                               .hps_io_usb1_inst_D0
        .hps_0_hps_io_hps_io_usb1_inst_D1      ( HPS_USB_DATA[1]    ),      //                               .hps_io_usb1_inst_D1
        .hps_0_hps_io_hps_io_usb1_inst_D2      ( HPS_USB_DATA[2]    ),      //                               .hps_io_usb1_inst_D2
        .hps_0_hps_io_hps_io_usb1_inst_D3      ( HPS_USB_DATA[3]    ),      //                               .hps_io_usb1_inst_D3
        .hps_0_hps_io_hps_io_usb1_inst_D4      ( HPS_USB_DATA[4]    ),      //                               .hps_io_usb1_inst_D4
        .hps_0_hps_io_hps_io_usb1_inst_D5      ( HPS_USB_DATA[5]    ),      //                               .hps_io_usb1_inst_D5
        .hps_0_hps_io_hps_io_usb1_inst_D6      ( HPS_USB_DATA[6]    ),      //                               .hps_io_usb1_inst_D6
        .hps_0_hps_io_hps_io_usb1_inst_D7      ( HPS_USB_DATA[7]    ),      //                               .hps_io_usb1_inst_D7
        .hps_0_hps_io_hps_io_usb1_inst_CLK     ( HPS_USB_CLKOUT    ),       //                               .hps_io_usb1_inst_CLK
        .hps_0_hps_io_hps_io_usb1_inst_STP     ( HPS_USB_STP    ),          //                               .hps_io_usb1_inst_STP
        .hps_0_hps_io_hps_io_usb1_inst_DIR     ( HPS_USB_DIR    ),          //                               .hps_io_usb1_inst_DIR
        .hps_0_hps_io_hps_io_usb1_inst_NXT     ( HPS_USB_NXT    ),          //                               .hps_io_usb1_inst_NXT
		  
		  //HPS SPI0->LCDM 	
        .hps_0_hps_io_hps_io_spim0_inst_CLK    ( HPS_LCM_SPIM_CLK),    //                               .hps_io_spim0_inst_CLK
        .hps_0_hps_io_hps_io_spim0_inst_MOSI   ( HPS_LCM_SPIM_MOSI),   //                               .hps_io_spim0_inst_MOSI
        .hps_0_hps_io_hps_io_spim0_inst_MISO   ( HPS_LCM_SPIM_MISO),   //                               .hps_io_spim0_inst_MISO
        .hps_0_hps_io_hps_io_spim0_inst_SS0    ( HPS_LCM_SPIM_SS),    //                               .hps_io_spim0_inst_SS0
       //HPS SPI1 		  
		  .hps_0_hps_io_hps_io_spim1_inst_CLK    ( HPS_SPIM_CLK  ),           //                               .hps_io_spim1_inst_CLK
        .hps_0_hps_io_hps_io_spim1_inst_MOSI   ( HPS_SPIM_MOSI ),           //                               .hps_io_spim1_inst_MOSI
        .hps_0_hps_io_hps_io_spim1_inst_MISO   ( HPS_SPIM_MISO ),           //                               .hps_io_spim1_inst_MISO
        .hps_0_hps_io_hps_io_spim1_inst_SS0    ( HPS_SPIM_SS ),             //                               .hps_io_spim1_inst_SS0
      //HPS UART		
		  .hps_0_hps_io_hps_io_uart0_inst_RX     ( HPS_UART_RX    ),          //                               .hps_io_uart0_inst_RX
        .hps_0_hps_io_hps_io_uart0_inst_TX     ( HPS_UART_TX    ),          //                               .hps_io_uart0_inst_TX
		//HPS I2C1
		  .hps_0_hps_io_hps_io_i2c0_inst_SDA     ( HPS_I2C1_SDAT    ),        //                               .hps_io_i2c0_inst_SDA
        .hps_0_hps_io_hps_io_i2c0_inst_SCL     ( HPS_I2C1_SCLK    ),        //                               .hps_io_i2c0_inst_SCL
		//HPS I2C2
		  .hps_0_hps_io_hps_io_i2c1_inst_SDA     ( HPS_I2C2_SDAT    ),        //                               .hps_io_i2c1_inst_SDA
        .hps_0_hps_io_hps_io_i2c1_inst_SCL     ( HPS_I2C2_SCLK    ),        //                               .hps_io_i2c1_inst_SCL
      //HPS GPIO  
		  .hps_0_hps_io_hps_io_gpio_inst_GPIO09  ( HPS_CONV_USB_N),           //                               .hps_io_gpio_inst_GPIO09
        .hps_0_hps_io_hps_io_gpio_inst_GPIO35  ( HPS_ENET_INT_N),           //                               .hps_io_gpio_inst_GPIO35
        .hps_0_hps_io_hps_io_gpio_inst_GPIO37  ( HPS_LCM_BK ),  //                               .hps_io_gpio_inst_GPIO37
		  .hps_0_hps_io_hps_io_gpio_inst_GPIO40  ( HPS_LTC_GPIO ),              //                               .hps_io_gpio_inst_GPIO40
        .hps_0_hps_io_hps_io_gpio_inst_GPIO41  ( HPS_LCM_D_C ),              //                               .hps_io_gpio_inst_GPIO41
        .hps_0_hps_io_hps_io_gpio_inst_GPIO44  ( HPS_LCM_RST_N  ),  //                               .hps_io_gpio_inst_GPIO44
		  .hps_0_hps_io_hps_io_gpio_inst_GPIO48  ( HPS_I2C_CONTROL),          //                               .hps_io_gpio_inst_GPIO48
        .hps_0_hps_io_hps_io_gpio_inst_GPIO53  ( HPS_LED),                  //                               .hps_io_gpio_inst_GPIO53
        .hps_0_hps_io_hps_io_gpio_inst_GPIO54  ( HPS_KEY),                  //                               .hps_io_gpio_inst_GPIO54
    	  .hps_0_hps_io_hps_io_gpio_inst_GPIO61  ( HPS_GSENSOR_INT),  //                               .hps_io_gpio_inst_GPIO61

			
		  .led_pio_external_connection_export    ( fpga_led_internal ),               //                               led_pio_external_connection.export                     
        .dipsw_pio_external_connection_export  ( SW ),                 //                               dipsw_pio_external_connection.export
        .button_pio_external_connection_export ( fpga_debounced_buttons ),              //                               button_pio_external_connection.export 
		  .hex3_hex0_external_connection_export  ({1'b0, HEX3, 1'b0, HEX2, 1'b0, HEX1, 1'b0, HEX0}), // Liga os 32 bits (4x8) aos pinos
        .hex5_hex4_external_connection_export  ({1'b0, HEX5, 1'b0, HEX4}),             // Liga os 16 bits (2x8) aos pinos
		  .hps_0_h2f_reset_reset_n               ( hps_fpga_reset_n ),                //                hps_0_h2f_reset.reset_n
		  .hps_0_f2h_cold_reset_req_reset_n      (~hps_cold_reset ),      //       hps_0_f2h_cold_reset_req.reset_n
		  .hps_0_f2h_debug_reset_req_reset_n     (~hps_debug_reset ),     //      hps_0_f2h_debug_reset_req.reset_n
		  .hps_0_f2h_stm_hw_events_stm_hwevents  (stm_hw_events ),  //        hps_0_f2h_stm_hw_events.stm_hwevents
		  .hps_0_f2h_warm_reset_req_reset_n      (~hps_warm_reset ),      //       hps_0_f2h_warm_reset_req.reset_n 
		  
		  .pio_magnitude_external_connection_export ( {7'd0, magnitude_hps_reg} ),
		  .pio_fase_external_connection_export      ( { {6{fase_hps_reg[25]}}, fase_hps_reg} ),
		  .pio_freq_external_connection_export      ( phi_inc_reg )
    );

	 
	 // Debounce logic to clean out glitches within 1ms
debounce debounce_inst (
  .clk                                  (fpga_clk_50),
  .reset_n                              (hps_fpga_reset_n),  
  .data_in                              (KEY),
  .data_out                             (fpga_debounced_buttons)
);
  defparam debounce_inst.WIDTH = 4;
  defparam debounce_inst.POLARITY = "LOW";
  defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
  defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))
  
// Source/Probe megawizard instance
hps_reset hps_reset_inst (
  .source_clk (fpga_clk_50),
  .source     (hps_reset_req)
);

altera_edge_detector pulse_cold_reset (
  .clk       (fpga_clk_50),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[0]),
  .pulse_out (hps_cold_reset)
);
  defparam pulse_cold_reset.PULSE_EXT = 6;
  defparam pulse_cold_reset.EDGE_TYPE = 1;
  defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset (
  .clk       (fpga_clk_50),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[1]),
  .pulse_out (hps_warm_reset)
);
  defparam pulse_warm_reset.PULSE_EXT = 2;
  defparam pulse_warm_reset.EDGE_TYPE = 1;
  defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;
  
altera_edge_detector pulse_debug_reset (
  .clk       (fpga_clk_50),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[2]),
  .pulse_out (hps_debug_reset)
);
  defparam pulse_debug_reset.PULSE_EXT = 32;
  defparam pulse_debug_reset.EDGE_TYPE = 1;
  defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;
  
reg [25:0] counter; 
reg  led_level;
always @(posedge fpga_clk_50 or negedge hps_fpga_reset_n)
begin
if(~hps_fpga_reset_n)
begin
                counter<=0;
                led_level<=0;
end

else if(counter==24999999)
        begin
                counter<=0;
                led_level<=~led_level;
        end
else
                counter<=counter+1'b1;
end

assign LEDR[0]=led_level;

// --- Behavioral Coding ---

pll_20mhz pll_20 (
    .refclk   (CLOCK_50),   
    .rst      (1'b0),       // Reset (0 para correr sempre)
    .outclk_0 (clk_20),     // Saída de 20 MHz
    .locked   (pll_locked)  // Status 
);


adc_ltc2308 controlador_adc (
    .clk              (clk_20),      
    .measure_start    (adc_start),     // Tu dás o pulso para começar
    .measure_ch       (adc_channel),        // Escolhes o canal (0 ou 1)
    .measure_done     (adc_ready),      // Ele avisa quando acabou
    .measure_dataread (adc_data),  // Aqui saem os 12 bits

    // Ligações aos pinos físicos da DE10-Standard
    .ADC_CONVST       (ADC_CONVST),
    .ADC_SCK          (ADC_SCLK),
    .ADC_SDI          (ADC_DIN),
    .ADC_SDO          (ADC_DOUT)
);

always @(posedge CLOCK_50) begin
    // Passamos o sinal de 20MHz por 3 estágios de flip-flops a 50MHz
    adc_ready_sync <= {adc_ready_sync[1:0], adc_ready};
end

assign adc_finished_pulse = (adc_ready_sync[2] == 1'b0 && adc_ready_sync[1] == 1'b1) ? 1'b1:1'b0;

always @(posedge CLOCK_50) begin
    lockin_update_pulse <= 1'b0; 
    lockin_sinal_pulse <= 1'b0;
	 
    if (!pll_locked) begin
		  adc_start   <= 1'b0;
        adc_channel <= 3'b000;
		  adc_first_run   <= 1'b1;
        sinal_1 <= 12'sd0;
        ref_1   <= 12'sd0;
    end else begin 
		 // 1. GESTÃO DE DADOS
		 if (adc_finished_pulse) begin
			  if (adc_channel == 3'b000) begin
					sinal_1 <= adc_data;
					adc_channel <= 3'b001;
					lockin_sinal_pulse <= 1'b1;
			  end else begin
					ref_1   <= adc_data;
					adc_channel <= 3'b000;
					lockin_update_pulse <= 1'b1; 
			  end
			  adc_start <= 1'b0;
		 end 
		 // 2. LÓGICA DE DISPARO 
       // Se o ADC terminou (ready=1) ou é a 1ª vez, e o start está em baixo
		 else if ((adc_ready_sync[2] == 1'b1 || adc_first_run   == 1'b1) && adc_start == 1'b0) begin
            adc_start <= 1'b1;
				adc_first_run   <= 1'b0;
       end 
		 // 3. PULSO DE START (Auto-reset)
		 else if (adc_start == 1'b1 && adc_ready_sync[2] == 1'b0) begin
            adc_start <= 1'b0;
        end
		  
	end
end


assign media_ref = acumulador_ref[21:10]; // exatamente o mesmo que acumulador_ref >>> 10
assign periodo_inst = timer_50mhz - tempo_ultima_borda;

always @(posedge CLOCK_50) begin
	 timer_50mhz <= timer_50mhz + 1;
	 
	 update_nco <= 1'b0;
	 delay_divisor <= {delay_divisor[30:0], update_nco};
	 phi_inc_zc_valid <= 1'b0;
	 if (lockin_update_pulse) begin
		 // Média da referência para detecção de zero-crossing (Filtro Passa-Baixas Lento IIR)
		 acumulador_ref <= acumulador_ref + ref_1 - (acumulador_ref >>> 10);
		 //media_ref      <= acumulador_ref >>> 10;
		 
		 // Detector de Borda com Centro Dinâmico
		 if (ref_1 > (media_ref + 50) && ref_estado == 0) begin
			  ref_estado <= 1;
           //periodo_inst <= timer_50mhz - tempo_ultima_borda;
           tempo_ultima_borda <= timer_50mhz;
			  
			  if (periodo_inst > 32'd500) begin 
					acc_periodo_media <= acc_periodo_media + periodo_inst;
					cont_ciclos <= cont_ciclos + 1;
					
					if (cont_ciclos == 7'd127) begin
						  // Para o NCO que corre a 50MHz o F é: 
						  // phi = (2^32 * Fout) / Fclk
                    // Como Fout = Fclk / periodo_ciclos:
                    // phi = 2^32 / (periodo_medio_em_ciclos)
                    //proximo_phi <= 32'hFFFFFFFF / (acc_periodo_media >>> 5);
                    den_reg <= acc_periodo_media;
						  //cont_ciclos <= 0;
                    acc_periodo_media <= 0;
                    update_nco <= 1'b1;
					end
			  end
		 end 
		 else if (ref_1 < (media_ref - 50) && ref_estado == 1) begin
			  ref_estado <= 0;
		 end
	end
	if (delay_divisor[31] == 1'b1 && delay_divisor[30] == 1'b0) begin
        phi_inc_zc <= resultado_div;
		  phi_inc_zc_valid <= 1'b1;
    end
end


lpm_divide_ip divisor (
    .clock    (CLOCK_50),
	 .clken    (1'b1),
    .numer    (39'h7FFFFFFF80),
    .denom    (den_reg),
    .quotient (resultado_div),
	 .remain   ()
);


prf_pll_supervisor u_prf_pll_supervisor (
    .clk                  (CLOCK_50),          
    .reset                (!hps_fpga_reset_n),      
    
    // Interface de Entrada (Vinda do teu bloco de Zero-Crossing)
    .freq_instantanea_zc  (phi_inc_zc),         
    .novo_dado_freq       (phi_inc_zc_valid),    
    
    // Interface de Saída 1: Parâmetros Dinâmicos (Vão para o teu prf_pll_loop_filter)
    .K_amostras           (w_K_amostras),      
    .shift_gain           (w_shift_gain),      
    .shift_integral       (w_shift_integral),  
    .pll_reset_out        (w_pll_reset_fsm),   
    
    .nco_center_frequency (phi_inc_0)  
);

// PLL da referencia
wire pll_reset;
reg [31:0] phi_inc_ref_reg;
reg [1:0] w_pll_reset_reg = 2'b00;
wire start_pll;

wire signed [15:0] nco_sin_pll;
wire signed [15:0] nco_cos_pll;

wire signed [27:0] Q_ref_pll_erro_bruto;
reg [1:0] dsp_valid_pll = 2'b0;

// Sinais de controlo dinâmico e coeficientes do Filtro (Exemplo de barramentos típicos de 32-bit fixos)
reg  signed [31:0] reg_kp_gain = 32'h00163608;      
reg  signed [31:0] reg_ki_gain = 32'h000000CA;
reg  signed [31:0] reg_b0 = 32'h0000039E;       
reg  signed [31:0] reg_b1 = 32'h00000000;
reg  signed [31:0] reg_b2 = 32'hFFFFFC62;
reg  signed [31:0] reg_a1 = 32'hFFF801B5;
reg  signed [31:0] reg_a2 = 32'h0003FE4C;

// Saídas do Filtro de Malha
wire signed [31:0] nco_freq_mod_ref;             // A correção dinâmica calculada pelo PI/Biquad
wire        ref_pll_out_valid;                       // Pulso indicador de dado corrigido pronto


localparam LIMIAR_ERRO_LOCK = 28'd150;
localparam TOTAL_AMOSTRAS_ESTAVEIS = 12'd2047;
localparam LIMITE_CONTAGEM_UNLOCK = 8'd255;

reg signed [27:0] abs_erro_fase;
reg [11:0]        contador_estabilidade = 12'd0;
reg               w_lock_ok_reg = 1'b0;
reg [7:0] contador_ruido = 8'd0;
wire w_lock_ok;

// PLL da referencia
assign start_pll = w_pll_reset_reg[1] && (!w_pll_reset_reg[0]);

always @(posedge CLOCK_50) begin
	 if (!hps_fpga_reset_n) begin
       w_pll_reset_reg <= 2'b00;
		 phi_inc_ref_reg <= 32'b0;
    end else begin
		 w_pll_reset_reg <= {w_pll_reset_reg[0],w_pll_reset_fsm};
		 if (start_pll) begin
			 phi_inc_ref_reg <= phi_inc_0;
		 end
		 else if (ref_pll_out_valid) begin
			 phi_inc_ref_reg <= phi_inc_ref_reg + nco_freq_mod_ref;
		 end
	 end
end

nco_sin_gen nco_pll (
    .clk       (CLOCK_50),
    .reset_n   (hps_fpga_reset_n),
    .clken     (1'b1),
    .phi_inc_i (phi_inc_ref_reg), 
	 .freq_mod_i (32'd0),
    .fsin_o    (nco_sin_pll),
    .fcos_o    (nco_cos_pll),
    .out_valid ()
);

multiplicador_lockin mult_ref_q (
    .aclr    (!hps_fpga_reset_n),
    .clken   (1'b1),
    .clock   (CLOCK_50),
    .dataa   (ref_1),
    .datab   (nco_cos_pll),
    .result  (Q_ref_pll_erro_bruto)
);

always @(posedge CLOCK_50) begin
	if (!hps_fpga_reset_n) begin
       dsp_valid_pll <= 2'b00;
   end else begin
		 dsp_valid_pll <= {dsp_valid_pll[0], lockin_update_pulse};
	end
end

assign pll_reset = (!hps_fpga_reset_n) | w_pll_reset_fsm;

prf_pll_loop_filter u_prf_pll_loop_filter (
    // 1. Sinais Básicos e Relógio
    .clk            (CLOCK_50),            // Clock do sistema (50 MHz)
    .reset          (pll_reset),   // Reset combinado (Mestre + Alarme do Supervisor)
    .sample_valid   (dsp_valid_pll[1]),      // Pulso de disparo vindo do Detetor de Fase
    .d_erro_bruto   (Q_ref_pll_erro_bruto),      // Erro de fase medido
    .nco_freq_word  (phi_inc_ref_reg),     // Feedback da palavra do NCO

    // 2. Conexões Diretas do Supervisor (Parâmetros Adaptativos Automáticos)
    .K_amostras     (w_K_amostras),        // Liga direto ao w_K_amostras do Supervisor
    .shift_gain     (w_shift_gain),        // Liga direto ao w_shift_gain do Supervisor
    .shift_integral (w_shift_integral),    // Liga direto ao w_shift_integral do Supervisor

    // 3. Parâmetros de Controle Dinâmico
    .kp_gain        (reg_kp_gain),
    .ki_gain        (reg_ki_gain),

    // 4. Coeficientes do Filtro Biquad DF-IIt
    .b0             (reg_b0), 
    .b1             (reg_b1), 
    .b2             (reg_b2),
    .a1             (reg_a1), 
    .a2             (reg_a2),

    // 5. Saídas de Controle
    .nco_freq_mod   (nco_freq_mod_ref),      // Correção que vai ser somada ao Chute Inicial
    .out_valid      (ref_pll_out_valid)          // Sinalizador de atualização para o NCO
);

// LÓGICA DE DETEÇÃO DE LOCK DA REFERENCIA
always @(posedge CLOCK_50) begin
    if (pll_reset) begin
        contador_estabilidade <= 12'd0;
        w_lock_ok_reg         <= 1'b0;
        abs_erro_fase         <= 28'd0;
		  contador_ruido        <= 8'd0;
    end else begin
        if (dsp_valid_pll[1]) begin
            if (Q_ref_pll_erro_bruto[27] == 1'b1)
                abs_erro_fase <= -Q_ref_pll_erro_bruto; // Se negativo, inverte
            else
                abs_erro_fase <= Q_ref_pll_erro_bruto;  // Se positivo, mantém
                
            // Avaliação da Janela de Estabilidade
            if (abs_erro_fase < LIMIAR_ERRO_LOCK) begin
					 contador_ruido <= 8'd0;
                if (contador_estabilidade < TOTAL_AMOSTRAS_ESTAVEIS) begin
                    contador_estabilidade <= contador_estabilidade + 1'b1;
                end else begin
                    w_lock_ok_reg <= 1'b1; 
                end
            end else begin
                // O erro saltou fora da janela (A PLL desandou ou está na fase de captura inicial)
                contador_estabilidade <= 12'd0;
					 
                if (w_lock_ok_reg == 1'b1) begin
                    if (contador_ruido < LIMITE_CONTAGEM_UNLOCK) begin
                        contador_ruido <= contador_ruido + 1'b1; // Tolera o pico de ruído temporariamente
                    end else begin
                        w_lock_ok_reg  <= 1'b0; // O erro persiste! A PLL perdeu mesmo o Lock.
                        contador_ruido <= 8'd0;
                    end
                end else begin
                    contador_ruido <= 8'd0;
                end  
            end
        end
    end
end

assign w_lock_ok = w_lock_ok_reg;


// PLL para o sinal

wire w_switch_pll_debounced; 
reg [19:0] sw_debounce_div;  
reg r_sw_state = 1'b0;

reg [31:0] phi_inc_aux;

wire pll_sinal_reset;
wire signed [27:0] Q_sinal_pll_erro_bruto;

// Sinais de controlo dinâmico e coeficientes do Filtro (Exemplo de barramentos típicos de 32-bit fixos)
reg  signed [31:0] reg_kp_gain_sinal = 32'h00163608;      
reg  signed [31:0] reg_ki_gain_sinal = 32'h000000CA;
reg  signed [31:0] reg_b0_sinal = 32'h0000039E;       
reg  signed [31:0] reg_b1_sinal = 32'h00000000;
reg  signed [31:0] reg_b2_sinal = 32'hFFFFFC62;
reg  signed [31:0] reg_a1_sinal = 32'hFFF801B5;
reg  signed [31:0] reg_a2_sinal = 32'h0003FE4C;

// Saídas do Filtro de Malha
wire signed [31:0] nco_freq_mod_sinal;             // A correção dinâmica calculada pelo PI/Biquad
wire        sinal_pll_out_valid;                       // Pulso indicador de dado corrigido pronto

reg signed [27:0] abs_erro_fase_sinal;
reg [11:0]        contador_estabilidade_sinal = 12'd0;
reg               w_lock_sinal_reg = 1'b0;
reg [7:0] contador_ruido_sinal = 8'd0;
wire w_lock_sinal_fase;

wire condicao_lock_ideal;

// PLL para o sinal

// CIRCUITO DE DEBOUNCE DO SWITCH FÍSICO
always @(posedge CLOCK_50) begin
    // Se o estado físico do Switch for diferente do nosso registo estável
    if (SW[0] != r_sw_state) begin
        sw_debounce_div <= sw_debounce_div + 1'b1;
        // Se estabilizar por ~20 ms (2^20 ciclos a 50 MHz)
        if (sw_debounce_div == 20'hFFFFF) begin
            r_sw_state <= SW[0];
        end
    end else begin
        sw_debounce_div <= 20'd0;
    end
end

assign w_switch_pll_debounced = r_sw_state;

assign pll_sinal_reset = (!hps_fpga_reset_n) | w_pll_reset_fsm | (!w_switch_pll_debounced) | (!w_lock_ok_reg);
assign phi_inc_reg = phi_inc_ref_reg + phi_inc_aux;

always @(posedge CLOCK_50) begin
	 if (pll_sinal_reset) begin
		 phi_inc_aux <= 32'b0;
    end else begin
		 if (sinal_pll_out_valid && w_switch_pll_debounced) begin
			 phi_inc_aux <= phi_inc_aux + nco_freq_mod_sinal;
		 end
	 end
end

nco_sin_gen nco_lockin (
    .clk       (CLOCK_50),
    .reset_n   (hps_fpga_reset_n),
    .clken     (1'b1),
    .phi_inc_i (phi_inc_reg), // O valor calculado pelo medidor entra aqui!
	 .freq_mod_i (32'd0),
    .fsin_o    (nco_sin),
    .fcos_o    (nco_cos),
    .out_valid ()
);

assign Q_sinal_pll_erro_bruto = mixer_Q;

prf_pll_loop_filter u_prf_pll_loop_filter_sinal (
    // 1. Sinais Básicos e Relógio
    .clk            (CLOCK_50),            // Clock do sistema (50 MHz)
    .reset          (pll_sinal_reset),   // Reset combinado (Mestre + Alarme do Supervisor)
    .sample_valid   (dsp_valid[1]),      // Pulso de disparo vindo do Detetor de Fase
    .d_erro_bruto   (Q_sinal_pll_erro_bruto),      // Erro de fase medido
    .nco_freq_word  (phi_inc_reg),     // Feedback da palavra do NCO

    // 2. Conexões Diretas do Supervisor (Parâmetros Adaptativos Automáticos)
    .K_amostras     (w_K_amostras),        // Liga direto ao w_K_amostras do Supervisor
    .shift_gain     (w_shift_gain),        // Liga direto ao w_shift_gain do Supervisor
    .shift_integral (w_shift_integral),    // Liga direto ao w_shift_integral do Supervisor

    // 3. Parâmetros de Controle Dinâmico
    .kp_gain        (reg_kp_gain_sinal),
    .ki_gain        (reg_ki_gain_sinal),

    // 4. Coeficientes do Filtro Biquad DF-IIt
    .b0             (reg_b0_sinal), 
    .b1             (reg_b1_sinal), 
    .b2             (reg_b2_sinal),
    .a1             (reg_a1_sinal), 
    .a2             (reg_a2_sinal),

    // 5. Saídas de Controle
    .nco_freq_mod   (nco_freq_mod_sinal),      // Correção que vai ser somada ao Chute Inicial
    .out_valid      (sinal_pll_out_valid)          // Sinalizador de atualização para o NCO
);


// LÓGICA DE DETEÇÃO DE LOCK DA FASE DO SINAL
always @(posedge CLOCK_50) begin
    if (pll_reset) begin
        contador_estabilidade_sinal <= 12'd0;
        w_lock_sinal_reg            <= 1'b0;
        abs_erro_fase_sinal         <= 28'd0;
		  contador_ruido_sinal        <= 8'd0;
    end else begin
        if (dsp_valid[1]) begin
            if (Q_sinal_pll_erro_bruto[27] == 1'b1)
                abs_erro_fase_sinal <= -Q_sinal_pll_erro_bruto; // Se negativo, inverte
            else
                abs_erro_fase_sinal <= Q_sinal_pll_erro_bruto;  // Se positivo, mantém
                
            // Avaliação da Janela de Estabilidade
            if (abs_erro_fase_sinal < LIMIAR_ERRO_LOCK) begin
					 contador_ruido_sinal <= 8'd0;
                if (contador_estabilidade_sinal < TOTAL_AMOSTRAS_ESTAVEIS) begin
                    contador_estabilidade_sinal <= contador_estabilidade_sinal + 1'b1;
                end else begin
                    w_lock_sinal_reg <= 1'b1; 
                end
            end else begin
                // O erro saltou fora da janela (A PLL desandou ou está na fase de captura inicial)
                contador_estabilidade_sinal <= 12'd0;
					 
                if (w_lock_sinal_reg == 1'b1) begin
                    if (contador_ruido_sinal < LIMITE_CONTAGEM_UNLOCK) begin
                        contador_ruido_sinal <= contador_ruido_sinal + 1'b1; // Tolera o pico de ruído temporariamente
                    end else begin
                        w_lock_sinal_reg  <= 1'b0; // O erro persiste! A PLL perdeu mesmo o Lock.
                        contador_ruido_sinal <= 8'd0;
                    end
                end else begin
                    contador_ruido_sinal <= 8'd0;
                end  
            end
        end
    end
end

assign w_lock_sinal_fase = w_lock_sinal_reg;



// Parte final do Lockin

// Instância do Multiplicador I (Seno)
multiplicador_lockin mult_i (
	 .aclr    (!hps_fpga_reset_n),
    .clken   (1'b1),
    .clock   (CLOCK_50),
    .dataa   (sinal_1),
    .datab   (nco_sin),
    .result  (mixer_I)
);

// Instância do Multiplicador Q (Cosseno)
multiplicador_lockin mult_q (
    .aclr    (!hps_fpga_reset_n),
    .clken   (1'b1),
    .clock   (CLOCK_50),
    .dataa   (sinal_1),
    .datab   (nco_cos),
    .result  (mixer_Q)
);

always @(posedge CLOCK_50) begin
	if (!hps_fpga_reset_n) begin
       dsp_valid <= 2'b00;
   end else begin
		 // Shift register: o bit entra na posição 0 e vai "subindo"
		 //valid_delay   <= {valid_delay[2:0],   lockin_update_pulse};
		 //channel_delay <= {channel_delay[2:0], (adc_channel == 3'b000)};
		 dsp_valid <= {dsp_valid[0], lockin_update_pulse};
	end
end



assign condicao_lock_ideal = (w_switch_pll_debounced) ? (w_lock_ok_reg && w_lock_sinal_fase) : (w_lock_ok_reg);
assign fir_sink_valid = dsp_valid[1] && condicao_lock_ideal;


//INSTANCIAÇÃO DO FILTRO CIC PARA DECIMAÇAO DO SINAL I
CIC CIC_I (
    .clk       (CLOCK_50),         // O teu clock principal do FPGA (ex: 50MHz)
    .reset_n   (hps_fpga_reset_n),           // Reset do sistema (ativo em nível baixo)
    
    // ----------- CANAL DE ENTRADA (SINK) -> Ligado ao Misturador -----------
    .in_data   (mixer_I),          // Dados de 24 bits vindos da multiplicação
    .in_valid  (fir_sink_valid),    // Pulso de 1 ciclo de clock que bate a 200 kHz
    .in_ready  (),      // Output do CIC (podes deixar flutuante ou ler)
    .in_error  (2'b00),             // Sem erros na entrada (forçado a zero)
    
    // ----------- CANAL DE SAÍDA (SOURCE) -> Vai alimentar o teu FIR -----------
    .out_data  (cic_out_I_data),      // Saída filtrada de 24 bits estável a 2.5 kHz
    .out_valid (cic_out_I_valid),     // SINAL CRUCIAL: O "valid" que avisa o FIR a 2.5 kHz
    .out_ready (1'b1),  // Dizer ao CIC que o FIR está sempre pronto para ler (1'b1)
    .out_error ()      // Output de erro do bloco (podes deixar em aberto se quiseres)
);


//INSTANCIAÇÃO DO FILTRO FIR (Filtro Passa-Baixas de Precisão atenuaçao de 80Db a 50Hz) para o sinal I
FIR_II FIR_I (
    .clk              (CLOCK_50),         // Corre ao mesmo clock de 50 MHz
    .reset_n          (hps_fpga_reset_n), // Mesmo sinal de reset do sistema
    
    // Interface de Entrada (Sink) -> Recebe os dados mastigados pelo CIC
    .ast_sink_data    (cic_out_I_data),   // Conectado aos 24 bits de saída do CIC
    .ast_sink_valid   (cic_out_I_valid),  // IMPORTANTE: O FIR só calcula quando o CIC avisa!
    .ast_sink_error   (2'b00),            // Sem erros na entrada
    
    // Interface de Saída (Source) -> Vai para o teu CORDIC / Bloco de Medição
    .ast_source_data  (fir_out_I_data),   // Resultado final com resolução total (48 bits)
    .ast_source_valid (fir_out_I_valid),  // Pulso de validação de dados prontos do FIR
    .ast_source_error ()   // Saída de erro 
);


//INSTANCIAÇÃO DO FILTRO CIC PARA DECIMAÇAO DO SINAL Q
CIC CIC_Q (
    .clk       (CLOCK_50),         // O teu clock principal do FPGA (ex: 50MHz)
    .reset_n   (hps_fpga_reset_n),           // Reset do sistema (ativo em nível baixo)
    
    // ----------- CANAL DE ENTRADA (SINK) -> Ligado ao Misturador -----------
    .in_data   (mixer_Q),          // Dados de 24 bits vindos da multiplicação
    .in_valid  (fir_sink_valid),    // Pulso de 1 ciclo de clock que bate a 200 kHz
    .in_ready  (),      // Output do CIC (podes deixar flutuante ou ler)
    .in_error  (2'b00),             // Sem erros na entrada (forçado a zero)
    
    // ----------- CANAL DE SAÍDA (SOURCE) -> Vai alimentar o teu FIR -----------
    .out_data  (cic_out_Q_data),      // Saída filtrada de 24 bits estável a 2.5 kHz
    .out_valid (cic_out_Q_valid),     // SINAL CRUCIAL: O "valid" que avisa o FIR a 2.5 kHz
    .out_ready (1'b1),  // Dizer ao CIC que o FIR está sempre pronto para ler (1'b1)
    .out_error ()      // Output de erro do bloco (podes deixar em aberto se quiseres)
);

//INSTANCIAÇÃO DO FILTRO FIR (Filtro Passa-Baixas de Precisão atenuaçao de 80Db a 50Hz) para o sinal I
FIR_II FIR_Q (
    .clk              (CLOCK_50),         // Corre ao mesmo clock de 50 MHz
    .reset_n          (hps_fpga_reset_n), // Mesmo sinal de reset do sistema
    
    // Interface de Entrada (Sink) -> Recebe os dados mastigados pelo CIC
    .ast_sink_data    (cic_out_Q_data),   // Conectado aos 24 bits de saída do CIC
    .ast_sink_valid   (cic_out_Q_valid),  // IMPORTANTE: O FIR só calcula quando o CIC avisa!
    .ast_sink_error   (2'b00),            // Sem erros na entrada
    
    // Interface de Saída (Source) -> Vai para o teu CORDIC / Bloco de Medição
    .ast_source_data  (fir_out_Q_data),   // Resultado final com resolução total (48 bits)
    .ast_source_valid (fir_out_Q_valid),  // Pulso de validação de dados prontos do FIR
    .ast_source_error ()   // Saída de erro 
);

//Bloco que reduz os bots da saida dos FIR E sincroniza as saidas assumindo que as 2 saem ao meso tempo

assign fir_I_rounded = {fir_out_I_data[51], fir_out_I_data} + 53'h0000000008000000;
assign fir_Q_rounded = {fir_out_Q_data[51], fir_out_Q_data} + 53'h0000000008000000;

always @(posedge CLOCK_50 or negedge hps_fpga_reset_n) begin
    if (!hps_fpga_reset_n) begin
        cordic_in_I     <= 24'sb0;
        cordic_in_Q     <= 24'sb0;
        cordic_in_valid <= 1'b0;
    end else begin
        // Só atualiza os registadores quando o FIR tiver um dado novo pronto
        if (fir_out_I_valid) begin
			   if (fir_I_rounded[52] != fir_I_rounded[51]) begin
                // Se o original era positivo (bit 52 era 0), satura no máximo positivo
                // Se era negativo (bit 52 era 1), satura no máximo negativo
                cordic_in_I <= (fir_I_rounded[52] == 1'b0) ? 24'h7FFFFF : 24'h800000;
            end else begin
                // Se não houve estouro, a truncagem [51:28] é 100% segura
                cordic_in_I <= fir_I_rounded[51:28];
            end
				
				if (fir_Q_rounded[52] != fir_Q_rounded[51]) begin
                cordic_in_Q <= (fir_Q_rounded[52] == 1'b0) ? 24'h7FFFFF : 24'h800000;
            end else begin
                cordic_in_Q <= fir_Q_rounded[51:28];
            end
        end
        
        // O sinal de valid acompanha o dado (atraso de 1 ciclo de clock devido ao registador)
        cordic_in_valid <= fir_out_I_valid; 
    end
end

cordic_R cordic_1 (
    .clk    (CLOCK_50),
    .areset (!hps_fpga_reset_n), 
    .x      (cordic_in_I),       // Saída do filtro passa-baixas I
    .y      (cordic_in_Q),       // Saída do filtro passa-baixas Q    
    .q      (magnitude_R_FIR),   // R = sqrt(I^2+Q^2)
    .r      (fase_theta_FIR),    // Fase medida (contém o erro de fase)    
	 .en     (cordic_in_valid)
);

always @(posedge CLOCK_50) begin
    // O trigger entra aqui e "percorre" o mesmo caminho que o dado
    cordic_latency_pipe <= {cordic_latency_pipe[30:0], cordic_in_valid};
end

wire resultado_cordic_final_valido = cordic_latency_pipe[31];

always @(posedge CLOCK_50) begin
    if (lockin_reset) begin
        magnitude_hps_reg <= 0;
        fase_hps_reg <= 0;
    end else if (resultado_cordic_final_valido) begin
        magnitude_hps_reg <= magnitude_R_FIR;
        fase_hps_reg <= fase_theta_FIR;
    end
end








endmodule

  