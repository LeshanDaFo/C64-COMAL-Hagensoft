; ###############################################################
; #                                                             #
; #  matadd.asm for                                             #
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

TXTLO   =   $7c
TXTHI   =   $7d                 ;address of text for print

LDAC1   =   $c890               ;load ac1
STAC1   =   $c8f6               ;store ac1

; used in other matrix parts

; L81ee     used in matput
; L81f3     used in matput

; $822b
    lda #$ab
    !by $2C
; $822e
matsub
    lda #$c0
    sta MOVEAD+1                ;address for move
    lda #$c8
    sta TXTLO                   ;address of text for prixt
    lda #$4c
    sta MOVEAD                  ;address for move
    lda #$01
    jsr L81f3                   ;matput
    stx INF1                    ;used for operand checking
    sty INF2                    ;used for operand checking
    lda Q1
    ldy Q1+1
    sta Q3
    sty Q3+1
    lda #$02
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    bne L81ee                   ;matput
    cpy INF2                    ;used for operand checking
    bne L81ee                   ;matput
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda #$03
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    bne L81ee                   ;matput
    cpy INF2                    ;used for operand checking
    bne L81ee                   ;matput
L826d
    lda INF2                    ;used for operand checking
    sta TXTHI                   ;address of text for print
L8271
    ldy Q3+1
    lda Q3
    jsr LDAC1                   ;load ac1
    ldy Q2+1
    lda Q2
    jsr $007a                   ;jar MOVEAD
    ldy Q1+1
    ldx Q1
    jsr STAC1                   ;store ac1
    jsr L8333
    jsr L833f
    jsr L834b
    dec TXTHI                   ;address of text for print
    bne L8271
    dec INF1                    ;used for operand checking
    bne L826d
    rts

; $8298