
cp -f C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
cp -f C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library_package.vhd"                      
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/dspba_library.vhd"                              
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlogan +v2k  "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/altera_avalon_sc_fifo.v"                        
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_rtl_core.vhd"                            
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_ast.vhd"                                 
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II.vhd"                                     
vhdlan -xlrm "C:/Users/va956/Desktop/Magnetometro_de_Rb/Lockin/ip/FIR/FIR_II_sim/FIR_II_tb.vhd"                                  
