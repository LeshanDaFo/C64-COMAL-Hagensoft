; ###############################################################
; #                                                             #
; #  edge.asm for                                               #
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
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f

TXTHI   =   $7d                 ;address of text for print

SPACE   =   $ca04               ;write space
CWRT    =   $ca06               ;write character
CCKOUT  =   $ca0c               ;select output File
CCLRCH  =   $ca0f               ;clear channel
CRLF    =   $ca1f               ;output cr and lf

; $9232
L9232
    PHA
    LSR
    LSR
    LSR
    LDY #$00
    STY Q3
    STA TXTHI                   ;address of text for print
    LSR
    ROR Q3
    LSR
    ROR Q3
    ADC TXTHI                   ;address of text for print
    ADC #$E0
    TAX
    PLA
    AND #$07
    ORA Q3
    RTS
---------------------------------
edge;924d
    LDY #$27
    LDA #$00
L9251
    STA $C005,Y
    DEY
    BPL L9251
    STA $C02E
    STA $C057
    STA Q3+1
    LDY #$61
L9261
    LDA L9293,Y
    STA $C068,Y
    DEY
    BPL L9261
L926A
    LDA Q3+1
    CMP #$C7
    BCC L9271
    RTS
---------------------------------
L9271
    JSR L9232
    STA Q1
    STX Q1+1
    LDY Q3+1
    INY
    TYA
    JSR L9232
    STA Q2
    STX Q2+1
    JSR $C068
L9286
    LDA $C02F,Y
    STA $C005,Y
    DEY
    BPL L9286
    INC Q3+1
    BNE L926A
L9293
    SEI
    LDA $01
    PHA
    LDA #$45
    STA $01
    LDX #$27
    LDY #$00
L929F
    LDA (Q1),Y
    STA $C02F,X
    DEX
    BMI L92B2
    TYA
    CLC
    ADC #$08
    TAY
    BCC L929F
    INC Q1+1
    BCS L929F
L92B2
    DEC Q1+1
    LDY #$00
    LDX #$27
L92B8
    LDA $C02F,X
    BEQ L92DD
    LDA $C030,X
    LSR
    LDA $C02F,X
    ROR
    STA TXTHI                   ;address of text for print
    LDA $C02E,X
    ASL
    LDA $C02F,X
    ROL
    AND TXTHI                   ;address of text for print
    AND $C005,X
    AND (Q2),Y
    EOR #$FF
    AND $C02F,X
    STA (Q1),Y
L92DD
    DEX
    BMI L92ED
    CLC
    TYA
    ADC #$08
    TAY
    BCC L92B8
    INC Q2+1
    INC Q1+1
    BCS L92B8
L92ED
    LDY #$27
    PLA
    STA $01
    CLI
    RTS
; $92f4