; ###############################################################
; #                                                             #
; #  learn.asm for                                              #
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

CALL    =   $c881               ;jsr to another page
FNDPAR  =   $c896               ;Find parameter (asm.calls)
RUNERR  =   $c9fb               ;go to comal error handler

L9305
    LDA $55
    BEQ L930C
    JMP L93B5
---------------------------------
L930C
    LDA #$01
    JSR FNDPAR                  ;Find parameter (asm.calls)
    LDY #$02
    LDA ($45),Y
    BNE L931E
    INY
    LDA ($45),Y
    CMP #$79
    BCC L9323
L931E
    LDX #$67
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L9323
    ADC #$03
    TAY
    LDA #$0D
    STA $C5E5,Y
L932B
    CPY #$04
    BCC L9337
    LDA ($45),Y
    STA $C5E4,Y
    DEY
    BNE L932B
L9337
    LDA #$00
    STA $C0F7
    LDA $C845
    STA $C0F1
    LDA $C7D1
    STA $C0F2
    LDA #$02
    STA $C7D1
    STA $C845
    LDY #$07
L9352
    LDA $CE05,Y
    STA $C0F8,Y
    LDA L9432,Y                 ; located in 'execute' part
    STA $CE05,Y
    DEY
    BPL L9352
    JSR L940A                   ; located in 'execute' part
    TSX
    DEX
    DEX
    DEX
    DEX
    DEX
    DEX
    STX $C0F0
    JSR CALL                    ;jsr to another page
    !by $81
    !by $0D
    !by $92
    LDY $15
    STY $C663
    LDX #$00
L937B
    LDA L943A,X                 ; located in 'execute' part
    STA $C661,Y
    INX
    INY
    CPX #$05
    BNE L937B
    JSR L940A                   ; located in 'execute' part
    LDA $C0F1
    STA $C845
    LDA $C0F2
    STA $C7D1
    LDY #$07
L9398
    LDA $C0F8,Y
    STA $CE05,Y
    DEY
    BPL L9398
    LDA $C0F7
    BNE L93B2
    LDA $88
    BEQ L93AE
    LDA $32
    BPL L93AF
L93AE
    RTS
---------------------------------
L93AF
    LDX #$3B
    !by $2c
L93B2
    LDX #$65
    !by $2c
L93B5
    LDX #$39
    JMP RUNERR                  ;go to comal error handler
---------------------------------
; $83ba