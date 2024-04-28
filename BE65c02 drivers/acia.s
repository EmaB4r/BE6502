.export  _acia_write_tx_buffer, _acia_init, _acia_check_rx_buffer, _acia_read_rx_buffer
.import  __ACIA_DATA__, __ACIA_STATUS__, __ACIA_CMD__, __ACIA_CTRL__

.segment "CODE"

;initializes ACIA 
;MOD: none
_acia_init:
    pha
    lda #00
    sta __ACIA_STATUS__

    lda #$1F
    sta __ACIA_CTRL__

    lda #$8B
    sta __ACIA_CMD__
    pla
    rts

;checks rx buffer
;MOD: A
_acia_check_rx_buffer:
    lda __ACIA_STATUS__
    and #$08
    rts

;loops until tx buffer is empty
;MOD: none
acia_wait_tx_buffer:
    pha
_acia_wait:
    lda __ACIA_STATUS__
    and #$10
    beq _acia_wait 
    pla
    rts

;reads a byte from rx buffer
;MOD: A
_acia_read_rx_buffer:
    lda __ACIA_DATA__
    rts

;writes a byte to tx buffer
;MOD: none
_acia_write_tx_buffer:
    jsr acia_wait_tx_buffer
    sta __ACIA_DATA__
    rts