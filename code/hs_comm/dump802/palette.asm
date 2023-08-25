; ###############################################################
; #                                                             #
; #  pallete.asm for                                            #
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
PAGEPT  =   $07                 ;pointer used by load/store/exac
PAGEX   =   $09                 ;overlay for load/store/exec routines

COPY1   =   $45                 ;work for copy: from


FNDPAR  =   $c896               ;find parameter (asm. calls)
RUNERR  =   $c9fb               ;go to comal error handler
LOAD    =   $c887               ;load from pagex
STORE   =   $c88a               ;store to pagex

; $8666
    lda #$01
    jsr L86c9
    sta $fb
    lda #$02
    jsr L86c9
    sta $fc
    lda #$05
    sta PAGEX                   ;overlay for load/store/exec routines
    lda #$0f
    sta $fd
    jsr L8698
    dec PAGEX                   ;overlay for load/store/exec routines
    jsr L8698
    asl $fb
    asl $fb
    asl $fb
    asl $fb
    asl $fc
    asl $fc
    asl $fc
    asl $fc
    lda #$f0
    sta $fd
L8698
    lda $fb
    eor $fc
    sta $fe
    lda #$e8
    sta PAGEPT                  ;pointer used by load/store/exac
    lda #$d7
    sta PAGEPT+1                ;pointer used by load/store/exac
    ldy #$18
L86a8
    jsr LOAD                    ;load from pagex
    and $fd
    cmp $fb
    beq L86b5
    cmp $fc
    bne L86bd
L86b5
    jsr LOAD                    ;load from pagex
    eor $fe
    jsr STORE                   ;store to pagex
L86bd
    iny
    bne L86a8
    inc PAGEPT+1                ;pointer used by load/store/exac
    lda PAGEPT+1                ;pointer used by load/store/exac
    cmp #$db
    bne L86a8
    rts
---------------------------------
L86c9
    jsr FNDPAR                  ;find parameter (asm. calls)
    ldy #$00
    lda (COPY1),y               ;work For copy: From
    bne L86da
    iny
    lda (COPY1),y               ;work For copy: From
    cmp #$10
    bcs L86da
    rts
---------------------------------
L86da
    ldx #$1e
    jmp RUNERR                  ;go to comal error handler

; $86df