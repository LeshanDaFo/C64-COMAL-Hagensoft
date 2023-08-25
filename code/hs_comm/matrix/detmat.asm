; ###############################################################
; #                                                             #
; #  detmat.asm for                                             #
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
INF2    =   $39               
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f
Q4      =   $41

COPY2   =   $47                 ;work For copy: to
COPY3   =   $49                 ;work For copy: length

TXTHI   =   $7d                 ;address of text for print


TXT     =   $c760               ;string constant buffer
LDAC1   =   $c890               ;load ac1
FPDIV   =   $c8d8               ;load ac2 and div ac2 by ac1
FPNEG   =   $c90b               ;negate ac1
STAC1   =   $c8f6               ;store ac1
FPMUL   =   $c8cc               ;load ac2 and mul ac2 by ac1
FPADD   =   $c8ab               ;load ac2 and add ac2 to ac1
PUSHRL  =   $c9c5               ;push real number

; used in other matrix parts

; L81e9     used in matput
; L81f3     used in matput
; L8333     used in matcom
; L833f     used in matcom
; L83b3     used in matunit
; L834b     used in matcom
; L84d6     used in nullmat

; $8524
    lda #$01
    jsr L81f3                   ;matput
    bcc L852f
    jmp L81e9                   ;matput
---------------------------------
L852f
    sta COPY3                   ;work For copy: length
    stx INF2                    ;used for operand checking
    cpy INF2                    ;used for operand checking
    beq L853a
    jmp L83b3                   ;matunit
---------------------------------
L853a
    ldy #$04
    lda #$00
L853e
    sta TXT,y                   ;string constant buffer
    dey
    bne L853e
    lda #$81
    sta TXT                     ;string constant buffer
    lda INF2                    ;used for operand checking
    sta TXTHI                   ;address of text for print
L854d
    ldy #$00
    lda (Q1),y
    bne L8575
    ldx TXTHI                   ;address of text for print
    lda Q1
    sta Q4
    lda Q1+1
    sta Q4+1
L855d
    lda (Q4),y
    bne L8572
    clc
    lda Q4
    adc COPY3                   ;work For copy: length
    sta Q4
    bcc L856c
    inc Q4+1
L856c
    dex
    bne L855d
    jmp L84d6                   ;nullmat
---------------------------------
L8572
    jsr L8627
L8575
    ldy Q1+1
    lda Q1
    sty Q4+1
    sta Q4
    lda TXTHI                   ;address of text for print
    sta COPY2+1                 ;work For copy: to
L8581
    dec COPY2+1                 ;work For copy: to
    beq L85e1
    clc
    lda Q4
    adc COPY3                   ;work For copy: length
    sta Q4
    bcc L8590
    inc Q4+1
L8590
    ldy Q1+1
    lda Q1
    jsr LDAC1                   ;load ac1
    ldy Q4+1
    lda Q4
    jsr FPDIV                   ;load ac2 and div ac2 by ac1
    jsr FPNEG                   ;negate ac1
    ldy #$c7
    ldx #$65
    jsr STAC1                   ;store ac1
    lda TXT+5                   ;string constant buffer5
    cmp #$84
    bcc L85b5
    jsr L8627
    jmp L8590
---------------------------------
L85b5
    jsr L8612
L85b8
    dec COPY2                   ;work For copy: to
    beq L8581
    jsr L833f                   ;matcom
    jsr L834b                   ;matcom
    ldy #$c7
    lda #$65
    jsr LDAC1                   ;load ac1
    ldy Q2+1
    lda Q2
    jsr FPMUL                   ;load ac2 and mul ac2 by ac1
    ldy Q3+1
    lda Q3
    jsr FPADD                   ;load ac2 and add ac2 to ac1
    ldy Q3+1
    ldx Q3
    jsr STAC1                   ;store ac1
    jmp L85b8
---------------------------------
L85e1
    ldy Q1+1
    lda Q1
    jsr LDAC1                   ;load ac1
    ldy #$c7
    lda #$60
    jsr FPMUL                   ;load ac2 and mul ac2 by ac1
    ldy #$c7
    ldx #$60
    jsr STAC1                   ;store ac1
    clc
    lda Q1
    adc COPY3                   ;work For copy: length
    sta Q1
    bcc L8601
    inc Q1+1
L8601
    jsr L8333                   ;matcom
    dec TXTHI                   ;address of text for print
    beq L860b
    jmp L854d
---------------------------------
L860b
    lda #$c7
    ldx #$60
    jmp PUSHRL                  ;push real number
---------------------------------
L8612
    lda Q1
    ldy Q1+1
    sta Q2
    sty Q2+1
    lda Q4
    ldy Q4+1
    sta Q3
    sty Q3+1
    lda TXTHI                   ;address of text for print
    sta COPY2                   ;work For copy: to
    rts
---------------------------------
L8627
    jsr L8612
L862a
    ldy Q2+1
    lda Q2
    jsr LDAC1                   ;load ac1
    ldy Q3+1
    lda Q3
    jsr FPADD                   ;load ac2 and add ac2 to ac1
    ldy Q2+1
    ldx Q2
    jsr STAC1                   ;store ac1
    jsr L833f                   ;matcom
    jsr L834b                   ;matcom
    dec COPY2                   ;work For copy: to
    bne L862a
    rts