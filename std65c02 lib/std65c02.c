#include <std65c02.h>

void lcd_print_string(char * str){
    char i=0;
    while (str[i]!='\0'){
        lcd_print_char(str[i]);
        ++i;
    }
}

void acia_send_string(char * str){
    char i=0;
    while (str[i]!='\0'){
        acia_write_tx_buffer(str[i]);
        ++i;
    }
}

void stop_cpu(){
    while(1);
}

void delay(int s){
    int i, j;
    for (i=0; i<s; i++){
        for(j=0; j<DELAYCNT; j++);
    }
}
