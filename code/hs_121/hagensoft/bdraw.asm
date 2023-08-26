; ###############################################################
; #                                                             #
; #  bdraw.asm for                                              #
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
Q4      =   $41
Q5      =   $43

COPY1   =   $45                 ;work For copy: from
COPY2   =   $47                 ;work For copy: to

TXTHI   =   $7d                 ;address of text for print

PAGE4   =   $83

CALL    =   $c881               ;jsr to another page
FNDPAR  =   $c896               ;Find parameter (asm.calls)
EXCGST  =   $c9e0               ;allocate local storage
EXCREM  =   $c9e9               ;reclaim local storage
RESTOP  =   $c9f2               ;allocate global storage
RUNERR  =   $c9fb               ;go to comal error handler

; $8f3b
    LDA #$01
    JSR FNDPAR                  ;Find parameter (asm.calls)
    LDY #$01
L8F42
    LDA (COPY1),Y               ;work For copy: from
    STA $003B,Y
    DEY
    BPL L8F42
    LDY #$03
    JSR L8F87
    CMP #$21
    BPL L8F82
    ASL
    ASL
    STA $43
    LDY #$07
    JSR L8F87
    CMP #$02
    BNE L8F82
    LDA $2D
    LDX $2E
    STA Q4
    STX Q4+1
    LDA Q5
    JSR EXCGST                  ;allocate local storage
    LDY Q5
    DEY
L8F70
    LDA (Q1),Y
    PHA
    TYA
    TAX
    EOR #$01
    TAY
    PLA
    STA (COPY2),Y
    TXA
    TAY
    DEY
    BPL L8F70
    BMI L8F97
L8F82
    LDX #$01
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L8F87
    JSR L8F8E
    CMP #$01
    BNE L8F82
L8F8E
    LDA (COPY1),Y               ;work For copy: from
    BNE L8F82
    INY
    LDA (COPY1),Y               ;work For copy: from
    INY
    RTS
---------------------------------
L8F97
    LDA Q5
    JSR RESTOP                  ;allocate global storage
L8F9C
    LDA $2D
    LDX $2E
    CMP Q4
    BNE L8FB5
    CPX Q4+1
    BNE L8FB5
    CLC
    LDA $2F
    ADC Q5
    STA $2F
    BCS L8FB2
    RTS
---------------------------------
L8FB2
    INC $30
    RTS
---------------------------------
L8FB5
    STA Q2
    STX Q2+1
    SEC
    SBC #$04
    STA Q3
    BCS L8FC1
    DEX
L8FC1
    STX Q3+1
    LDA Q5
    JSR EXCREM                  ;reclaim local storage
L8FC8
    LDY #$00
    JSR L9004
    LDY #$02
    JSR L9004
    LDY #$00
    JSR L8FE4
    INY
    JSR L8FE4
    JSR CALL                    ;jsr to another page
    !by PAGE4                   ;$83
    !by $5e                     ;address low byte
    !by $8a                     ;address high byte

    JMP L8F9C    
L8FE4
    TYA
    TAX
    LDA ($2D),Y
    STA $007E,Y
    INY
    LDA ($2D),Y
    PHP
    LSR
    ROR $7E,X
    LSR
    ROR $7E,X
    LSR
    ROR $7E,X
    LSR
    ROR $7E,X
    PLP
    BPL L9000
    ORA #$F0
L9000
    STA $007E,Y
    RTS
---------------------------------
L9004
    LDA ($2D),Y
    AND #$F0
    SEC
    SBC (Q3),Y
    TAX
    INY
    CLV
    LDA ($2D),Y
    SBC (Q3),Y
    BVS L9023
    BEQ L901F
    CMP #$FF
    BNE L9023
    CPX #$E1
    BCC L9023
L901E
    RTS
---------------------------------
L901F
    CPX #$11
    BCC L901E
L9023
    PLA
    PLA
    CLC
    LDA $2D
    LDX $2E
    ADC #$04
    STA Q1
    BCC L9031
    INX
L9031
    STX Q1+1
    LDA Q5
    STA $B1
    JSR EXCGST                  ;allocate local storage
L903A
    LDY #$03
L903C
    LDA (COPY2),Y               ;work For copy: to
    STA (Q2),Y
    DEY
    BPL L903C
    CLC
    LDA Q2+1
    STA Q3+1
    LDA Q2
    STA Q3
    ADC #$04
    STA Q2
    BCC L9054
    INC Q2+1
L9054
    LDA $B1
    SEC
    SBC #$04
    STA $B1
    BNE L9060
    JMP L8FC8
---------------------------------
L9060
    LDY #$00
L9062
    INY
    LDA (COPY2),Y               ;work For copy: to
    EOR (Q1),Y
    AND #$80
    STA TXTHI                   ;address of text for print
    DEY
    CLC
    LDA (COPY2),Y               ;work For copy: to
    ADC (Q1),Y
    STA (COPY2),Y               ;work For copy: to
    INY
    LDA (COPY2),Y               ;work For copy: to
    ADC (Q1),Y
    ROR
    EOR TXTHI                   ;address of text for print
    STA (COPY2),Y               ;work For copy: to
    DEY
    LDA (COPY2),Y               ;work For copy: to
    ROR
    STA (COPY2),Y               ;work For copy: to
    INY
    INY
    CPY $B1
    BNE L9062
    JMP L903A
---------------------------------
; $908c