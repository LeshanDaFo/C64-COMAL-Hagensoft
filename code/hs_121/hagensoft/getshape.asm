; ###############################################################
; #                                                             #
; #  getshape.asm for                                           #
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

;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f
Q4      =   $41
Q5      =   $43

COPY1   =   $45                 ;work For copy: from

PAGE4   =   $83

CALL    =   $c881               ;jsr to another page
LOAD    =   $c887               ;load from pagex
FNDPAR  =   $c896               ;Find parameter (asm.calls)

; $8e0c
    LDA #$03
    JSR FNDPAR                  ;Find parameter (asm.calls)
    LDY #$00
    LDA (COPY1),Y               ;work For copy: from
    BNE L8E81
    INY
    SEC
    LDA #$C7
    SBC ($45),Y
    PHP
    PHA
    AND #$07
    EOR #$07
    STA Q3
    PLA
    LSR
    LSR
    LSR
    PLP
    BCS L8E2E
    ORA #$E0
L8E2E
    PHP
    STA Q3+1
    LDY #$00
    STY Q1
    LSR
    ROR Q1
    LSR
    ROR Q1
    ADC Q3+1
    PLP
    BCS L8E42
    ADC #$C0
L8E42
    CLC
    ADC #$E0
    STA Q1+1
    LDA #$02
    JSR FNDPAR                  ;Find parameter (asm.calls)
    LDY #$01
    LDA (COPY1),Y               ;work For copy: from),Y
    STA Q4+1
    AND #$07
    STA Q4
    LDA Q4+1
    ORA #$07
    EOR Q3
    CLC
    ADC Q1
    STA PAGEPT                  ;pointer used by load/store/exac
    PHP
    DEY
    LDA (COPY1),Y               ;work For copy: from
    CMP #$FF
    BEQ L8E6D
    CMP #$02
    BCS L8E80
L8E6D
    PLP
    PHA
    ADC Q1+1
    STA $08
    PLA
    LSR
    ROR Q4+1
    LSR
    ROR Q4+1
    LSR
    ROR Q4+1
    JMP L8E85
---------------------------------
L8E80
    PLP
L8E81
    LDA #$32
    STA Q4+1
L8E85
    LDA #$45
    STA PAGEX                   ;overlay for load/store/exec routines
    LDA #$00
    STA Q2
    LDA #$C0
    STA Q2+1
L8E91
    LDY #$03
L8E93
    STY Q1
    TYA
    ASL
    ASL
    ASL
    TAY
    JSR L8F15
    LDY Q1
    STA (Q2),Y
    DEY
    BPL L8E93
    CLC
    LDA Q2
    ADC #$04
    STA Q2
    CMP #$54
    BEQ L8ED2
    DEC Q3
    BPL L8EC9
    INC Q3+1
    LDA #$07
    STA Q3
    CLC
    LDA PAGEPT                  ;pointer used by load/store/exac
    ADC #$39
    STA PAGEPT                  ;pointer used by load/store/exac
    LDA $08
    ADC #$01
    STA $08
    JMP L8E91
---------------------------------
L8EC9
    INC PAGEPT                  ;pointer used by load/store/exac
    BNE L8E91
    INC $08
    JMP L8E91
---------------------------------
L8ED2
    LDY Q4
    BEQ L8EE1
L8ED6
    LDX #$53
L8ED8
    ROL $C000,X
    DEX
    BPL L8ED8
    DEY
    BNE L8ED6
L8EE1
    LDX #$01
    LDY #$00
L8EE5
    LDA $BFFF,X
    STA $C000,Y
    INY
    INX
    TXA
    AND #$03
    BNE L8EE5
    INX
    CPY #$3F
    BCC L8EE5
    LDA #$01
    JSR FNDPAR                  ;Find parameter (asm.calls)
    JSR CALL                    ;jsr to another page
    !by PAGE4                   ;$83
    !by $ef                     ;low byte address
    !by $9a                     ;high byte address
    ASL $C29B,X
    LSR $C29B,X
    LDA #$00
    STA Q5
    LDA #$C0
    STA Q5+1
    LDY #$3F
    JMP $C564
---------------------------------
L8F15
    CLC
    LDA Q1
    ADC Q4+1
    CMP #$28
    BCS L8F27
    LDA Q3+1
    CMP #$19
    BCS L8F27
    JMP LOAD                    ;load from pagex
---------------------------------
L8F27
    LDA #$00
    RTS

; $8f2a