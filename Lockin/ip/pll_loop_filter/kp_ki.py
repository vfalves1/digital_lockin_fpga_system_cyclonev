import numpy as np

Fs = 160000.0          # Frequência de amostragem da PLL (160 kHz)
Ts = 1.0 / Fs          # Período de amostragem
T_lock_alvo = 0.05    # Tempo de lock desejado (50 ms)
zeta = 0.707           # Fator de amortecimento 

# Erro inicial após o chute do Supervisor (40 Hz de desvio)
f_real_sinal = 1000.0  # Exemplo: Frequência real do sensor (1 kHz)
f_chute_nco  = 960.0   # O NCO arranca a 960 Hz (Erro de exatamente 40 Hz)

# Largura de banda do loop (Loop Bandwidth)
BW = 1.0 / (4.0 * T_lock_alvo)
omega_n = 2.0 * np.pi * BW

# Ganhos contínuos e digitalização (Euler)
Kp = 2.0 * zeta * omega_n
Ki_cont = omega_n**2
Ki_dig = Ki_cont * Ts

# Conversão para Ponto Fixo Q16.16 (Multiplicar por 2^16)
Q_factor = 2**15
Kp_q16 = int(round(Kp * Q_factor))
Ki_q16 = int(round(Ki_dig * Q_factor))

print("="*60)
print(" PARÂMETROS CALCULADOS PARA A FPGA (160 kHz)")
print("="*60)
print(f"Loop Bandwidth (BW) : {BW:.2f} Hz")
print(f"Kp (Ponto Flutuante): {Kp:.5f}  -> Na FPGA (Q16.16): {Kp_q16} (32'h{Kp_q16:08X})")
print(f"Ki (Ponto Flutuante): {Ki_dig:.5f} -> Na FPGA (Q16.16): {Ki_q16} (32'h{Ki_q16:08X})")
print("="*60)

# =========================================================================
# SIMULAÇÃO DINÂMICA DA TRANCAGEM 
# =========================================================================
# Vamos simular 500 ms de tempo real para ver a estabilização completa
tempo_total_sim = 0.500 
num_passos = int(tempo_total_sim / Ts)

# Inicialização de variáveis da malha
fase_entrada = 0.0
fase_nco = 0.0
integrador_pi = 0.0
nco_freq_mod = 0.0

# Arrays para guardar histórico e plotar
historico_tempo = np.linspace(0, tempo_total_sim, num_passos)
historico_erro_fase = np.zeros(num_passos)
historico_freq_nco = np.zeros(num_passos)

for i in range(num_passos):
    # 1. Avanço da fase real do sinal (Sensor)
    fase_entrada += 2.0 * np.pi * f_real_sinal * Ts
    fase_entrada = np.mod(fase_entrada, 2.0 * np.pi)
    
    # 2. Avanço da fase gerada pelo NCO
    freq_total_nco = f_chute_nco + nco_freq_mod
    fase_nco += 2.0 * np.pi * freq_total_nco * Ts
    fase_nco = np.mod(fase_nco, 2.0 * np.pi)
    
    # 3. Detector de Fase (Multiplicador / Erro de Fase Bruto)
    erro_fase = np.sin(fase_entrada - fase_nco)
    
    # 4. Filtro de Loop (PI) usando os ganhos calculados
    integrador_pi += erro_fase * Ki_dig
    nco_freq_mod = (erro_fase * Kp) + integrador_pi
    
    # Guardar dados para análise
    historico_erro_fase[i] = erro_fase
    historico_freq_nco[i] = freq_total_nco

# Avaliação do resultado
freq_final_pós_lock = historico_freq_nco[-1]
erro_fino_final = f_real_sinal - freq_final_pós_lock

print("\n" + "="*60)
print(" RESULTADO DA SIMULAÇÃO DE TRANCAGEM")
print("="*60)
print(f"Erro de Frequência Inicial : 40.00 Hz")
print(f"Frequência Final do NCO    : {freq_final_pós_lock:.4f} Hz")
print(f"Erro Residual Pós-Lock     : {erro_fino_final:.6f} Hz")
if abs(erro_fino_final) < 0.01:
    print("STATUS                     : TRANCADO COM SUCESSO!")
else:
    print("STATUS                     : FALHA NO LOCK")
print("="*60)

try:
    import matplotlib.pyplot as plt
    
    plt.figure(figsize=(10, 6))
    
    # Gráfico de Convergência de Frequência
    plt.subplot(2, 1, 1)
    plt.plot(historico_tempo * 1000, historico_freq_nco, 'b-', label='Frequência do NCO')
    plt.axhline(y=f_real_sinal, color='r', linestyle='--', label='Frequência Real (Alvo)')
    plt.title('Simulação Dinâmica da PLL trancando o erro de 40 Hz')
    plt.ylabel('Frequência (Hz)')
    plt.grid(True)
    plt.legend()
    
    # Gráfico do Erro de Fase (Tem de convergir para zero)
    plt.subplot(2, 1, 2)
    plt.plot(historico_tempo * 1000, historico_erro_fase, 'g-')
    plt.xlabel('Tempo (ms)')
    plt.ylabel('Erro de Fase (rad)')
    plt.grid(True)
    
    plt.tight_layout()
    plt.show()
except ImportError:
    print("\n[Nota] Instala o 'matplotlib' para veres os gráficos das curvas de lock.")



