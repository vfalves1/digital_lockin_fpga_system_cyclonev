
file copy -force C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
file copy -force C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library_package.vhd"                      
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library.vhd"                              
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog -v2k5 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/altera_avalon_sc_fifo.v"                        
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core.vhd"                            
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_ast.vhd"                                 
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II.vhd"                                     
vcom       "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_tb.vhd"                                  
