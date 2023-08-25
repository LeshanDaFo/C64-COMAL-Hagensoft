

## C64 COMAL Hagensoft extension

Information about COMAL itself can be found here:<br />
https://www.c64-wiki.com/wiki/Commodore-64_Comal_80_rev_2.01<br />
<br />

### Hagensoft for COMAL80 is an extension for the existing COMAL80 module for the C64/C128

#### Info about the modules:

This extension is available in 2 different versions.

Image hagensoft 105 Image Hagensoft 1.21

### Hagensoft rev 1.05

Version 1.05 extends COMAL80 by 3 new 'packages'.

   1. The 'DEUTSCH' package
   2. The 'MATRIX' package
   3. The 'DUMP802' package

to 1.
<br />
In the basic version of COMAL80, the output of the error messages is available in the languages 'DANSK' and 'ENGLISH'.<br />
With the language pack contained in the extension, the language 'DEUTSCH' has been added, which is activated by default when the extension is started.

With the command 'USE >language<' you can switch the output of the error messages back to another existing language at any time.

to 2.
<br />
The 'MATRIX' package can be activated with 'USE MATRIX', and offers 10 new additional commands.<br />
   "MATPUT", "MATADD", "MATSUB", "MATCOM", "MATNULL", "MATUNIT", "MATMULT", "MATTRANS", "DEMAT", "NULLMAT", "EQMAT"
<br />
At this point, I have not examined in detail how the commands are used and what they do.

to 3.
<br />
The package "DUMP802" can be activated with 'USE DUMP802", and offers 3 new additional commands.<br />
   "DUMP', "MEMORY", "PALETTE"
<br />
I didn't do any further research here either.

### Hagensoft rev 1.21
In version 1.21 the DUMP802 package has been slightly modified and a fourth package called HAGENSOFT has been added.

The HAGENSOFT package can be integrated with 'USE HAGENSOFT'.

The "MEMORY" and "PALETTE" commands have been removed from the DUMP802 package and included in the new "HAGENSOFT" package.
The HAGENSOFT package contains a total of 8 commands including these two commands.<br />
     "MEMORY", "PALETTE", "EDGE", SYMBOLS", "GETSHAPE", "BDRAW", "ELLIPSE", "LEARN", "EVAL", "EXECUTE"


At this point I would like to point out again that I have not examined the commands further.
The point here is not to describe the functions or procedures
I just want to present the source code I created from the modules.

The source code was created on the basis of COMAL80 Hagensoft extensions freely available on the Internet.<br />
The extensions created with this source code were compared by me with the existing data and correspond to this 1:1

With the source code I created and made available, it should be possible to create your 'own' extension.
So you can e.g. change contained commands, remove them or replace them with new ones.

The source code is mostly undocumented, only in a few places I have added some documentation.

Information about the structure of a COMAL extension and its packages can be found e.g. here in this book.<br />
https://archive.org/details/comal-80-for-the-commodore-64/page/n255/mode/2up.
