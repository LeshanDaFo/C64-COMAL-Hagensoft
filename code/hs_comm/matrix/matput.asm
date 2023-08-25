; ###############################################################
; #                                                             #
; #  matput.asm for                                             #
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
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d

COPY1   =   $45                 ;work for copy: from
COPY2   =   $47                 ;work For copy: to
COPY3   =   $49                 ;work For copy: length

TXTHI   =   $7d                 ;address of text for print


FNDPAR  =   $c896               ;find parameter (asm. calls)
RUNERR  =   $c9fb               ;go to comal error handler


; $81ad
    lda #$01
    jsr L81f3
    bcs L81e9
    sta COPY3                   ;work For copy: length
    stx INF1                    ;used for operand checking
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda #$02
    jsr L81f3
    cmp COPY3                   ;work For copy: length
    bne L81ee
    cpx INF1                    ;used for operand checking
    bne L81ee
    ldy #$00
L81cf
    ldx COPY3                   ;work For copy: length
L81d1
    lda (Q1),y
    sta (Q2),y
    inc Q1
    bne L81db
    inc Q1+1
L81db
    inc Q2
    bne L81e1
    inc Q2+1
L81e1
    dex
    bne L81d1
    dec INF1                    ;used for operand checking
    bne L81cf
    rts
---------------------------------
L81e9
    ldx #$25
    jmp RUNERR                  ;go to comal error handler
---------------------------------
L81ee
    ldx #$26
    jmp RUNERR                  ;go to comal error handler
---------------------------------
L81f3
    jsr FNDPAR                  ;find parameter (asm. calls)
    ldy #$01
L81f8
    lda (COPY1),y               ;work For copy: From
    sta $003b,y
    dey
    bpl L81f8
    ldy #$03
    jsr L8222
    cmp #$01
    bne L81e9
    jsr L8222
    tax
    jsr L8222
    cmp #$01
    bne L81e9
    jsr L8222
    tay
    sty TXTHI                   ;address of text for print
    tya
    asl
    asl
    adc TXTHI                   ;address of text for print
    cpy #$33
    rts
---------------------------------
L8222
    lda (COPY1),y               ;work For copy: From
    bne L81e9
    iny
    lda (COPY1),y               ;work For copy: From
    iny
    rts

; $822b