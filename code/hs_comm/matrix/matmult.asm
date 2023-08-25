; ###############################################################
; #                                                             #
; #  matmult.asm for                                            #
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
;Q1 .. Q5 = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f
Q4      =   $41
Q5      =   $43

COPY2   =   $47                 ;work For copy: to
COPY3   =   $49                 ;work For copy: length
MOVEAD  =   $7a                 ;address for move

LDAC1   =   $c890               ;load ac1
STAC1   =   $c8f6               ;store ac1
FPMUL   =   $c8cc               ;load ac2 and mul ac2 by ac1
FPADD   =   $c8ab               ;load ac2 and add ac2 to ac1

; used in other matrix parts

; L81e9     used in matput
; L81ee     used in matput
; L81f3     used in matput
; L8333     used in matcom
; L833f     used in matcom
; L834b     used in matcom

; $840c
    lda #$01
    jsr L81f3                   ;matput
    bcc L8416
L8413
    jmp L81e9                   ;matput
---------------------------------
L8416
    sta COPY3+1                 ;work For copy: length
    stx INF1                    ;used for operand checking
    sty INF3                    ;used for operand checking
    lda Q1+1
    ldy Q1
    sta Q5+1
    sty Q5
    lda #$02
    jsr L81f3                   ;matput
    bcs L8413
    sta COPY3                   ;work For copy: length
    sty INF2                    ;used for operand checking
    cpx INF3                    ;used for operand checking
    beq L8436
L8433
    jmp L81ee                   ;matput
---------------------------------
L8436
    lda Q1
    ldy Q1+1
    sta MOVEAD                  ;address for move
    sty MOVEAD+1                ;address for move
    lda #$03
    jsr L81f3                   ;matput
    cpx INF1                    ;used for operand checking
    bne L8433
    cpy INF2                    ;used for operand checking
    bne L8433
L844b
    lda MOVEAD                  ;address for move
    ldy MOVEAD+1                ;address for move
    sta Q2
    sty Q2+1
    lda INF2                    ;used for operand checking
    sta COPY2+1                 ;work For copy: to
L8457
    lda #$00
    tay
    sta (Q1),y
    lda Q5
    ldy Q5+1
    sta Q3
    sty Q3+1
    lda Q2
    ldy Q2+1
    sta Q4
    sty Q4+1
    lda INF3                    ;used for operand checking
    sta COPY2                   ;work For copy: to
L8470
    ldy Q3+1
    lda Q3
    jsr LDAC1                   ;load ac1
    ldy Q4+1
    lda Q4
    jsr FPMUL                   ;load ac2 and mul ac2 by ac1
    ldy Q1+1
    lda Q1
    jsr FPADD                   ;load ac2 and add ac2 to ac1
    ldy Q1+1
    ldx Q1
    jsr STAC1                   ;store ac1
    clc
    lda Q4
    adc COPY3                   ;work For copy: length
    sta Q4
    bcc L8497
    inc Q4+1
L8497
    jsr L834b                   ;matcom
    dec COPY2                   ;work For copy: to
    bne L8470
    jsr L8333                   ;matcom
    jsr L833f                   ;matcom
    dec COPY2+1                 ;work For copy: to
    bne L8457
    clc
    lda Q5
    adc COPY3+1                 ;work For copy: length
    sta Q5
    bcc L84b3
    inc Q5+1
L84b3
    dec INF1                    ;used for operand checking
    bne L844b
    rts

; $84b8