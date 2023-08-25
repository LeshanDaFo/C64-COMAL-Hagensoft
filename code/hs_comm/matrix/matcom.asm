; ###############################################################
; #                                                             #
; #  matcom.asm for                                             #
; #  C64 COMAL80 HAGENSOFT EXTENSION SOURCE CODE                #
; #  Version 1.0 (2023.08.25)                                   #
; #  Copyright (c) 2023 Claus Schlereth                         #
; #                                                             #
; #  This version of the source code is under MIT License       #
; #                                                             #
; #  This source code can be found at:                          #
; #  https://github.com/LeshanDaFo/C64-COMAL-Hagensoft          #
; #  This source code is bsed on the existing Modules           #
; #  found in several locations in the Internet                 #
; #                                                             #
; ###############################################################

;used comal system addresses
;INFx used for operand checking
INF1    =   $38
INF2    =   $39               
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f

COPY1   =   $45                 ;work for copy: from
TXTHI   =   $7d                 ;address of text for print

TXT     =   $c760               ;string constant buffer
LDAC1   =   $c890               ;load ac1
STAC1   =   $c8f6               ;store ac1
FPMUL   =   $c8cc               ;load ac2 and mul ac2 by ac1
FPADD   =   $c8ab               ;load ac2 and add ac2 to ac1
FNDPAR  =   $c896               ;find parameter (asm. calls)

; used in other matrix parts

; L81ee     used in matput
; L81f3     used in matput

; $8298
    lda #$01
    jsr FNDPAR                  ;find parameter (asm. calls)
    ldy #$04
L829f
    lda (COPY1),y               ;work For copy: From
    sta TXT,y
    dey
    bpl L829f
    lda #$03
    jsr FNDPAR                  ;find parameter (asm. calls)
    ldy #$04
L82ae
    lda (COPY1),y               ;work For copy: From
    sta TXT+5,y                 ;string constant buffer
    dey
    bpl L82ae
    lda #$02
    jsr L81f3                   ;matput
    stx INF1                    ;used for operand checking
    sty INF2                    ;used for operand checking
    lda Q1
    ldy Q1+1
    sta Q3
    sty Q3+1
    lda #$04
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    beq L82d3
L82d0
    jmp L81ee                   ;matput
---------------------------------
L82d3
    cpy INF2                    ;used for operand checking
    bne L82d0
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda #$05
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    bne L82d0
    cpy INF2                    ;used for operand checking
    bne L82d0
L82ec
    lda INF2                    ;used for operand checking
    sta TXTHI                   ;address of text for print
L82f0
    ldy Q3+1
    lda Q3
    jsr LDAC1                   ;load ac1
    ldy #$c7
    lda #$60
    jsr FPMUL                   ;load ac2 and mul ac2 by ac1
    ldy #$c7
    ldx #$6a
    jsr STAC1                   ;store ac1
    ldy Q2+1
    lda Q2
    jsr LDAC1                   ;load ac1
    ldy #$c7
    lda #$65
    jsr FPMUL                   ;load ac2 and mul ac2 by ac1
    ldy #$c7
    lda #$6a
    jsr FPADD                   ;load ac2 and add ac2 to ac1
    ldy Q1+1
    ldx Q1
    jsr STAC1                   ;store ac1
    jsr L8333
    jsr L833f
    jsr L834b
    dec TXTHI                   ;address of text for print
    bne L82f0
    dec INF1                    ;used for operand checking
    bne L82ec
    rts
---------------------------------
L8333
    clc
    lda Q1
    adc #$05
    sta Q1
    bcc L833e
    inc Q1+1
L833e
    rts
---------------------------------
L833f
    clc
    lda Q2
    adc #$05
    sta Q2
    bcc L834a
    inc Q2+1
L834a
    rts
---------------------------------
L834b
    clc
    lda Q3
    adc #$05
    sta Q3
    bcc L834a
    inc Q3+1
    rts

; $8357