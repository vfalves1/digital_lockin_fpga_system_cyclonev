
cp -f C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
cp -f C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library_package.vhd"                      
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library.vhd"                              
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_math_pkg_hpfir.vhd"                   
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_roundsat_hpfir.vhd"                   
ncvlog      "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/altera_avalon_sc_fifo.v"                        
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core.vhd"                            
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_ast.vhd"                                 
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II.vhd"                                     
ncvhdl -v93 "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_tb.vhd"                                  
