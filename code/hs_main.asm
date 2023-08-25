; ###############################################################
; #                                                             #
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

IERTXT      =   $C7E4           ;error message data
DUMMY       =   $ca2f           ;empty subroutine (rts)


HSOFT = 121

!source"code/c64symb.asm"

start   =   $8000


*= start

    !word COLD
    !word WARM

    !pet "CBM80comal"

    !by >start                  ; $80
    !by PAGE5 + ROMMED          ; PAGE 5 =$84 + %00010000 <> $95

    !word .end                  ; the program end address
    !word signal                ; the address of the signal handler

; start of package table
; package 1
    !pet $07,"deutsch"          ; char amount, 'name'
    !word proct1                ; proc's name table address     ;$8045, $8037
    !word init1                 ; package init address          ;$8059;, $803d
; package 2
    !pet $06,"matrix"
    !word proct2    ;$8069;, $804d
    !word DUMMY     ;ca2f
; package 3
    !pet $07,"dump802"
    !word proct3    ;$80d2;, $80b6
    !word DUMMY     ;$ca2f

; the next is only available in hagensoft 1.21
!if HSOFT = 121 {
; package 4
    !pet $07,"hagensoft"
    !word proct4    ;$80da
    !word DUMMY     ;$ca2f    
}
; end package table

proct1
; there are no commands for execution on the first package,
; so here is a zero byte only
    !by $00

; in hagensoft 1.05, and hagensoft 1.21 the signal routines are different
signal ; $8046 $8038
!if HSOFT = 105 {
    CPY #$01
    BEQ init1
    RTS
}
!if HSOFT = 121 {
    CPY #$01
    beq .skip2
    CPY #$09
    bne .skip3
    LDA $55
    BEQ .skip3
    JMP $93E8   ;located in execute part
.skip2
    LDA #$00
    sta $55   
}

init1 ; $8059 $803d
; prepare new location pointer for the error text messages to print
; thats all here to do
    LDA #<errmsg                ; new address low byte
    LDX #>errmsg                ; new address high byte
    ldy #$94                    ; page + rommed ?
    
    STA IERTXT                  ; error message data
    STX IERTXT+1                ; the sytem will look here
    STY IERTXT+2                ; where to find the error messages
.skip3
    RTS 

; table of procedure names
; name length,  procname,  procheader pointer
proct2 ; $8069 $804d
    !pet $06,"matput"
    !word matput_h
    !pet $06,"matadd"
    !word matadd_h
    !pet $06,"matsub"
    !word matsub_h
    !pet $06,"matcom"
    !word matcom_h
    !pet $07,"matnull"
    !word matnull_h
    !pet $07,"matunit"
    !word matunit_h
    !pet $07,"matmult"
    !word matmult_h
    !pet $08,"mattrans"
    !word mattrans_h
    !pet $06,"detmat"
    !word detmat_h
    !pet $07,"nullmat"
    !word nullmat_h
    !pet $05,"eqmat"
    !word eqmat_h

    !by $00

proct3 ; $80d2 $80b6
    !pet $04,"dump"
    !word dump_h

; if hagensoft 1.05 is selected, the next 2 commands are included in the dump package
; for hagensoft 1.21 is here an separator to define the table end
; and the next 2 commands are moved out to 'hagensoft package'

!if HSOFT = 121 {
    !by $00
}
proct4 ; $80da $80bd
    !pet $06,"memory"
    !word memory_h
    !pet $07,"palette"
    !word palette_h

; this next byte is the endmark for hagensoft 1.05 only
; after this, the header tables are started
; if hagensoft 1.21 is selected, the package 'hagensoft' continues with the command part,
; and go on with the next following 8 commands.

!if HSOFT = 105 {
    !by $00 ; $80d0
}

!if HSOFT = 121 {
; $80ed
!source"code/hs_121/addcmds.asm"

}

; proc-/func-header table
; the first byte indicates if it is a function, or a procedur, either $70 for proc, or $e3+x for func
; the second and third bytes in each header are command start addresses
; the following byte is the parameter amount
; the next bytes are the the parameter types according the amount
; every header's end is marked with a $7e byte for ENDPRC

;8135
matput_h    !by PROC, <matput,>matput,      $02,    $7b,$02,$7b,$02, ENDPRC
;813e
matadd_h    !by PROC, <matadd,>matadd,      $03,    $7b,$02,$7b,$02,$7b,$02, ENDPRC
;8149
matsub_h    !by PROC, <matadd+3,>matadd+3,  $03,    $7b,$02,$7b,$02,$7b,$02, ENDPRC
;8154
matnull_h   !by PROC, <matnull,>matnull,    $01,    $7b,$02, ENDPRC
;815b
matcom_h    !by PROC, <matcom,>matcom,      $05,    $72,$7b,$02,$72,$7b,$02,$7b,$02, ENDPRC
;8168
matunit_h   !by PROC, <matunit,>matunit,    $01,    $7b,$02, ENDPRC
;816f
matmult_h   !by PROC, <matmult,>matmult,    $03,    $78,$02,$78,$02,$7b,$02, ENDPRC
;817a
mattrans_h  !by PROC, <mattrans,>mattrans,  $02,    $78,$02,$7b,$02, ENDPRC

;8183
detmat_h    !by FUNC,  <detmat,>detmat,     $01,    $78,$02, ENDFNC
;818a
nullmat_h   !by FUNC,  <nullmat,>nullmat,   $01,    $7b,$02, ENDFNC
;8191
eqmat_h     !by FUNC,  <eqmat,>eqmat,       $02,    $7b,$02,$7b,$02, ENDFNC

;819a
dump_h      !by PROC, <dump,>dump,          $01,    $73, ENDPRC
;81a0
memory_h    !by FUNC+STR, <memory,>memory,  $01,    $72, ENDFNC
;81a6
palette_h   !by PROC, <palette,>palette,    $02,    $73,$73, ENDPRC


matput;81ad
!source"code/hs_comm/matrix/matput.asm"

matadd;822b
!source"code/hs_comm/matrix/matadd.asm"
;matsub is located in matadd

matcom;8298
!source"code/hs_comm/matrix/matcom.asm"

matnull;8357
!source"code/hs_comm/matrix/matnull.asm"

matunit;8379
!source"code/hs_comm/matrix/matunit.asm"

mattrans;83b8
!source"code/hs_comm/matrix/mattrans.asm"

matmult;840c
!source"code/hs_comm/matrix/matmult.asm"

nullmat;84b8
!source"code/hs_comm/matrix/nullmat.asm"

eqmat;84dd
!source"code/hs_comm/matrix/eqmat.asm"

detmat;8525
!source"code/hs_comm/matrix/detmat.asm"

memory;864a
!source"code/hs_comm/dump802/memory.asm"

palette;8666
!source"code/hs_comm/dump802/palette.asm"

dump;86df
!source"code/hs_comm/dump802/dump.asm"


!if HSOFT = 121 {
;8b5f
!source"code/hs_121/hagensoft.asm"
}


errmsg;943f
!source"code/hs_comm/errmsg.asm"

.end
; the next 2 parts are only for filling the memory up to $A000
!if HSOFT = 121 {
!source"code/hs_121/dummy.asm"

}
!if HSOFT = 105 {
!source"code/hs_105/dummy.asm"
}
