#ifndef STD6502_H
#define STD6502_H

//Clock frequency in KHz
#define CLOCKFRQ 1843
#define DELAYCNT CLOCKFRQ/86


//ACIA

//initializes ACIA interface
extern void acia_init();

//writes a char byte to the ACIA tx buffer
extern void acia_write_tx_buffer(char c);

//sends a string to the acia
void acia_send_string(char *str);

//checks if ACIA received a byte;
//returns 0 if empty, 8 if full
extern unsigned char acia_check_rx_buffer();

//reads a byte from ACIA;
//returns red value as unsigned char
extern unsigned char acia_read_rx_buffer();




//LCD

//initializes lcd in 8bit-mode 
extern void lcd_init();

//sends a character to the lcd
extern void lcd_print_char(char c);

//sends a string to the lcd
void lcd_print_string(char *str);


//MEMORY

//works as STA
//stores given byte at given 16bit address
#define STA(addr, byte) (*(char *)addr = byte)

//works as LDA
//stores in given variable the byte in given 16bit address
#define LDA(addr, dest) (dest = *(char *)addr)



//Service

//halts 65c02
void stop_cpu();

//delayes for [s] milliseconds **NOT EXTREMELY ACCURATE**
void delay(int s);

#endif