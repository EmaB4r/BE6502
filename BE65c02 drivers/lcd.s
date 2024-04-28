.export  _lcd_init, _lcd_print_char
.import  __DDRA__, __DDRB__, __PORTA__, __PORTB__ ; Defined in breadboard.cfg

.segment "CODE"
DISPLAY_E = %10000000
DISPLAY_RW = %01000000
DISPLAY_RS = %00100000
NEWLINE_INSTR= %11000000


;   checks if the lcd busy flag is set
lcd_check_busy:
    pha ; to not change the accumulator pushes it's contents on the stack
    lda #%00000000
    sta __DDRB__
_lcd_read_busy:
    lda #DISPLAY_RW
    sta __PORTA__
    lda #(DISPLAY_RW | DISPLAY_E)
    sta __PORTA__
    lda __PORTB__
    and #%10000000
    bne _lcd_read_busy
    lda #DISPLAY_RW
    sta __PORTA__
    lda #%11111111
    sta __DDRB__
    pla
    rts

;   sends an instruction loaded in the accumulator to the lcd
lcd_send_instruction:
    jsr lcd_check_busy
    sta __PORTB__   ; outputs instruction to register B
    lda #DISPLAY_E
    sta __PORTA__   ; turns HIGH E pin
    lda #$0
    sta __PORTA__   ; resets E pin
    rts

lcd_send_char:
;   sends a char loaded in the accumulator to the lcd
    jsr lcd_check_busy
    sta __PORTB__   ; outputs char to register B
    lda #DISPLAY_RS ; sets RS HIGH
    sta __PORTA__
    lda #(DISPLAY_E | DISPLAY_RS)
    sta __PORTA__
    lda #0
    sta __PORTA__
    rts


_lcd_init:
    pha
    lda #$ff
    sta __DDRB__    ; sets __DDRB__ as all outputs
    lda #$ff
    sta __DDRA__    ; sets __DDRA__ as all outputs
    lda #$0
    sta __PORTB__   ; clears __DDRB__ output
    sta __PORTA__   ; clears __DDRA__ output

    lda #%00111000  ; screen in 8bit operation, 2 lines, 5x8 chars
    jsr lcd_send_instruction

    lda #%00001100  ; turns on the display, cursor off, blinking off
    jsr lcd_send_instruction

    lda #%00000110  ; sets automatic char increment, no display shift
    jsr lcd_send_instruction

    lda #%00000001  ; clear display
    jsr lcd_send_instruction

    lda #%00000010  ; home
    jsr lcd_send_instruction
    pla
    rts

_lcd_print_char:
    jsr lcd_send_char
    rts
