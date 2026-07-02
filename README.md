# C64 COMAL Hagensoft Extension

> Reconstructed source code of the original **Hagensoft extension** for
> **COMAL80 Revision 2.01** on the Commodore 64 and Commodore 128.

------------------------------------------------------------------------

## Overview

The Hagensoft extension is an add-on ROM for the original **COMAL80
Revision 2.01** cartridge.

This repository contains a reconstructed version of the original
Hagensoft source code for the Commodore 64 and Commodore 128.

Its purpose is to preserve the original extension and provide a solid
foundation for developing your own COMAL80 extensions.

------------------------------------------------------------------------

## Features

-   Reconstructed original source code
-   Supports Hagensoft Revision **1.05**
-   Supports Hagensoft Revision **1.21**
-   Binary identical ROM images
-   ACME build system
-   Generates both `.bin` and `.chip` images

------------------------------------------------------------------------

## Repository Structure

``` text
assets/     Screenshots
build/      Generated output
code/       Source code
scripts/    Build scripts
```

------------------------------------------------------------------------

## Hagensoft for COMAL80

Hagensoft is an extension for the original **COMAL80 Revision 2.01**
cartridge and therefore **cannot be used as a standalone cartridge**.

Supported revisions:

-   **Revision 1.05**
-   **Revision 1.21**

------------------------------------------------------------------------

## Screenshots

<div align="left">
<table border="0" cellpadding="6" width="600">
<tr>
<td align="center"><img src="assets/hagensoft_rev_1.05.png" alt="Hagensoft Rev. 1.05" width="320" height="240"></td>
<td align="center"><img src="assets/hagensoft_rev_1.21.png" alt="Hagensoft Rev. 1.21" width="320" height="240"></td>
</tr>
</table>
</div>

------------------------------------------------------------------------

## Building

The project is assembled using the **ACME Cross Assembler**.

### Configuration

``` sh
cp scripts/config.sh.example scripts/config.sh
```

Edit `scripts/config.sh` and configure:

-   Path to the ACME assembler
-   Hagensoft revision (`105` or `121`)

Example:

``` sh
ACME="acme"
HSOFT=121
```

### Build

``` sh
sh scripts/build.sh
```

Generated files are written to the `build` directory:

-   `hagensoft_105.bin`
-   `hagensoft_105.chip`
-   `hagensoft_121.bin`
-   `hagensoft_121.chip`

The `.bin` file contains the raw 8 KB ROM image.

The `.chip` file contains the same ROM image with a VICE-compatible CHIP
header.

------------------------------------------------------------------------

## About COMAL80

Further information:

-   https://www.c64-wiki.com/wiki/Commodore-64_Comal_80_rev_2.01

Documentation about COMAL extensions:

-   https://archive.org/details/comal-80-for-the-commodore-64/page/n255/mode/2up

## Hagensoft Revision 1.05

Version **1.05** extends COMAL80 with three additional packages:

1.  **DEUTSCH**
2.  **MATRIX**
3.  **DUMP802**

### DEUTSCH

The original COMAL80 cartridge provides error messages in the languages
**DANSK** and **ENGLISH**.

The Hagensoft extension adds the **DEUTSCH** language package, which is
enabled by default.

The command

``` text
USE <language>
```

can be used to switch between the installed language packages.

### MATRIX

Activate with:

``` text
USE MATRIX
```

Additional commands:

``` text
MATPUT
MATADD
MATSUB
MATCOM
MATNULL
MATUNIT
MATMULT
MATTRANS
DEMAT
NULLMAT
EQMAT
```

The functionality of these commands has not yet been examined in detail.

### DUMP802

Activate with:

``` text
USE DUMP802
```

Commands:

``` text
DUMP
MEMORY
PALETTE
```

These commands have not been examined further.

------------------------------------------------------------------------

## Hagensoft Revision 1.21

Revision **1.21** modifies the **DUMP802** package and introduces a
fourth package named **HAGENSOFT**.

Activate with:

``` text
USE HAGENSOFT
```

The commands **MEMORY** and **PALETTE** were moved from **DUMP802** into
**HAGENSOFT**.

Additional commands:

``` text
MEMORY
PALETTE
EDGE
SYMBOLS
GETSHAPE
BDRAW
ELLIPSE
LEARN
EVAL
EXECUTE
```

As with Revision 1.05, the purpose of this repository is **not** to
document the functionality of these commands.

------------------------------------------------------------------------

## Source Code

The source code was reconstructed from original Hagensoft ROM images
that are freely available on the Internet.

The generated ROM images have been compared against the original ROMs
and are **binary identical**.

Although the source code is still largely undocumented, comments have
been added where useful.

------------------------------------------------------------------------

## Development

The project is assembled using the **ACME Cross Assembler**.

The build system is located in the `scripts` directory.

Generated output files are written to the `build` directory.

------------------------------------------------------------------------

## License / Disclaimer

This reconstructed source code is provided for educational and
preservation purposes.

Please use it at your own risk.
