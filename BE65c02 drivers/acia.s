.export  _acia_write_tx_buffer, _acia_init, _acia_check_rx_buffer, _acia_read_rx_buffer
.import  __ACIA_DATA__, __ACIA_STATUS__, __ACIA_CMD__, __ACIA_CTRL__ ; Defined in breadboard.cfg

.segment "CODE"

_acia_init:
    pha
    lda #00
    sta __ACIA_STATUS__

    lda #%00011111
    sta __ACIA_CTRL__

    lda #$89
    sta __ACIA_CMD__
    pla
    rts

_acia_check_rx_buffer:
    lda __ACIA_STATUS__
    and #$08
    rts

acia_wait_tx_buffer:
    pha
_acia_wait:
    lda __ACIA_STATUS__
    and #$10
    beq _acia_wait 
    pla
    rts

_acia_read_rx_buffer:
    lda __ACIA_DATA__
    rts

_acia_write_tx_buffer:
    jsr acia_wait_tx_buffer
    sta __ACIA_DATA__
    rts