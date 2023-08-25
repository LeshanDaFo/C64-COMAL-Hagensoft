; ###############################################################
; #                                                             #
; #  matunit.asm for                                            #
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
INF3    =   $3a
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d

COPY3   =   $49                 ;work For copy: length

RUNERR  =   $c9fb               ;go to comal error handler

; used in other matrix parts

; L8360     used in matnull
; L81e9     used in matput
; L81f3     used in matput

; $8379
    lda #$01
    jsr L81f3                   ;matput
    bcc L8383
    jmp L81e9                   ;matput
---------------------------------
L8383
    clc
    adc #$05
    sta COPY3                   ;work For copy: length
    stx INF1                    ;used for operand checking
    cpy INF1                    ;used for operand checking
    bne L83b3
    sty INF2                    ;used for operand checking
    sty INF3                    ;used for operand checking
    lda Q1+1
    ldy Q1
    sta Q2+1
    sty Q2
    jsr L8360                   ;matnull
L839d
    ldy #$00
    lda #$81
    sta (Q2),y
    clc
    lda Q2
    adc COPY3                   ;work For copy: length
    sta Q2
    bcc L83ae
    inc Q2+1
L83ae
    dec INF3                    ;used for operand checking
    bne L839d
    rts
---------------------------------
L83b3
    ldx #$27
    jmp RUNERR                  ;go to comal error handler

; $83b8