; ###############################################################
; #                                                             #
; #  dump.asm for                                               #
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
RESOL   =   $0C                 ;graphics resolution
;INFx used for operand checking
INF1    =   $38              
;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q4      =   $41
Q5      =   $43

COPY1   =   $45                 ;work For copy: from
COPY2   =   $47                 ;work For copy: to
COPY3   =   $49                 ;work For copy: length

TXTLO   =   $7c                 ;address of text for print
TXTHI   =   $7d                 ;address of text for print

FREKZP  =   $fb                 ;free kernal z-page space

TXT     =   $c760               ;string constant buffer $c760-$c7aF
CALL    =   $c881               ;jsr to another page
LOAD    =   $c887               ;load from pagex
FNDPAR  =   $c896               ;Find parameter (asm.calls)
RUNERR  =   $c9fb               ;go to comal error handler

RDSTAT  =   $ffb7               ;READ I/O STATUS WORD 
UNLSN   =   $ffae               ;COMMAND DEVICE TO UNLISTEN 
LISTN   =   $ffb1               ;COMMAND DEVICE TO LISTEN 
SECOND  =   $ff93               ;SEND SA AFTER LISTEN 
CIOUT   =   $ffa8               ;OUTPUT BYTE TO  SERIAL PORT 


; $86df
    LDA RESOL                   ;graphics resolution ($0c)
    BNE L86F3
    LDA #$01
    JSR FNDPAR                  ;Find parameter (asm.calls)
    LDY #$00
    LDA (COPY1),Y               ;work For copy: from
    BNE L86FE
    INY
    LDA (COPY1),Y               ;work For copy: from
    BNE L86F6
L86F3
    JMP L886F
---------------------------------
L86F6
    CMP #$2A
    BCS L86FE
    TAX
    JMP L8798
---------------------------------
L86FE
    LDX #$05
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L8703
    JSR RDSTAT                  ;READ I/O STATUS WORD 
    AND #$FF
    BEQ L8721
    TAX
    ROL
    BCS L8717
    TXA
    ROR
    BCS L871C
    LDX #$DB
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L8717
    LDX #$D0
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L871C
    LDX #$D3
    JMP RUNERR                  ;go to comal error handler
---------------------------------
L8721
    RTS
---------------------------------
L8722
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN 
    JSR L8703
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN 
    LDA #$66
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    LDA #$24
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN
    JSR L8703
    RTS
---------------------------------
L874C
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN
    LDA #$60
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN
    JSR L8703
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN
    LDA #$66
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    LDA #$14
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN
    JSR L8703
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN
    LDA #$60
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    RTS
---------------------------------
L8798
    STA FREKZP+4                ;free kernal z-page space
    JSR L874C
    LDA #$60
    STA COPY3                   ;work For copy: length
    LDA #$C7
    STA COPY3+1                 ;work For copy: length
    LDA #$00
    STA Q1
    STA Q2
    STA Q1+1
    STA Q2+1
    LDA FREKZP+4                ;free kernal z-page space
    STA TXTHI                   ;address of text for print
L87B3
    LDA Q2
    STA Q4
    LDA Q2+1
    STA Q4+1
    LDX #$06
L87BD
    CLC
    ROL Q4
    ROL Q4+1
    DEX
    BNE L87BD
    LDA Q4
    STA PAGEPT                  ;pointer used by load/store/exac
    LDA Q4+1
    STA PAGEPT+1                ;pointer used by load/store/exac
    CLC
    ROL Q4
    ROL Q4+1
    CLC
    ROL Q4
    ROL Q4+1
    CLC
    LDA PAGEPT                  ;pointer used by load/store/exac
    ADC Q4
    STA PAGEPT                  ;pointer used by load/store/exac
    LDA PAGEPT+1                ;pointer used by load/store/exac
    ADC Q4+1
    STA PAGEPT+1                ;pointer used by load/store/exac
    LDA PAGEPT+1                ;pointer used by load/store/exac
    ADC #$E0
    STA PAGEPT+1                ;pointer used by load/store/exac
L87EA
    LDY #$01
    STY Q4
    LDA #$45
    STA PAGEX                   ;overlay for load/store/exec routines
L87F2
    LDY #$00
L87F4
    JSR LOAD                    ;load from pagex
    LDX Q4
L87F9
    ROL
    DEX
    BNE L87F9
    ROL INF1                    ;used for operand checking
    INY
    CPY #$08
    BNE L87F4
    LDA INF1                    ;used for operand checking
    LDY Q4
    DEY
    STA (COPY3),Y               ;work For copy: length
    INC Q4
    LDA Q4
    CMP #$09
    BNE L87F2
    LDA Q1
    CLC
    ADC FREKZP+4                ;free kernal z-page space
    JSR L891C
    CLC
    LDA #$08
    ADC PAGEPT                  ;pointer used by load/store/exac
    STA PAGEPT                  ;pointer used by load/store/exac
    LDA PAGEPT+1                ;pointer used by load/store/exac
    ADC #$00
    STA PAGEPT+1                ;pointer used by load/store/exac
    INC Q1
    LDA Q1
    CMP #$28
    BEQ L8833
    JMP L87EA
---------------------------------
L8833
    LDA #$00
    STA Q1
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    LDA FREKZP+4                ;free kernal z-page space
    STA TXTHI                   ;address of text for print
    INC Q2
    LDA Q2
    CMP #$19
    BNE L884E
    JMP L8722
---------------------------------
L884E
    JMP L87B3
---------------------------------


L8851   !by $06,$00,$04,$02,$03,$02,$05,$01
        !by $04,$05,$03,$04,$03,$01,$03,$02

L8861   !by $00,$00,$41,$82,$a4,$a1,$58,$5a
        !by $5a,$5a,$be,$7d,$ff,$ff


L886F
    JSR L874C
    LDA #$00
    STA FREKZP                  ;free kernal z-page space
L8876
    LDA #$00
    STA FREKZP+1                ;free kernal z-page space
    STA TXTHI                   ;address of text for print
L887C
    LDA #$00
    STA FREKZP+2                ;free kernal z-page space
L8880
    LDA #$00
    STA FREKZP+4                ;free kernal z-page space
    STA FREKZP+3                ;free kernal z-page space
L8886
    LDA #$00
    STA COPY2+1                 ;work For copy: to
    LDA FREKZP+1                ;free kernal z-page space
    STA COPY2                   ;work For copy: to
    CLC
    ROL COPY2                   ;work For copy: to
    ROL COPY2+1                 ;work For copy: to
    CLC
    ROL COPY2                   ;work For copy: to
    ROL COPY2+1                 ;work For copy: to
    LDA FREKZP+2                ;free kernal z-page space
    CLC
    ROR
    CLC
    ADC COPY2                   ;work For copy: to
    STA COPY2                   ;work For copy: to
    LDA COPY2+1                 ;work For copy: to
    ADC #$00
    STA COPY2+1                 ;work For copy: to
    LDA FREKZP                  ;free kernal z-page space
    CLC
    ROL
    ROL
    ADC FREKZP+3                ;free kernal z-page space
    STA COPY3                   ;work For copy: length
    LDA #$C8
    CLC
    SBC COPY3                   ;work For copy: length
    STA COPY3                   ;work For copy: length
    JSR CALL                    ;jsr to another page
    !by $83
    DEC $A88F,X
    LDA FREKZP+3                ;free kernal z-page space
    ROR
    LDA L8851,Y
    ROL
    TAX
    LDA FREKZP+2                ;free kernal z-page space
    AND #$03
    TAY
    LDA L8861,X
L88CE
    CPY #$03
    BEQ L88D6
    ROR
    INY
    BNE L88CE
L88D6
    ROR
    ROL FREKZP+4                ;free kernal z-page space
    ROR
    ROR
    ROR
    ROR
    ROL FREKZP+4                ;free kernal z-page space
    INC FREKZP+3                ;free kernal z-page space
    LDA FREKZP+3                ;free kernal z-page space
    CMP #$04
    BNE L8886
    LDY FREKZP+2                ;free kernal z-page space
    LDA FREKZP+4                ;free kernal z-page space
    STA TXT,Y                   ;string constant buffer
    INC FREKZP+2                ;free kernal z-page space
    LDA FREKZP+2                ;free kernal z-page space
    CMP #$08
    BNE L8880
    LDA FREKZP+1                ;free kernal z-page space
    JSR L891C
    INC FREKZP+1                ;free kernal z-page space
    LDA FREKZP+1                ;free kernal z-page space
    CMP #$50
    BEQ L8906
    JMP L887C
---------------------------------
L8906
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    INC FREKZP                  ;free kernal z-page space
    LDA FREKZP                  ;free kernal z-page space
    CMP #$32
    BEQ L8919
    JMP L8876
---------------------------------
L8919
    JMP L8722
---------------------------------
L891C
    STA TXTLO                   ;address of text for print
    LDY #$00
    TYA
L8921
    ORA TXT,Y                   ;string constant buffer
    INY
    CPY #$08
    BNE L8921
    ORA #$00
    BNE L8930
    INC TXTHI                   ;address of text for print
    RTS
---------------------------------
L8930
    LDY TXTHI                   ;address of text for print
    BEQ L8940
L8934
    LDA #$20
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    DEC TXTHI                   ;address of text for print
    BNE L8934
L8940
    LDY #$07
L8942
    LDA TXT,Y                   ;string constant buffer
    CMP TXT+8,Y                 ;string constant buffer
    BNE L8954
    DEY
    CPY #$FF
    BNE L8942
    LDA #$FE
    JMP L8A29
---------------------------------
L8954
    LDA #<L8a2d
    STA COPY2                   ;work For copy: to
    LDA #>L8a2d
    STA COPY2+1                 ;work For copy: to
    JMP L896C
---------------------------------
L895F
    CLC
    LDA #$09
    ADC COPY2                   ;work For copy: to
    STA COPY2                   ;work For copy: to
    LDA COPY2+1                 ;work For copy: to
    ADC #$00
    STA COPY2+1                 ;work For copy: to
L896C
    LDY #$08
    LDA (COPY2),Y               ;work For copy: to
    BEQ L89CE
    DEY
L8973
    LDA (COPY2),Y               ;work For copy: to
    CMP TXT,Y                   ;string constant buffer
    BNE L895F
    DEY
    CPY #$FF
    BNE L8973
    LDY #$08
    LDA (COPY2),Y               ;work For copy: to
    JMP L8A29
---------------------------------
    LDA #<L8a2d
    STA COPY2                   ;work For copy: to
    LDA #>L8a2d
    STA COPY2+1                 ;work For copy: to
    JMP L899E
---------------------------------
L8991
    CLC
    LDA #$09
    ADC COPY2                   ;work For copy: to
    STA COPY2                   ;work For copy: to
    LDA COPY2+1                 ;work For copy: to
    ADC #$00
    STA COPY2+1                 ;work For copy: to
L899E
    LDY #$08
    LDA (COPY2),Y               ;work For copy: to
    BEQ L8940
    DEY
L89A5
    LDA (COPY2),Y               ;work For copy: to
    EOR TXT,Y                   ;string constant buffer
    CMP #$FF
    BNE L8991
    DEY
    CPY #$FF
    BNE L89A5
    LDA #$12
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    LDY #$08
    LDA (COPY2),Y               ;work For copy: to
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    LDA TXTLO                   ;address of text for print
    CMP #$4F
    BNE L89C9
    RTS
---------------------------------
L89C9
    LDA #$92
    JMP L8A29
---------------------------------
L89CE
    LDA #$8D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN
    LDA #$65
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    LDA #$00
    STA Q5
L89EA
    LDY Q5
    LDA TXT,Y                   ;string constant buffer
    STA TXT+8,Y                 ;string constant buffer
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    INC Q5
    LDA Q5
    CMP #$08
    BNE L89EA
    LDA #$0D
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    JSR UNLSN                   ;COMMAND DEVICE TO UNLISTEN
    LDA #$04
    JSR LISTN                   ;COMMAND DEVICE TO LISTEN
    LDA #$60
    JSR SECOND                  ;SEND SA AFTER LISTEN
    JSR L8703
    LDA TXTLO                   ;address of text for print
    STA Q5
    BEQ L8A27
L8A1B
    LDA #$20
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    JSR L8703
    DEC Q5
    BNE L8A1B
L8A27
    LDA #$FE
L8A29
    JSR CIOUT                   ;OUTPUT BYTE TO  SERIAL PORT
    RTS

L8a2d !by $ff,$ff
L8a2f !by $ff,$ff,$00,$00,$00,$00,$a1,$0f
L8a37 !by $0f,$0f,$0f,$0f,$0f,$0f,$0f,$a2
L8a3f !by $80,$80,$80,$80,$80,$80,$80,$80
L8a47 !by $a3,$01,$01,$01,$01,$01,$01,$01
L8a4f !by $01,$a4,$ff,$00,$00,$00,$00,$00
L8a57 !by $00,$00,$a5,$00,$00,$00,$00,$00
L8a5f !by $00,$00,$ff,$a7,$00,$00,$00,$00
L8a67 !by $00,$00,$ff,$ff,$aa,$00,$00,$00
L8a6f !by $00,$0f,$0f,$0f,$0f,$ac,$03,$03
L8a77 !by $03,$03,$03,$03,$03,$03,$af,$ff
L8a7f !by $ff,$00,$00,$00,$00,$00,$00,$b4
L8a87 !by $ff,$ff,$ff,$00,$00,$00,$00,$00
L8a8f !by $b5,$00,$00,$00,$00,$00,$ff,$ff
L8a97 !by $ff,$b6,$c0,$c0,$c0,$c0,$c0,$c0
L8a9f !by $c0,$c0,$b7,$e0,$e0,$e0,$e0,$e0
L8aa7 !by $e0,$e0,$e0,$b8,$07,$07,$07,$07
L8aaf !by $07,$07,$07,$07,$b9,$0f,$0f,$0f
L8ab7 !by $0f,$00,$00,$00,$00,$bb,$00,$00
L8abf !by $00,$00,$f0,$f0,$f0,$f0,$bc,$f0
L8ac7 !by $f0,$f0,$f0,$00,$00,$00,$00,$be
L8acf !by $08,$08,$08,$08,$08,$08,$08,$08
L8ad7 !by $c0,$00,$00,$00,$ff,$00,$00,$00
L8adf !by $00,$c2,$10,$10,$10,$10,$10,$10
L8ae7 !by $10,$10,$c3,$20,$20,$20,$20,$20
L8aef !by $20,$20,$20,$c4,$40,$40,$40,$40
L8af7 !by $40,$40,$40,$40,$c5,$04,$04,$04
L8aff !by $04,$04,$04,$04,$04,$c6,$00,$00
L8b07 !by $ff,$00,$00,$00,$00,$00,$c7,$00
L8b0f !by $00,$00,$00,$00,$ff,$00,$00,$c8
L8b17 !by $80,$40,$20,$10,$08,$04,$02,$10
L8b1f !by $cd,$01,$02,$04,$08,$10,$20,$40
L8b27 !by $80,$ce,$02,$02,$02,$02,$02,$02
L8b2f !by $02,$02,$d2,$00,$ff,$00,$00,$00
L8b37 !by $00,$00,$00,$d4,$00,$00,$00,$00
L8b3f !by $00,$00,$ff,$00,$d9,$00,$00,$00
L8b47 !by $00,$ff,$00,$00,$00,$dd,$00,$00
L8b4f !by $00,$00,$00,$00,$00,$00,$a0,$00
L8b57 !by $00,$00,$00,$00,$00,$00,$00,$00