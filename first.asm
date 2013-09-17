    .inesprg 1
    .ineschr 1
    .inesmir 1
    .inesmap 0

    .bank 1
    .org $FFFA
    .dw 0
    .dw Start ; define Start as address of reset handler
    .dw 0

    .bank 0
    .org $8000

Start:
    lda #%00001000
    sta $2000
    lda #%00011110
    sta $2001

    ldx #$00

    lda #$3F
    sta $2006
    lda #$00
    sta $2006

loadPalette:
    lda tilepal,x ; offset mode, tilepal + x
    sta $2007
    inx
    cpx #32
    bne loadPalette

waitBlank:
    lda $2002 ; conveniently, vblank gets loaded into bit 7
    bpl waitblank ; bpl = branch if sign flag = 0
                    ; if sign = 0, then it isn't vblank
    
    lda #$00 ; write 0000 to OAMADDR 
    sta $2003
    lda #$00
    sta $2003 ; OAMADDR set to 0000

    lda #50 ; y
    sta $2004
    lda #$00 ;Tile
    sta $2004
    lda #$00 ;Junk
    sta $2004
    lda #20 ; X --the fuck
    sta $2004

loop:
    jmp loop

tilepal: .incbin "palette"

    .bank 2
    .org $0000
    .incbin "background"
    .incbin "sprite"


