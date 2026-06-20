transcript on
if ![file isdirectory DE10_Standard_GHRD_iputf_libs] {
	file mkdir DE10_Standard_GHRD_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
file copy -force C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library_package.vhd"                      
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library.vhd"                              
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/altera_avalon_sc_fifo.v"                        
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core.vhd"                            
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_ast.vhd"                                 
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II.vhd"                                     
vcom "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_tb.vhd"                                  

vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL/pll_20mhz.vo}
vlib pll_20mhz
vmap pll_20mhz pll_20mhz
vlog -vlog01compat -work pll_20mhz +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL/pll_20mhz.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II.vo}
vlib FIR_II
vmap FIR_II FIR_II
vlog -vlog01compat -work FIR_II +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/LPM_divide {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/LPM_divide/lpm_divide_ip.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/ADC_LTC2308_FIFO {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/ADC_LTC2308_FIFO/adc_ltc2308.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/debounce {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/debounce/debounce.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/altsource_probe {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/altsource_probe/hps_reset.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/edge_detect {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/edge_detect/altera_edge_detector.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/multiplicador_lockin.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/de10_standard_ghrd.v}
vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/db {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/db/mult_cup.v}
vlog -vlog01compat -work pll_20mhz +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL/pll_20mhz {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/PLL/pll_20mhz/pll_20mhz_0002.v}
vlib cordic_R
vmap cordic_R cordic_R
vlog -vlog01compat -work cordic_R +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/cordic_R/synthesis {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/cordic_R/synthesis/cordic_R.v}
vlib soc_system
vmap soc_system soc_system
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/soc_system.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_avalon_st_adapter.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_sysid_qsys.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_pio_Freq.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_mm_bridge.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_led_pio.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_jtag_uart.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hps_0.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hps_0_hps_io.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_mem_if_hhp_qseq_synth_top.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_acv_hard_addr_cmd_pads.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_acv_hard_io_pads.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_acv_hard_memphy.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_acv_ldc.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_altdqdqs.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_clock_pair_generator.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0_generic_ddio.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hex5_hex4.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hex3_hex0.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_f2sdram_only_master.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_packets_to_master.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_packets_to_bytes.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_bytes_to_packets.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_jtag_interface.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_jtag_dc_streaming.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_jtag_sld_node.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_jtag_streaming.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_idle_remover.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_idle_inserter.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_dipsw_pio.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_button_pio.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_up_avalon_adv_adc.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_adc_0.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/interrupt_latency_counter.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/irq_detector.v}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/state_machine_counter.v}
vlib nco_sin_gen
vmap nco_sin_gen nco_sin_gen
vlog -vlog01compat -work nco_sin_gen +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/nco_sin_gen/synthesis {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/nco_sin_gen/synthesis/nco_sin_gen.v}
vlog -vlog01compat -work nco_sin_gen +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/nco_sin_gen/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/nco_sin_gen/synthesis/submodules/nco_sin_gen_nco_ii_0.v}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_irq_mapper_002.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_irq_mapper_001.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_irq_mapper.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_address_alignment.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_rsp_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_cmd_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_cmd_demux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_router_001.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_2_router.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_rsp_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_rsp_demux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_cmd_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_cmd_demux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_traffic_limiter.sv}
vlog -vlog01compat -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_avalon_st_pipeline_base.v}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_router_001.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_1_router.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_axi_slave_ni.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_rsp_mux_002.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_rsp_demux_001.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_cmd_mux_001.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_cmd_demux_002.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_burst_adapter_13_1.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_router_010.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_router_005.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_router_004.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_router_002.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_mm_interconnect_0_router.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_merlin_axi_master_ni.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_mem_if_dll_cyclonev.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_mem_if_hard_memory_controller_top_cyclonev.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/altera_mem_if_oct_cyclonev.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_p0.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/hps_sdram_pll.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hps_0_hps_io_border.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_hps_0_fpga_interfaces.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_f2sdram_only_master_p2b_adapter.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_f2sdram_only_master_b2p_adapter.sv}
vlog -sv -work soc_system +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/soc_system/synthesis/submodules/soc_system_f2sdram_only_master_timing_adt.sv}
vcom -93 -work cordic_R {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/cordic_R/synthesis/submodules/dspba_library_package.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/dspba_library_package.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_math_pkg_hpfir.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_avalon_streaming_controller_hpfir.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_roundsat_hpfir.vhd}
vcom -93 -work cordic_R {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/cordic_R/synthesis/submodules/dspba_library.vhd}
vcom -93 -work cordic_R {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/cordic_R/synthesis/submodules/cordic_R_CORDIC_0.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/dspba_library.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_lib_pkg_hpfir.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_avalon_streaming_source_hpfir.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/FIR_II_0002_rtl_core.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/auk_dspip_avalon_streaming_sink_hpfir.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/FIR_II_0002_ast.vhd}
vcom -93 -work FIR_II {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II/FIR_II_0002.vhd}

vlog -vlog01compat -work work +incdir+C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin {C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/tb_DE10_Lockin_Advanced.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L pll_20mhz -L FIR_II -L cordic_R -L soc_system -L nco_sin_gen -voptargs="+acc"  tb_DE10_Lockin_Advanced

add wave *
view structure
view signals
run -all
