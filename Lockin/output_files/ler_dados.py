import csv
import os
import matplotlib.pyplot as plt

diretorio_atual = os.path.dirname(os.path.abspath(__file__))
caminho_completo = os.path.join(diretorio_atual, 'teste.csv')

# 1. Ler o ficheiro para uma lista de linhas na memória
linhas_validas = []

"""
with open(caminho_completo, mode='r', encoding='utf-8') as ficheiro:
    # Saltamos as primeiras linhas de metadados até chegar ao cabeçalho real
    # Se o teu cabeçalho estiver exatamente na linha 6 (skiprows=5), saltamos 5
       
    leitor = csv.reader(ficheiro)
    
    # Lemos o cabeçalho para descobrir a posição de cada coluna
    cabecalho = [col.strip() for col in next(leitor)]
    
    idx_temp = cabecalho.index('s')
    idx_dado = cabecalho.index('adc_data[0..11]')
    idx_canal = cabecalho.index('adc_channel[0..2]')
    idx_start = cabecalho.index('adc_start')
    idx_update_pulso = cabecalho.index('lockin_update_pulse')
    
    # Guardamos apenas as linhas que NÃO têm 'XXX' no dado
    for linha in leitor:
        if linha and linha[idx_dado].strip() != 'XXX':
            linhas_validas.append([col.strip() for col in linha])

# 2. Ciclo que anda pelo ÍNDICE da linha (começa em 1 para ver a anterior)
dados_salvos = []
temp = []
for i in range(1, len(linhas_validas)):
    linha_atual = lines_validas = linhas_validas[i]
    linha_anterior = linhas_validas[i - 1]
    
    # Filtro 1: Garantir que o canal atual é 1
    # (Convertemos para inteiro para garantir a comparação correta)
    if int(linha_atual[idx_canal]) == 1:
        
        # Filtro 2: Transição do adc_start (anterior era 0 e atual é 1)
        if (int(linha_anterior[idx_start]) == 0 and int(linha_atual[idx_start]) == 1):
            
            # Converte o Hexadecimal atual para Decimal e guarda
            valor_hex = linha_anterior[idx_dado]
            dados_salvos.append(int(valor_hex, 16))
            temp.append(int(linha_anterior[idx_temp]))
#    elif int(linha_atual[idx_update_pulso])==1:
 #           valor_hex = linha_atual[idx_dado]
 #           dados_salvos.append(int(valor_hex, 16))
 #           temp.append(int(linha_atual[idx_temp]))
"""


"""
with open(caminho_completo, mode='r', encoding='utf-8') as ficheiro:
    # Saltamos as primeiras linhas de metadados até chegar ao cabeçalho real
    # Se o teu cabeçalho estiver exatamente na linha 6 (skiprows=5), saltamos 5
       
    leitor = csv.reader(ficheiro)
    
    # Lemos o cabeçalho para descobrir a posição de cada coluna
    cabecalho = [col.strip() for col in next(leitor)]
    
    idx_temp = cabecalho.index('s')
    idx_dado = cabecalho.index('ref_1[0]')
    #idx_dado = cabecalho.index('adc_data[0..11]')
    #idx_canal = cabecalho.index('adc_channel[0..2]')
    idx_start = cabecalho.index('adc_start')
    idx_update_pulso = cabecalho.index('lockin_update_pulse')
    nomes_colunas_bits = [
    'ref_1[11]', 'ref_1[10]', 'ref_1[9]', 'ref_1[8]', 'ref_1[7]', 'ref_1[6]', 
    'ref_1[5]', 'ref_1[4]', 'ref_1[3]', 'ref_1[2]', 'ref_1[1]', 'ref_1[0]'
    ]

    # Descobre em que posição do CSV está cada bit
    indices_bits = [cabecalho.index(nome) for nome in nomes_colunas_bits]

    # Guardamos apenas as linhas que NÃO têm 'XXX' no dado
    for linha in leitor:
        if linha and linha[idx_dado].strip() != 'X':
            linhas_validas.append([col.strip() for col in linha])

# 2. Ciclo que anda pelo ÍNDICE da linha (começa em 1 para ver a anterior)
dados_salvos = []
temp = []
for i in range(1, len(linhas_validas)):
    linha_atual = linhas_validas[i]
    
    if int(linha_atual[idx_update_pulso])==1:
            binario_junto = ""
            for idx in indices_bits:
                bit = linha_atual[idx]
                binario_junto += bit

            dados_salvos.append(int(binario_junto, 2))
            temp.append(int(linha_atual[idx_temp]))

"""
def hex_to_signed_12bit(hex_str):
    val = int(hex_str, 16)
    # Se o bit mais significativo (bit 11) estiver a 1, o número é negativo
    if val & (1 << 11): 
        val = val - (1 << 12) # Converte para o valor negativo real
    return val

dados_salvos = []
temp = []
with open(caminho_completo, mode='r', encoding='utf-8') as ficheiro:
    # Saltamos as primeiras linhas de metadados até chegar ao cabeçalho real
    # Se o teu cabeçalho estiver exatamente na linha 6 (skiprows=5), saltamos 5
       
    leitor = csv.reader(ficheiro)
    
    # Lemos o cabeçalho para descobrir a posição de cada coluna
    cabecalho = [col.strip() for col in next(leitor)]
    
    idx_temp = cabecalho.index('s')
    idx_dado = cabecalho.index('nco_cos[0..11]')
    #idx_canal = cabecalho.index('adc_channel[0..2]')
    #idx_start = cabecalho.index('adc_start')
    idx_update_pulso = cabecalho.index('lockin_update_pulse')

    # Guardamos apenas as linhas que NÃO têm 'XXX' no dado
    for linha in leitor:
        if linha and linha[idx_dado].strip() != 'XXX':
            linhas_validas.append([col.strip() for col in linha])

# 2. Ciclo que anda pelo ÍNDICE da linha (começa em 1 para ver a anterior)
dados_salvos = []
temp = []
for i in range(1, len(linhas_validas)):
    linha_atual = linhas_validas[i]
    
    if int(linha_atual[idx_update_pulso])==1:
        valor_hex = linha_atual[idx_dado]
        dados_salvos.append(hex_to_signed_12bit(valor_hex))
        temp.append(int(linha_atual[idx_temp]))


# --- Resultado Final ---

print(temp)
print(dados_salvos)

plt.plot(temp, dados_salvos)
plt.show()

print(int("C83AB", 16))
print(5e4*int("C83AB", 16)/2**32)

