; ###############################################################
; #                                                             #
; #  nullmat.asm for                                            #
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

INTFPA  =   $c9d7               ;float and push integer (0 .. 65535)

; used in other matrix parts

; L81f3     used in matput
; L8333     used in matcom

; $84b8
    lda #$01
    jsr L81f3                   ;matput
    stx INF1                    ;used for operand checking
    sty INF2                    ;used for operand checking
    ldy #$00
L84c3
    ldx INF1                    ;used for operand checking
L84c5
    lda (Q1),y
    bne L84d6
    jsr L8333                   ;matcom
    dex
    bne L84c5
    dec INF2                    ;used for operand checking
    bne L84c3
L84d3
    lda #$01
    !by $2C
L84d6
    lda #$00
    ldx #$00
    jmp INTFPA                  ;float and push integer (0 .. 65535)

; $84dd