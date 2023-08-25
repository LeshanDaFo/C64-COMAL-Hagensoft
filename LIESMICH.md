# COMAL

## C64 COMAL Hagensoft extension

Informationen ueber COMAL selbst findet man hier:<br />
https://www.c64-wiki.de/wiki/Commodore-64_Comal_80_rev_2.01 <br />
und auch hier:<br />
https://www.c64-wiki.com/wiki/Commodore-64_Comal_80_rev_2.01<br />
<br />

### Hagensoft fuer COMAL80 ist eine Erweiterung fuer das existierende COMAL80 Modul fuer den C64/C128

#### Info zu den Modulen:

Diese Erweiterung gibt es in 2 verschiedenen Versionen.

#### Hagensoft Screenshots<br />
<div align="left">
<table border="0" cellpadding="6" width="600">
 <tr>
  <td align="center"><img src="https://github.com/LeshanDaFo/C64-COMAL-Hagensoft/assets/97148663/1da33654-0797-44f4-8c39-5b5fa416ae2f" width="320" height="240"></td>
  <td align="center"><img src="https://github.com/LeshanDaFo/C64-COMAL-Hagensoft/assets/97148663/16837d13-2e75-4ec7-8b2b-73991ee3fe3d" width="320" height="240"></td>
 </tr>
</table>
</div>

### Hagensoft rev 1.05

Die Version 1.05 erweitert COMAL80 um 3 neue 'Pakete'.

  1. Das Paket 'DEUTSCH'
  2. Das Paket 'MATRIX'
  3. Das Paket 'DUMP802'

zu 1.
<br />
In der Basis-Version von COMAL80 sind die Ausgaben der Fehlermeldungen in den Sprachen 'DANSK' und 'ENGLISH' vorhanden.<br />
Mit dem in der Erweiterung enthaltenem Sprachpaket, ist die Sprache 'DEUTSCH' hinzugekommen, diese ist beim Start der Erweiterung standardmaessig aktiviert.

Mit dem Befehl 'USE >sprache<' kann man jederzeit die Ausgabe der Fehlermeldungen wieder auf eine andere vorhandene Sprache umschalten.

zu 2.
<br />
Das Paket 'MATRIX" wird mit 'USE MATRIX' aktiviert, und bietet 10 neue zusaetzliche Befehle.<br />
  "MATPUT", "MATADD", "MATSUB", "MATCOM", "MATNULL", "MATUNIT", "MATMULT", "MATTRANS", "DEMAT", "NULLMAT", "EQMAT"
<br />
Wie die Befehle angewendet werden, und was sie bewirken, habe ich an dieser Stelle nicht naeher untersucht.

zu 3.
<br />
Das Paket "DUMP802" wird mit 'USE DUMP802" aktiviert, und bietet 3 neue zusaetzliche Befehle.<br />
  "DUMP', "MEMORY", "PALETTE"
<br />
auch hier habe ich keine weitere Untersuchung gemacht.

### Hagensoft rev 1.21
In der Version 1.21 wurde das Paket DUMP802 etwas veraendert, und ein viertes Paket mit dem Namen HAGENSOFT hinzugefuegt.

Das Paket HAGENSOFT kann mit 'USE HAGENSOFT' eingebunden werden.

Die Befehle "MEMORY" und "PALETTE" wurden aus dem Paket DUMP802 entfernt, und in das neue Paket "HAGENSOFT" mit aufgenommen.
Das Paket HAGENSOFT enthaelt inklusive dieser zwei Befehlen insgesammt 8 Befehle.<br />
    "MEMORY", "PALETTE", "EDGE", SYMBOLS", "GETSHAPE", "BDRAW", "ELLIPSE", "LEARN", "EVAL", "EXECUTE"


Hier an dieser Stelle moechte ich nochmals darauf hinweisen, dass ich die Befehle nicht weiter untersucht habe.
Es geht hier nicht darum geht, die Funktionen, oder Prozeduren zu beschreiben, 
ich moechte hier lediglich den von mir aus den Modulen erstellten Source-Code vorstellen.

Der Source-Code wurde auf Basis von frei im Internet verfuegbaren COMAL80 Hagensoft Erweiterungen erstellt.<br />
Die mit diesem Source-Code erstellten Erweiterungen wurden vom mir mit den existierenden Daten verglichen, und entsprechen diesen 1:1

Mit dem von mir erstellten und zur Verfuegung gestelltem Source-Code sollte es moeglich sein, seine 'eigene' Erweiterung zu erstellen.
So kann man z.B enthaltene Befehle aendern, entfernen, oder durch neue ersetzten.

Der Source-Code ist groesstenteils undokumentiert, lediglich an einigen wenigen Stellen habe ich etwas Dokumentation hinzugefuegt.

Informationen Ueber den Aufbau einer COMAL-Erweiterung, und deren Pakete finded man z.B hier in diesem Buch.<br />
https://archive.org/details/comal-80-for-the-commodore-64/page/n255/mode/2up.

