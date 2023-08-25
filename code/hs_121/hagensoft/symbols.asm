; ###############################################################
; #                                                             #
; #  symbols.asm for                                            #
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
Q5      =   $43

COPY1   =   $45                 ;work For copy: from

LDAC1   =   $c890               ;load ac1 

DEFOUT  =   $c7dd               ;select output Flag
INTFP   =   $c992               ;convert integer into Fp in ac1
FPASC   =   $c99b               ;convert ac1 into ascii equivalent (str$)
SPACE   =   $ca04               ;write space
CWRT    =   $ca06               ;write character
CCKOUT  =   $ca0c               ;select output File
CCLRCH  =   $ca0f               ;clear channel
CRLF    =   $ca1f               ;output cr and lf


; $8b64
    LDA DEFOUT                  ;select output Flag
    BEQ L8B6E
    LDX #$FF
    JSR CCKOUT                  ;select output File
L8B6E
    LDY #.msg1-.msgtxts         ;#$00, pointer to 'variables:'
    LDA #$10
    JSR L8B86
    LDY #.msg2-.msgtxts         ;#$0B, pointer to 'value parametsers:'
    LDA #$30
    JSR L8B86
    LDY #.msg3-.msgtxts         ;#$1D pointer to 'reference parameters:'
    LDA #$50
    JSR L8B86
    JMP CCLRCH                  ;clear channel
---------------------------------
L8B86
    STA Q5+1
    JSR printtxt
    JSR CRLF                    ;output cr and lf
    LDA $18
    LDX $19
    STA Q1
    STX Q1+1
L8B96
    LDY #$00
    LDA (Q1),Y
    BNE L8B9E
    RTS
---------------------------------
L8B9D
    !by $70
L8B9E
    sta Q5
    LDY #$03
    LDA (Q1),Y
    STA Q3+1
    DEY
    LDA (Q1),Y
    STA Q3
    LDY #$00
    LDA Q5+1
    CMP #$50
    BNE L8BBD
    LDA (Q3),Y
    TAX
    INY
    LDA (Q3),Y
    STX Q3
    STA Q3+1
L8BBD
    LDY #$00
    LDA (Q3),Y
    STA Q2
    INY
    LDA (Q3),Y
    STA Q2+1
    LDY #$01
    LDA (Q1),Y
    EOR Q5+1
    BIT L8B9D
    BNE L8BD9
    JSR L8BE6
    JSR CRLF                    ;output cr and lE
L8BD9
    CLC
    LDA Q1
    ADC Q5
    STA Q1
    BCC L8B96
    INC Q1+1
    BCS L8B96
L8BE6
    TAX
    CPX #$80
    BCS L8BF6
    ASL
    TAX
    LDA L8C4B+1,X
    PHA
    LDA L8C4B,X
    PHA
    RTS
---------------------------------
L8BF6
    BNE L8C19
    JSR L8D81
L8BFB
    LDY #$02
    LDA (Q3),Y
    STA COPY1                   ;work For copy: from
    LDA #$28
L8C03
    JSR CWRT                    ;write character
    DEC COPY1                   ;work For copy: from
    BEQ L8C11
    JSR L8C81
    LDA #$2C
    BNE L8C03
L8C11
    JSR L8C81
    LDA #$29
    JMP CWRT                    ;write character
---------------------------------
L8C19
    CPX #$81
    BNE L8C28
    JSR L8D81
    LDA #$23
    JSR CWRT                    ;write character
    JMP L8BFB
---------------------------------
L8C28
    JSR L8D81
    LDA #$24
    JSR CWRT                    ;write character
    JSR L8BFB
    LDY #.msg5+1-.msgtxts       ;#$38, pointer to ' of '
    JSR printtxt                ;print
    LDA Q2
    STA Q3
    LDA Q2+1
    STA Q3+1
L8C40
    LDY #$00
L8C42
    LDA (Q3),Y
    TAX
    INY
    LDA (Q3),Y
    JMP L8CCE
---------------------------------
L8C4B
    !word L8C5D-1
    !word L8CA9-1
    !word L8CB9-1
    !word L8CD6-1
    !word L8D1F-1
    !word L8D3F-1
    !word L8D45-1
    !word L8D42-1
    !word L8D5A-1
L8C5D
    JSR L8D81
    LDA #$3D
    JSR CWRT                    ;write character
    LDY Q3+1
    LDA Q3
    JSR LDAC1                   ;load ac1
L8C6C
    JSR FPASC                   ;convert ac1 into ascii equivalent (str$)
    LDY #$00
L8C71
    LDA $0100,Y
    BEQ L8C80
    CMP #$20
    BEQ L8C7D
    JSR CWRT                    ;write character
L8C7D
    INY
    BNE L8C71
L8C80
    RTS
---------------------------------
L8C81
    LDY #$03
    LDA (Q3),Y
    BNE L8C8E
    INY
    LDA (Q3),Y
    CMP #$01
    BEQ L8C98
L8C8E
    LDY #$03
    JSR L8C42
    LDA #$3A
    JSR CWRT                    ;write character
L8C98
    LDY #$05
    JSR L8C42
    CLC
    LDA Q3
    ADC #$04
    STA Q3
    BCC L8CA8
    INC Q3+1
L8CA8
    RTS
---------------------------------
L8CA9
    JSR L8D81
    LDA #$23
    JSR CWRT                    ;write character
    LDA #$3D
    JSR CWRT                    ;write character
    JMP L8C40
---------------------------------
L8CB9
    JSR L8D81
    LDY #.msg5-.msgtxts         ;#$37, pointer to '$ of '
    JSR printtxt                ;print
    JSR L8C40
    LDY #.msg6-.msgtxts         ;#$3D, pointer to ', used: '
    JSR printtxt                ;print
    LDY #$02
    JMP L8C42
---------------------------------
L8CCE
    TAY
    TXA
    JSR INTFP                   ;convert integer into Fp in ac1
    JMP L8C6C
---------------------------------
L8CD6
    JSR L8D81
    LDA #$3A
    JSR CWRT                    ;write character
L8CDE
    LDY #$00
    LDA (Q2),Y
    TAX
    INY
    LDA (Q2),Y
    TAY
    TXA
    JSR INTFP                   ;convert integer into Fp in ac1
    JSR FPASC                   ;convert ac1 into ascii equivalent (str$)
    JSR SPACE                   ;write space
    LDY #$02
    JMP L8C71
---------------------------------
L8CF6
    LDY #$02
    LDA (Q3),Y
    BEQ L8CDE
    LDA #$24
    JSR CWRT                    ;write character
    LDY #$01
    JSR L8D07
    DEY
L8D07
    LDA (Q3),Y
    PHA
    LSR
    LSR
    LSR
    LSR
    JSR L8D14
    PLA
    AND #$0F
L8D14
    CMP #$0A
    BCC L8D1A
    ADC #$06
L8D1A
    ADC #$30
    JMP CWRT                    ;write character
---------------------------------
L8D1F
    JSR L8CF6
    LDY #.msg7-.msgtxts         ;#$46, pointer to ' proc '
    JSR printtxt                ;print
    JSR L8D6E
L8D2A
    LDY #.msg4-.msgtxts         ;#$33, pointer to '...'
    JSR printtxt                ;print
    LDY #$02
    LDA (Q3),Y
    BEQ L8D80
    LDY #.msg10-.msgtxts        ;#$5D, pointer to ' on page $'
    JSR printtxt                ;print
    LDY #$02
    JMP L8D07
---------------------------------
L8D3F
    LDA #$00
    !by $2C
L8D42
    LDA #$24
L8D44
    !by $2C
L8D45
    LDA #$23
    PHA
    JSR L8CF6
    LDY #.msg8-.msgtxts         ;#$4D, pointer to ' func '
    JSR printtxt                ;print
    JSR L8D6E
    PLA
    JSR CWRT                    ;write character
    JMP L8D2A
---------------------------------
L8D5A
    JSR L8D87
    LDY #.msg9-.msgtxts         ;#$54, pointer to 'package '
    JSR printtxt                ;print
    JSR L8D6E
    LDY #.msg10-.msgtxts        ;#$5D, pointer to ' on page $'
    JSR printtxt                ;print
    LDY #$00
    BEQ L8D07
L8D6E
    LDY #$04
L8D70
    LDA (Q1),Y
    CMP #$5F
    BNE L8D78
    LDA #$A4
L8D78
    JSR CWRT                    ;write character
    INY
    CPY Q5
    BNE L8D70
L8D80
    RTS
---------------------------------
L8D81
    JSR L8D87
    JMP L8D6E
---------------------------------
L8D87
    LDY #.msg11-.msgtxts        ;#$68, pointer to '      '
; $8d89, print chars, pointer in y
printtxt
    LDA .msgtxts,Y
    BEQ L8D94
    JSR CWRT                    ;write character
    INY
    BNE printtxt
L8D94
    RTS
---------------------------------
L8D95
.msgtxts
.msg1;00
    !pet "variables:",$00
.msg2;0b
    !pet "value parameters:",$00
.msg3;1d
    !pet "reference parameters:",$00
.msg4;33
    !pet "...",$00
.msg5;37
    !pet "$ of ",$00
.msg6;3d
    !pet ", used: ",$00
.msg7;46
    !pet " proc ",$00
.msg8;4d
    !pet " func ",$00
.msg9;54
    !pet "package ",$00
.msg10;5d
    !pet " on page $",$00
.msg11;68
    !pet "      ",$00

; $8e04