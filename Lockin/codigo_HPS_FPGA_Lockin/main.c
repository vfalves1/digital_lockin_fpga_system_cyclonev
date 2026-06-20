/*
This program demonstrate how to use hps communicate with FPGA through light AXI Bridge.
uses should program the FPGA by GHRD project before executing the program
refer to user manual chapter 7 for details about the demo
*/


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
    volatile unsigned int *mag_ptr = (unsigned int *)(virtual_base + PIO_MAGNITUDE_BASE);
    volatile int *fase_ptr = (int *)(virtual_base + PIO_FASE_BASE); // int para manter o sinal (positivo/negativo)

	double amp_adc_max = 4095.0;
	double amp_nco_max = 2047; // 12-bit NCO
	double ganho_filtros = 1048576.0; // 2^20 (10 bits + 10 bits)
	double ganho_cordic = 1.64676;
	double fator_mixer = 0.5;

	double escala_full_digital = amp_adc_max * amp_nco_max * ganho_filtros;
    printf("--- Lendo Magnetómetro (Lock-in) ---\n");

    while(1) {
        // 3. Ler os valores diretamente dos registadores da FPGA
        unsigned int mag = *mag_ptr;
        int fase = *fase_ptr;

		double valor_escala_adc = (double)mag / escala_full_digital;
    	double voltagem_real = valor_escala_adc * 4.096; 

        double fase_graus = (double)((int)fase) * 180.0 / (pow(2, 25));
        //double fase_graus = (double)(( (long long)fase * 180 ) >> 25);

        printf("Magnitude: %u | Fase: %u\n", mag, fase);
    	printf("Sinal Real: %.4f V | Fase: %8.2f deg\n", voltagem_real, fase_graus);
        // Isto faz com que o próximo ciclo escreva exatamente no mesmo sítio
        //printf("\033[2A");
        fflush(stdout);
        usleep(1000000); 

    }

    return 0;
}

