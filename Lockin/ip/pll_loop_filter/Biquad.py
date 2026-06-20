import numpy as np

Fs = 160000.0         # Frequência de amostragem da FPGA (160 kHz)
Ts = 1.0 / Fs

# Especificações dinâmicas baseadas no teu Loop Bandwidth (BW = 5 Hz)
beta = 5.0           
fz = beta             # O Zero cola no Beta (5 Hz) para dar estabilidade
fc = 6.0 * beta       # O Corte fica em 30 Hz para filtrar o ruído
zeta_filtro = 0.707   # Amortecimento crítico para o denominador

print("="*60)
print(" ESPECIFICAÇÕES DO FILTRO ANÁLOGO ")
print("="*60)
print(f"Frequência de Amostragem (Fs) : {Fs/1000:.1f} kHz")
print(f"Corte do Filtro (Polos fc)    : {fc:.1f} Hz")
print(f"Zero do Lead-Lag (fz)         : {fz:.1f} Hz")

# 2. PROJETO DO FILTRO NO DOMÍNIO-S (TEMPO CONTÍNUO)
# H(s) = (G * (1 + s/wz)) / (s^2 + 2*zeta*wc*s + wc^2)
# Multiplicamos por wc^2 no numerador para ganho unitário em DC (0 Hz)
wc = 2.0 * np.pi * fc
wz = 2.0 * np.pi * fz

# Coeficientes da Função de Transferência Analógica:
# Num(s) = B1_s * s + B0_s
# Den(s) = A2_s * s^2 + A1_s * s + A0_s
B1_s = (wc**2) / wz
B0_s = wc**2

A2_s = 1.0
A1_s = 2.0 * zeta_filtro * wc
A0_s = wc**2

# 3. MAPEAMENTO DIGITAL VIA TRANSFORMADA BILINEAR (S -> Z)
# Aplicando Pre-Warping na frequência angular para compensar a distorção bilinear
# (Embora a 160kHz para 30Hz o efeito seja minúsculo, mantém o rigor matemático)
wd_c = 2.0 * Fs * np.tan(wc / (2.0 * Fs))

# Substituição Bilinear: s = K * (z-1)/(z+1) onde K = 2/Ts
K = 2.0 / Ts

# Constante de normalização (Denominador comum d0)
d0 = A2_s*(K**2) + A1_s*K + A0_s

# Coeficientes Digitais em Ponto Flutuante (Normalizados por d0)
# Nota: biquad_out = (b0*in + b1*in*z^-1 + b2*in*z^-2) - (a1*out*z^-1 + a2*out*z^-2)
b0 = (B1_s*K + B0_s) / d0
b1 = (2.0*B0_s) / d0
b2 = (-B1_s*K + B0_s) / d0
a1 = (2.0*A0_s - 2.0*A2_s*(K**2)) / d0
a2 = (A2_s*(K**2) - A1_s*K + A0_s) / d0

# 4. CONVERSÃO PARA PONTO FIXO Q18 (A TUA WINDOWS [45:18])
# Como o teu código Verilog trunca a saída fazendo: d_biquad_out <= y_full[45:18];
# Significa que o teu fator de escala implícito é 2^18.
Q_FACTOR = 2**18

b0_q18 = int(round(b0 * Q_FACTOR))
b1_q18 = int(round(b1 * Q_FACTOR))
b2_q18 = int(round(b2 * Q_FACTOR))

a1_q18 = int(round(a1 * Q_FACTOR))
a2_q18 = int(round(a2 * Q_FACTOR))

# Função auxiliar para exibir o Hexadecimal assinado de 32 bits corretamente
def to_hex32(val):
    return f"32'h{val & 0xFFFFFFFF:08X}"

print("\n" + "="*60)
print(" COEFICIENTES EM PONTO FIXO Q18 PARA A TUA FPGA ")
print("="*60)
print(f"b0_gain: {b0_q18:8d}  ->  {to_hex32(b0_q18)}")
print(f"b1_gain: {b1_q18:8d}  ->  {to_hex32(b1_q18)}")
print(f"b2_gain: {b2_q18:8d}  ->  {to_hex32(b2_q18)}")
print("-"*60)
print(f"a1_gain: {a1_q18:8d}  ->  {to_hex32(a1_q18)}")
print(f"a2_gain: {a2_q18:8d}  ->  {to_hex32(a2_q18)}")
print("="*60)

# Verificação de Ganho DC Estático (Deve ser próximo de 1.0)
ganho_dc = (b0 + b1 + b2) / (1.0 + a1 + a2)
print(f"\n[Validação] Ganho DC do Filtro Calculado: {ganho_dc:.4f} (Ideal: 1.0)")