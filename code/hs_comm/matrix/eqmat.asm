; ###############################################################
; #                                                             #
; #  eqmat.asm for                                              #
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

; used in other matrix parts

; L8333     used in matcom
; L833f     used in matcom
; L84d3     used in nullmat
; L84d6     used in nullmat

; $84dd
    lda #$01
    jsr L81f3                   ;matput
    stx INF1                    ;used for operand checking
    sty INF2                    ;used for operand checking
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda #$02
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    beq L84fa
L84f7
    jmp L84d6                   ;nullmat
---------------------------------
L84fa
    cpy INF2                    ;used for operand checking
    bne L84f7
L84fe
    ldx INF1                    ;used for operand checking
L8500
    ldy #$04
L8502
    lda (Q1),y
    cmp (Q2),y
    bne L851b
    dey
    bpl L8502
L850b
    jsr L8333                   ;matcom
    jsr L833f                   ;matcom
    dex
    bne L8500
    dec INF2                    ;used for operand checking
    bne L84fe
    jmp L84d3                   ;nullmat
---------------------------------
L851b
    ldy #$00
    lda (Q1),y
    ora (Q2),y
    bne L84f7
    beq L850b

; $8525