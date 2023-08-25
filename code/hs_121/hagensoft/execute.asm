; ###############################################################
; #                                                             #
; #  execute.asm for                                            #
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
LNLEN   =   $1f                 ;length of line to be executed
PRGPNT  =   $31                 ;pnt to start of line

;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d

GOTO    =   $c884               ;jmp to another page
EXCUTE  =   $ca36               ;execute code in cdbuf

; $93bd
    LDA $55
    BNE L93B5                   ; located in 'learn' part
    JSR $93A6
    LDY #$05
L93C6
    LDA $CCA1,Y
    STA $C0F8,Y
    LDA L942C,Y
    STA $CCA1,Y
    DEY
    BPL L93C6
    JSR L940A
    LDY #$02
L93DA
    LDA $0031,Y
    STA $C0F4,Y
    DEY
    BPL L93DA
    INC $55
    JSR EXCUTE                  ;execute code in cdbuf

L93E8
    DEC $55
    LDY #$02
L93EC
    LDA $C0F4,Y
    STA $0031,Y
    DEY
    BPL L93EC
    JSR L940A
    LDY #$02
    LDA (PRGPNT),Y              ;pnt to start of line
    STA LNLEN                   ;length of line to be executed
    LDY #$05
L9400
    LDA $C0F8,Y
    STA $CCA1,Y
    DEY
    BPL L9400
    RTS
---------------------------------
L940A
    LDY #$00
L940C
    LDA $C661,Y
    TAX
    LDA $C100,Y
    STA $C661,Y
    TXA
    STA $C100,Y
    INY
    BNE L940C
    RTS
---------------------------------
L941E
    STY Q1+1
    STX Q2
    JSR L93E8
    LDX Q2
    LDY Q1+1
    JMP $CCA1
---------------------------------
L942C
    JSR GOTO                    ;jmp to another page
    !by >L941E                  ; high byte
    !by <L941E                  ; low byte
    !by $94
L9432
    INC $C0F7
    LDX $C0F0
    TXS
    RTS
---------------------------------
L943A
    !by $00,$00,$05,$ff,$33

; $943f