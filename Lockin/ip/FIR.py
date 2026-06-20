import os
import numpy as np
import scipy.signal as signal

diretorio_atual = os.path.dirname(os.path.abspath(__file__))
caminho_final = os.path.join(diretorio_atual, "coeficientes_fir_kaiser.txt")

# 1. Especificações do teu Lock-in
fs = 2500.0         # 2.5 kHz
cutoff_pass = 50.0    # Começa a cair aos 50 Hz
cutoff_stop = 100.0   # Já cortou tudo aos 100 Hz
attenuation = 80      # Atenuação de 60 dB na stopband

# 2. Calcular a banda de transição normalizada
width = (cutoff_stop - cutoff_pass) / (fs / 2.0)

# 3. Calcular automaticamente o número de taps e o Beta de Kaiser
numtaps, beta = signal.kaiserord(attenuation, width)

# Forçar o número de taps a ser ÍMPAR (obrigatório para filtros FIR simétricos lineares)
if numtaps % 2 == 0:
    numtaps += 1

print(f"Número de Taps calculado automaticamente: {numtaps}")
print(f"Parâmetro Beta de Kaiser calculado: {beta}")

# 4. Gerar os coeficientes
cutoff_center = (cutoff_pass + cutoff_stop) / 2.0
coeffs_float = signal.firwin(numtaps, cutoff_center / (fs / 2.0), window=('kaiser', beta))

# 5. Converter para inteiros de 16-bit para o Quartus (Sem ganho/escala automática do IP)
#coeffs_int = np.round(coeffs_float / np.max(np.abs(coeffs_float)) * 32767).astype(int)
coeffs_int = np.round(coeffs_float * 32767).astype(int)
#coeffs_pure = coeffs_float / np.max(np.abs(coeffs_float))

# 6. Gravar o ficheiro
linha_unica = ", ".join(map(str, coeffs_float))
with open(caminho_final, "w", encoding="utf-8") as f:
    f.write(linha_unica)