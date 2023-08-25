; ###############################################################
; #                                                             #
; #  hagensoft.asm for                                          #
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

;8b5f
symbols_h   !by PROC, <symbols,>symbols,    $00, ENDPRC

symbols;8b64
!source"code/hs_121/hagensoft/symbols.asm"

;8e04
getshape_h  !by PROC, <getshape,>getshape,  $03,$73,$73,$73, ENDPRC

getshape;8e0c
!source"code/hs_121/hagensoft/getshape.asm"

;8f2a
ellipse_h   !by PROC, <ellipse,>ellipse,    $05,$72,$72,$72,$72,$72, ENDPRC
;8f34
bdraw_h     !by PROC, <bdraw,>bdraw,        $01,$7c,$02, ENDPRC

bdraw;8f3b
!source"code/hs_121/hagensoft/bdraw.asm"

ellipse;908c
!source"code/hs_121/hagensoft/ellipse.asm"

;922d
edge_h      !by PROC, <edge,>edge,          $00, ENDPRC
; $9232
; the jump in for edge is at $924d
!source"code/hs_121/hagensoft/edge.asm"

;92f4
learn_h     !by PROC, <learn,>learn,        $01,$74, ENDPRC
;92fa
eval_h      !by PROC, <eval,>eval,          $01,$74, ENDPRC
;9300
execute_h   !by PROC, <execute,>execute,    $00, ENDPRC

learn;9305
!source"code/hs_121/hagensoft/learn.asm"

eval;93ba

L93ba ;!by $20,$05,$93
    JSR learn

execute;93bd
!source"code/hs_121/hagensoft/execute.asm"
