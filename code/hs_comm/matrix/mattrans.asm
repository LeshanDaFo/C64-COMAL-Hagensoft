; ###############################################################
; #                                                             #
; #  mattrans.asm for                                           #
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

COPY3   =   $49                 ;work For copy: length

; used in other matrix parts

; L81e9     used in matput
; L81ee     used in matput
; L81f3     used in matput
; L8333     used in matcom
; L833f     used in matcom

; $83b8
    lda #$02
    jsr L81f3                   ;matput
    bcc L83c2
    jmp L81e9                   ;matput
---------------------------------
L83c2
    stx INF1
    sty INF2
    sta COPY3                   ;work For copy: length
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda #$01
    jsr L81f3                   ;matput
    cpx INF2
    beq L83dc
L83d9
    jmp L81ee                   ;matput
---------------------------------
L83dc
    cpy INF1
    bne L83d9
L83e0
    lda Q2
    ldy Q2+1
    sta Q3
    sty Q3+1
    ldx INF1
L83ea
    ldy #$04
L83ec
    lda (Q1),y
    sta (Q3),y
    dey
    bpl L83ec
    clc
    lda Q3
    adc COPY3                   ;work For copy: length
    sta Q3
    bcc L83fe
    inc Q3+1
L83fe
    jsr L8333                   ;matcom
    dex
    bne L83ea
    jsr L833f                   ;matcom
    dec INF2
    bne L83e0
    rts

; $840c