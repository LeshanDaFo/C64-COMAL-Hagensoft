; ###############################################################
; #                                                             #
; #  errmsg.asm for                                             #
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

; these are the German error messages
    !word errmsg2 ; $9c83 $933f
    !pet $00,$0d,"report-fehler"
    !pet $01,$0f,"argument falsch"
    !pet $02,$09,"ueberlauf"
    !pet $03,$13,"division durch null"
    !pet $04,$0f,"teiltext-fehler"
    !pet $05,$10,"unerlaubter wert"
    !pet $06,$08,"step = 0"
    !pet $07,$11,"unerlaubte grenze"
    !pet $08,$18,"fehler bei 'print using'"

    !pet $0a,$16,"unerlaubter index-wert"
    !pet $0b,$15,"ungueltiger dateiname"

    !pet $0d,$13,"fehler bei 'verify'"
    !pet $0e,$11,"programm zu gross"
    !pet $0f,$15,"schlechter comal-code"
    !pet $10,$13,"kein comal-programm"
    !pet $11,$22,"programm fuer andere comal-version"
    !pet $12,$1a,"unbekanntes datei-attribut"

    !pet $1e,$11,"unmoegliche farbe"
    !pet $1f,$16,"unerlaubte bildgrenzen"
    !pet $20,$18,"unerlaubte muster-nummer"
    !pet $21,$1a,"muster-laenge muss 64 sein"
    !pet $22,$18,"unerlaubte sprite-nummer"
    !pet $23,$18,"unmoegliche stimm-nummer"
    !pet $24,$0c,"falsche note"
    !pet $25,$0f,"matrix zu gross"
    !pet $26,$19,"unpassende matrixgroessen"
    !pet $27,$1c,"matrix muss quadratisch sein"

    !pet $33,$0d,"system-fehler"
    !pet $34,$0d,"speicher voll"
    !pet $35,$1f,"falsche dimension bei parameter"
    !pet $36,$20,"parameter muss eine tabelle sein"
    !pet $37,$10,"zu wenig indizes"
    !pet $38,$1c,"kann variable nicht zuweisen"
    !pet $39,$0f,"nicht eingebaut"
    !pet $3a,$14,"'con' nicht moeglich"
    !pet $3b,$18,"programm wurde geaendert"
    !pet $3c,$10,"zu viele indizes"
    !pet $3d,$1e,"funktionswert nicht uebergeben"
    !pet $3e,$0e,"keine variable"

    !pet $43,$34,"verschiedene parameter-listen oder nicht geschlossen"
    !pet $44,$25,"keine geschlossene proc/func in datei"
    !pet $45,$12,"zu wenig parameter"
    !pet $46,$11,"falscher indextyp"
    !pet $47,$1c,"parameter muss variable sein"
    !pet $48,$16,"falscher parameter-typ"
    !pet $49,$15,"nicht-ram ladeversuch"
    !pet $4a,$1f,"falsche quersumme in .obj-datei"
    !pet $4b,$1e,"speicherbereich ist geschuetzt"
    !pet $4c,$15,"zu viele bibliotheken"
    !pet $4d,$10,"keine .obj-datei"
    !pet $4e,$13,"kein passendes when"
    !pet $4f,$12,"zu viele parameter"

    !pet $65,$0d,"syntax-fehler"
    !pet $66,$0c,"falscher typ"
    !pet $67,$25,"anweisung zu lang oder zu kompliziert"   
    !pet $68,$1c,"kein kommando, nur anweisung"

    !pet $6a,$1d,"zeilennummern: von 1 bis 9999"

    !pet $6c,$21,"prozedur/funktion existiert nicht"
    !pet $6d,$2a,"strukturierte anweisung hier nicht erlaubt"
    !pet $6e,$0f,"keine anweisung"
    !pet $6f,$26,"zeilennummern werden groesser als 9999"
    !pet $70,$09,"geheim!!!"
    !pet $71,$13,"unerlaubtes zeichen"
    !pet $72,$13,"fehler in konstante"
    !pet $73,$14,"fehler im exponenten"

    !pet $c8,$10,"keine daten mehr"
    !pet $c9,$09,"dateiende"

    !pet $ca,$15,"datei schon geoeffnet"
    !pet $cb,$15,"datei nicht geoeffnet"
    !pet $cc,$13,"keine eingabe-datei"
    !pet $cd,$13,"keine ausgabe-datei"
    !pet $ce,$16,"zahlkonstante erwartet"
    !pet $cf,$0f,"keine rel-datei"
    !pet $d0,$13,"geraet nicht bereit"
    !pet $d1,$16,"zu viele dateien offen"
    !pet $d2,$0a,"lesefehler"
    !pet $d3,$0d,"schreibfehler"
    !pet $d4,$15,"kurzer block auf band"
    !pet $d5,$15,"langer block auf band"
    !pet $d6,$1a,"falsche quersumme auf band"
    !pet $d7,$08,"bandende"
    !pet $d8,$14,"datei nicht gefunden"
    !pet $d9,$12,"unbekanntes geraet"
    !pet $da,$10,"das ist verboten"
    !pet $db,$09,"e/a stopp"
    !pet $e6,$09,$0d,"ende in "
    !pet $e7,$09,$0d,"stop in "
!if HSOFT = 121 {
    !pet $e8,$37," bytes frei.",$0d,$0d," *** plus HagenSoft Eprom  rev 1.21 ***",$0d,$0d
}
!if HSOFT = 105 {
    !pet $e8,$37," bytes frei.",$0d,$0d," *** plus hagensoft eprom  rev 1.05 ***",$0d,$0d
}
    !pet $e9,$06,"fehler"

    !pet $f2,$03,"in "
    !pet $f3,$11,"prgrm daten frei",$0d
    !pet $f4,$15,"das programm hielt in"
    !pet $f5,$17,"was aufgerufen wird von"
    !pet $f6,$09,"innerhalb"

    !by $FF
; $9c83 $933f
errmsg2
    !by $01,$f9,$01,$fa
    !pet $08,$61," oder ",$5f
    !pet $10,"unbekannte marke"
    !pet $14,"name schon definiert"
    !pet $0b,"keine marke"
    !pet $20,"textvariable nicht dimensioniert"
    !pet $0a,"kein paket"
    !pet $08,"ausdruck"
    !pet $08,"variable"
    !pet $07,"operand"
    !pet $0e,"variablen-name"
    !pet $17,"name einer zahlvariable"
    !pet $14,"numerischer ausdruck"
    !pet $0d,"text-ausdruck"
    !pet $08,$c6," oder ",$60
    !pet $08,$61," oder ",$ca
    !pet $08,$c6," oder ",$c7
    !pet $08,$cb," oder ",$cd
    !pet $05,"modus"
    !pet $09,"konstante"
    !pet $0c,"zeilennummer"
    !pet $0f,"binaerkonstante"
    !pet $05,"marke"

    !by $05,$71,$2f,$72,$2f,$75
    !by $01,$75
    !by $01,$76
    !by $01,$f0
    !by $01,$f5
    !by $01,$b0
    !by $01,$77
    !by $05,$b2,$2f,$93,$2f,$74
    !by $05,$b2,$2f,$93,$2f,$74
    !by $01,$74

    !pet $0f," nicht erwartet"
    !pet $06," fehlt"
    !pet $10," erwartet statt "
    !pet $10,"reelle konstante"
    !pet $12,"ganzzahl-konstante"
    !pet $0e,"text-konstante"
    !pet $04,"name"
    !pet $0d,"ganzzahl-name"
    !pet $12,"textvariablen-name"
    !pet $24," nicht erlaubt in kontrollstrukturen"
    !pet $06," ohne "

    !by $01,$f4
    !by $01,$b2
    
    !pet $28,$e2," nur in geschlossener proc/func erlaubt"
    !pet $11,"falscher typ bei "
    !pet $12,"falscher name bei "
    !pet $08,$68," oder ",$ce
    !pet $0d,"hex-konstante"
    !pet $0d,"unerlaubtes ",$80
    !pet $22,"unbekannte anweisung oder prozedur"
    !pet $0e,"keine prozedur"
    !pet $13,"unbekannte variable"
    !pet $0c,"falscher typ"
    !pet $15,"falscher funktionstyp"
    !pet $1b,"weder tabelle noch funktion"
    !pet $17,"keine einfache variable"
    !pet $20,"unbekannte tabelle oder funktion"
    !pet $15,"falscher tabellen-typ"
    !pet $0d,"import-fehler"
    !pet $11,"unbekanntes paket"