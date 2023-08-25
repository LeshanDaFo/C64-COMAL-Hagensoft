; ###############################################################
; #                                                             #
; #  ellipse.asm for                                            #
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
Q2      =   $3d
Q3      =   $3f
Q4      =   $41
Q5      =   $43

COPY1   =   $45                 ;work For copy: from
COPY2   =   $47                 ;work For copy: to

LDAC1   =   $c890               ;load ac1
FNDPAR  =   $c896               ;Find parameter (asm.calls)
STAC1   =   $c8f6               ;store ac1
FPSUB   =   $c8c0               ;load ac2 and sub ac2 from ac1
FPMUL   =   $c8cc               ;load ac2 and mul ac2 by ac1
FPADD   =   $c8ab               ;load ac2 and add ac2 to ac1
FPNEG   =   $c90b               ;negate ac1
EXCGST  =   $c9e0               ;allocate local storage

; $908c
    LDY #$36
L908E
    LDA L91F7,y
    STA $C5E8,y
    DEY
    BPL L908E
    LDY #$05
L9099
    TYA
    PHA
    JSR FNDPAR                  ;Find parameter (asm.calls)
    PLA
    TAY
    LDX L91E2-1,y
    LDA COPY1                   ;work For copy: from
    STA $C5EA,x
    LDA COPY1+1                 ;work For copy: from
    STA $C5EB,x
    DEY
    BNE L9099
L90B0
    STY Q3
    JSR L90C9-1
    LDY Q3
    INY
    BNE L90B0
L90BA
    !by $2b
L90BB
    STA ($09),y
    STA ($1c),y
    CMP #$25
    CMP #$0f
    STA ($0a),y
    CMP #$15
    STA ($b9),y
L90C9
    DEC $90,x
    ASL
    TAX
    LDA L90BB,x
    PHA
    LDA L90BA,x
    PHA
    RTS
---------------------------------
L90D6 !by $01,$0a,$04,$02,$06,$0a
L90DC !by $02,$06,$08,$04,$09,$05,$06,$04
L90E4 !by $04,$00,$06,$05,$01,$0a,$03,$06
L90EC !by $0a,$04,$07,$06,$02,$04,$00,$06
L90F4 !by $03,$01,$07,$04,$08,$06,$07,$04
L90FC !by $00,$06,$08,$01,$09,$04,$0a,$06
L9104 !by $09,$04,$00,$06,$0a,$00
---------------------------------
    JSR L911C
    JMP LDAC1                   ;load ac1
---------------------------------
    JSR L911C
    JMP FPMUL                   ;load ac2 and mul ac2 by ac1
---------------------------------
    JSR L911C
    JMP STAC1                   ;store ac1
---------------------------------
L911C
    INC Q3
    LDA L90D6+1,y
L9121
    ASL
    ASL
    TAX
    LDY $c5eb,x
    LDA $c5ea,x
    TAX
    RTS
    PLA
    PLA
    LDA $2D
    LDX $2E
    STA Q4
    STX Q4+1
    LDA #$10
    STA Q5
    LDA #$40
    JSR EXCGST                  ;allocate local storage
    LDY #$0F
L9141
    STY Q1
    LDA #$01
    JSR L9163
    JSR L91B6
    JSR L919A
    LDY Q1
    LDA #$06
    JSR L9163
    JSR L91CC
    JSR L919A
    LDY Q1
    DEY
    BPL L9141
    JMP L8F97
---------------------------------
L9163
    STA Q2
    LDA L91E7,Y
    STA $B1
    LDA Q2
    JSR L9121
    JSR LDAC1                   ;load ac1
L9172
    INC Q2
    ASL $B1
    BCS L918A
    BPL L9185
    LDA Q2
    JSR L9121
    JSR FPSUB                   ;load ac2 and sub ac2 from ac1
    JSR FPNEG                   ;negate ac1
L9185
    ASL $B1
    BNE L9172
    RTS
---------------------------------
L918A
    LDA Q2
    JSR L9121
    JSR FPADD                   ;load ac2 and add ac2 to ac1
    JMP L9185
---------------------------------
    STA $00
    BRK
---------------------------------
    BRK
---------------------------------
    BRK
---------------------------------
L919A
    LDY #$91
    LDA #$95
    JSR FPMUL                   ;load ac2 and mul ac2 by ac1
    JSR $C977
    LDA $65
    JSR L91AB
    LDA $64
L91AB
    LDY #$00
    STA (COPY2),Y               ;work For copy: to
    INC COPY2                   ;work For copy: to
    BNE L91B5
    INC COPY2+1                 ;work For copy: to
L91B5
    RTS
---------------------------------
L91B6
    LDA $C264
    BEQ L91B5
    LDY #$C2
    LDA #$2E
    JSR FPSUB                   ;load ac2 and sub ac2 from ac1
    JSR FPNEG                   ;negate ac1
    LDY #$C2
    LDA #$42
    JMP FPMUL                   ;load ac2 and mul ac2 by ac1
---------------------------------
L91CC
    LDA $C264
    BEQ L91B5
    LDY #$C2
    LDA #$33
    JSR FPSUB                   ;load ac2 and sub ac2 from ac1
    JSR FPNEG                   ;negate ac1
    LDY #$C2
    LDA #$47
    JMP FPMUL                   ;load ac2 and mul ac2 by ac1
---------------------------------
L91E2 !by $04,$18,$1c,$24,$28
L91E7 !by $08,$28,$82,$80,$40
L91EC !by $42,$18,$08,$04,$14,$41,$40,$80
L91F4 !by $81,$24,$04
L91F7 !by $04,$10,$14,$c6,$04
L91FC !by $10,$00,$00,$04,$10,$19,$c6,$04
L9204 !by $10,$1e,$c6,$04,$10,$23,$c6,$04
L920C !by $10,$28,$c6,$04,$10,$00,$00,$04
L9214 !by $10,$00,$00,$04,$10,$2d,$c6,$04
L921C !by $10,$00,$00,$04,$10,$00,$00,$80
L9224 !by $0d,$62,$88,$8e,$7b,$0e,$fa,$35
L922C !by $12
; $922d