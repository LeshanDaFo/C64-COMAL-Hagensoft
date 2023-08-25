; ###############################################################
; #                                                             #
; #  memory.asm for                                             #
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
COPY1   =   $45                 ;work for copy: from
COPY2   =   $47                 ;work For copy: to

PUSHRL  =   $c9c5               ;push real number
FNDPAR  =   $c896               ;find parameter (asm. calls)
EXCGST  =   $c9e0               ;allocate local storage

; $864a
    lda #$01
    jsr FNDPAR                  ;find parameter (asm. calls)
    ldx COPY1                   ;work For copy: From
    lda COPY1+1                 ;work For copy: From
    jsr PUSHRL                  ;push real number
    lda #$02
    jsr EXCGST                  ;allocate local storage
    ldy #$00
    tya
    sta (COPY2),y               ;work For copy: to
    iny
    lda #$05
    sta (COPY2),y               ;work For copy: to
    rts

; $8666