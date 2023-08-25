; ###############################################################
; #                                                             #
; #  addcmds.asm for                                            #
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

; here are the additional commands of the 'hagensoft package'
; $80ed
    !pet $04,"edge" ; $922d
    !word edge_h
    !pet $07,"symbols" ;$8b5f
    !word symbols_h
    !pet $08,"getshape" ; $8e04
    !word getshape_h
    !pet $05,"bdraw" ; $8f34
    !word bdraw_h
    !pet $07,"ellipse" ; $8f2a
    !word ellipse_h
    !pet $05,"learn" ; $92f4
    !word learn_h
    !pet $04,"eval" ; $92fa
    !word eval_h
    !pet $07,"execute" ; $9300
    !word execute_h

    ; $8134
    !by $00