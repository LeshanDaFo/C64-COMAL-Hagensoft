; ###############################################################
; #                                                             #
; #  matnull.asm for                                            #
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

TXTHI   =   $7d                 ;address of text for print

; used in other matrix parts

; L81f3     used in matput
; L8333     used in matcom

; $8357
    lda #$01
    jsr L81f3                   ;matput
    stx INF1                    ;used for operand checking
    sty INF2                    ;used for operand checking
L8360
    lda INF2                    ;used for operand checking
    sta TXTHI                   ;address of text for print
L8364
    ldy #$04
    lda #$00
L8368
    sta (Q1),y
    dey
    bpl L8368
    jsr L8333                   ;matcom
    dec TXTHI                   ;address of text for print
    bne L8364
    dec INF1                    ;used for operand checking
    bne L8360
    rts

; $8379