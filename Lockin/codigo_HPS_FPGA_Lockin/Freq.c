#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"


#define LWHPS2FPGA_BASE 0xff200000
#define HW_REGS_SPAN 0x00100000
#define HW_REGS_MASK (HW_REGS_SPAN - 1)

int main() {
    void *virtual_base;
    int fd;
    
    // 1. Abrir a memória do sistema
    if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
        printf("Erro: Não foi possível abrir /dev/mem\n");
        return 1;
    }
    
    // 2. Mapear a Lightweight Bridge
    virtual_base = mmap(NULL, HW_REGS_SPAN, PROT_READ | PROT_WRITE, MAP_SHARED, fd, LWHPS2FPGA_BASE);
    if (virtual_base == MAP_FAILED) {
        printf("Erro: mmap falhou\n");
        close(fd);
        return 1;
    }

    // Ponteiros para os dados da FPGA
    // volatile unsigned int *freq_ptr = (unsigned int *)(virtual_base + PIO_FREQ_BASE);
    volatile unsigned int *freq_ptr = (unsigned int *)((char *)virtual_base + PIO_FREQ_BASE);

    double f_clk = 50000000.0;          // Clock que alimenta o NCO (50 MHz)
    double n_bits = 32.0;               // Resolução do acumulador do NCO (ex: 32 bits)
    double divisor_nco = pow(2, n_bits); // 2^32 = 4294967296

    printf("--- Lendo Freq ---\n");
    int i=0;
    for(i=0;i<10;i++) {
        // 3. Ler os valores diretamente dos registadores da FPGA
        unsigned int m_valor = *freq_ptr;

        double frequencia_hz = ((double)m_valor * f_clk) / divisor_nco;

        printf("Valor na FPGA (M): %u \n", m_valor);
        printf("Frequência Real  : %.4f kHz\n", frequencia_hz / 1000.0);
        // Isto faz com que o próximo ciclo escreva exatamente no mesmo sítio
        //printf("\033[2A");
        fflush(stdout);
        usleep(1000000); 

    }
    munmap(virtual_base, HW_REGS_SPAN);
    close(fd);
    return 0;
}

