; .OPT NOSYM
;
;
;       +------------------------------------------------+
;       !                                                !
;       !                                                !
;       !     ******  COMMODORE 64  COMAL-80  ******     !
;       !                                                !
;       !     (C) COPYRIGHT UNICOMAL APS. 1984, 1985     !
;       !                                                !
;       !                                                !
;       !  C64SYMB FOR COMMODORE 64  COMAL-80 REV. 2.01  !
;       !                                                !
;       !                                                !
;       +------------------------------------------------+
;
;
;
TRUE =1
FALSE =0
;
PAGE0 =%11100000 ;NO EXPANSION
PAGE1 =%10000000 ;CARTRIDGE OVERLAY 1 ($8000-$BFFF)
PAGE2 =%10000001 ;CARTRIDGE OVERLAY 2 ($8000-$BFFF)
PAGE3 =%10000010 ;CARTRIDGE OVERLAY 3 ($8000-$BFFF)
PAGE4 =%10000011 ;CARTRIDGE OVERLAY 4 ($8000-$BFFF)
PAGE5 =%10000100 ;CARTRIDGE OVERLAY 5 ($8000-$BFFF)
PAGE6 =%10000101 ;CARTRIDGE OVERLAY 6 ($8000-$BFFF)
;
PAGEA =PAGE2 ;COMAL PAGE A
PAGEB =PAGE3 ;COMAL PAGE B
PAGEC =PAGE1 ;COMAL PAGE C
;
;
;
;     PAGE ZERO VARIABLES:
;     ====================
;
 *=$0000
;
D6510 *=*+1 ;6510 ON-CHIP DATA-DIRECTION REGISTER
R6510 *=*+1 ;6510 ON-CHIP 6-BIT I/O/MAP-REGISTER:
LORAM =%00000001 ;  CONTROL FOR RAM/ROM AT $A000-$BFFF (BASIC)
HIRAM =%00000010 ;  CONTROL FOR RAM/ROM AT $E000-$FFFF (KERNAL)
CHAREN =%00000100 ;  CONTROL FOR I/O/ROM AT $D000-$DFFF
NORM =%00110111 ;  COMAL MEMORY MAP
;
PRPROC *=*+3 ;CHAIN OF LOCAL NAMES (PREPASS)
INTEGR *=*+1 ;FP WORK
;
;  MEMORY MAP CONTROL
;
PAGE *=*+1 ;CURRENT MEMORY MAP
CM8096 =PAGE
MEMMAP =PAGE
PAGEPT *=*+2 ;POINTER USED BY LOAD/STORE/EXEC
PAGEX *=*+1 ;OVERLAY FOR LOAD/STORE/EXEC ROUTINES
PAGEY *=*+1 ;OVERLAY USED FOR CONTROL OF JUMP TABLE
P6510 *=*+1 ;OLD C64-OVERLAY FOR CONTROL OF JUMP TABLE
RESOL *=*+1 ;GRAPHICS RESOLUTION
GCOLH *=*+1 ;GRAPHICS PENCOLOR*16
;
;  COMAL VARIABLES
;
LOCLPT *=*+2 ;CHAIN OF OLD VARIABLE DESCRIPTIONS
FORPT *=*+2 ;STACK ENTRY CHAIN
SCTYPE *=*+1 ;TYPE OF SYMBOL FROM SCANNER
TANSGN *=*+1 ;TAN SIGN / COMPARISON EVALUATION FLAG
CODE *=*+1 ;USED TO HOLD A GENERATED CODE
CPNT *=*+1 ;POINTER TO CODE BUFFER, CDBUF
CLIMIT =255 ;LIMIT OF CPNT
SPROG *=*+2 ;PNT TO START OF PROGRAM
SVARS *=*+2 ;PNT TO START OF VARIABLE TABLE
SSTACK *=*+2 ;PNT TO START OF STACK
SMAX *=*+2 ;PNT TO TOP OF MEMORY
EXINF *=*+1 ;INF FOR RESULT EXPRESSION FROM EXPR
SCERR =$01
SCLNO =$08 ;SET, IF NUMBER CAN BE A LINE NUMBER
LNLEN *=*+1 ;LENGTH OF LINE TO BE EXECUTED
NPNT *=*+1 ;POINTER TO NAME
TPNT *=*+1 ;POINTER TO STRING
TLIMIT =80
;
INDEX1 *=*+2 ;UTILITY POINTER
INDEX2 *=*+2 ;UTILITY POINTER
INDEX =INDEX1
;
RESM1 *=*+1 ;PRODUCT AREA FOR MULTIPLICATION
RESM2 *=*+1
RESM3 *=*+1
RESM4 *=*+1
RESM5 *=*+1
;
MULT1 =RESM1 ;FIRST OPERAND (MULT)
MULT2 =RESM3 ;SECOND OPERAND (MULT)
;
DATAPT *=*+2 ;CURRENT DATA POINTER
STOS *=*+2 ;PNT TO TOP OF STACK
SFREE *=*+2 ;PNT TO FREE AREA OF VAR.RES
PRGPNT *=*+2 ;PNT TO START OF LINE
CODPNT *=*+1 ;PNT TO CODE DURING EXECUTION
SCLSD1 *=*+2 ;OLD SFREE (CLOSED)
SCLSD2 *=*+2 ;OLD STOS  (CLOSED)
INF1 *=*+1
INF2 *=*+1 ;USED FOR OPERAND CHECKING
INF3 *=*+1
Q1 *=*+2 ;SHORT SPAN WORK AREAS
Q2 *=*+2
Q3 *=*+2
Q4 *=*+2
Q5 *=*+2
COPY1 *=*+2 ;WORK FOR COPY: FROM
COPY2 *=*+2 ;               TO
FDECPT =COPY2 ;CURRENT VARIABLE ADDRESS (DEC POINTER)
COPY3 *=*+2 ;               LENGTH
BUS *=*+1 ;BUS=0: BUS IDLE; BUS<>0: BUS ACTIVE
STINF *=*+1 ;INFORMATION FOR STATEMENT:
CMND =$01 ;  NO LINE NUMBER
TWOST =$02 ;  ANOTHER STATEMENT FOLLOWS
WHLDO =$04 ;  AFTER WHILE ... DO
FORDO =$08 ;  AFTER FOR ... DO
COMMNT =$10 ;  STATEMENT ENDED BY COMMENT
IFTHEN =$20 ;  AFTER IF ... THEN
REPUNT =$40 ;  AFTER REPEAT ... UNTIL
;
EXCINF *=*+1 ;EXECUTION INFORMATION:
ESCTRP =$02 ;  ESCAPE IS TRAPPED (STOP)
SRQ =$04 ;  MAKE CALL OF COMAL INTERRUPT HANDLER.
ESCMET =$08 ;  ESCAPE MET (STOP)
SRQON =$10 ;  SRQ ENABLED
USRQON =$20 ;  USER REQUEST ENABLED
SFTSRQ =$80 ;  SOFTWARE SRQ ONLY
;
;  VARIABLES FOR FLOATING POINT PACKAGES
;
TEMPF3 *=*+6 ;MISC. FP WORK AREA
ESCAPE *=*+1 ;STOP KEY FLAG
 *=*+1 ;NOT USED
OLDOV *=*+1 ;OLD OVERFLOW (ROUNDING)
TEMPF1 *=*+5 ;MISC. FP WORK AREA (5 BYTES)
TEMPF2 *=*+5 ;MISC. FP WORK AREA (5 BYTES)
DECCNT =TEMPF2+1
TENEXP =TEMPF2+2
;
AC1 *=*+6 ;ACCUM#1:
AC1E =AC1+0 ;  EXPONENT
AC1M1 =AC1+1 ;  MANTISSA 1
AC1M2 =AC1+2 ;  MANTISSA 2
AC1M3 =AC1+3 ;  MANTISSA 3
AC1M4 =AC1+4 ;  MANTISSA 4
AC1S =AC1+5 ;  SIGN
;
DEGREE *=*+1 ;SERIES EVALUATION CONSTANT POINTER
BITS *=*+1 ;ACCUM#1: HI-ORDER (OVERFLOW)
;
AC2 *=*+6 ;ACCUM#2:
AC2E =AC2+0 ;  EXPONENT
AC2M1 =AC2+1 ;  MANTISSA 1
AC2M2 =AC2+2 ;  MANTISSA 2
AC2M3 =AC2+3 ;  MANTISSA 3
AC2M4 =AC2+4 ;  MANTISSA 4
AC2S =AC2+5 ;  SIGN
;
ARISGN *=*+1 ;SIGN COMPARISON, ACC#1 VS ACC#2
FACOV *=*+1 ;ACCUM#1: LO-ORDER (ROUNDING)
POLYPT *=*+2 ;POINTER TO POLYNOM.
FBUFPT =POLYPT
;
;  MORE COMAL VARIABLES
;
ASAVE *=*+1 ;SAVE FOR .A (CALL/GOTO)
XSAVE *=*+1 ;SAVE FOR .X (CALL/GOTO)
PSAVE *=*+1 ;SAVE FOR .P (CALL/GOTO)
INDPNT *=*+1 ;POINTER TO LAST CODE WHERE AN ADDRESS WAS LOADED
SCFLAG *=*+1 ;FLAGS IN SCANNER:
LNNO *=*+2 ;LINE NUMBER
MOVEAD *=*+2 ;ADDRESS FOR MOVE
TXTLO *=*+1 ;ADDRESS OF TEXT FOR PRTXT
TXTHI *=*+1
XX *=*+2 ;CURRENT X (GRAPHICS)
YY *=*+2 ;CURRENT Y (GRAPHICS)
GRWK1 *=*+2
GRWK2 *=*+2
GRWK3 *=*+2
EXCFLG *=*+1 ;FLAGS:
NWNAME =$01 ; NEW NAME HAS BEEN INSERTED
NWLINE =$02 ; NEW LINE HAS BEEN INSERTED
CHARPT *=*+1 ; PNT TO INBUF
CHAR *=*+1 ; CHAR FROM INCHAR
RNDX *=*+5 ; RANDOM NUMBER SEED
;
;  VARIABLES FOR I/O
;
STATUS *=*+1 ;I/O OPERATION STATUS
STKEY *=*+1 ;STOP KEY FLAG
SVXT *=*+1 ;TEMPORARY
VERCK *=*+1 ;LOAD OR VERIFY FLAG
C3P0 *=*+1 ;IEEE BUFFERED CHAR FLAG
BSOUR *=*+1 ;CHAR BUFFER FOR IEEE
SYNO *=*+1 ;CASSETTE SYNC #
XSAV *=*+1 ;TEMP FOR BASIN
LDTND *=*+1 ;HOW MANY FILES OPEN
DFLTN *=*+1 ;DEFAULT INPUT DEVICE #
DFLTO *=*+1 ;DEFAULT OUTPUT DEVICE #
PRTY *=*+1 ;CASSETTE PARITY
T3 =PRTY
DPSW *=*+1 ;CASSETTE DIPOLE SWITCH
MSGFLG *=*+1 ;OS MESSAGE FLAG
PTR1 *=*+1 ;CASSETTE ERROR PASS 1
T1 =PTR1 ;TEMPORARY 1
PTR2 *=*+1 ;CASSETTE ERROR PASS 2
TMPC =PTR2
T2 =PTR2 ;TEMPORARY 2
TIME *=*+3 ;24 HOUR CLOCK IN 1/60 SEC.
R2D2 =* ;SERIAL BUS USAGE
PCNTR *=*+1 ;CASSETTE STUFF
BSOUR1 =* ;TEMP USED BY SERIAL ROUTINE
FIRT *=*+1
COUNT =* ;TEMP USED BY SERIAL ROUTINE
CNTDN *=*+1 ;CASSETTE SYNC COUNTDOWN
BUFPT *=*+1 ;TAPE BUFFER POINTER
SHCNL =* ;CASSETTE SHORT COUNT
INBIT *=*+1 ;RS232 RCVR INPUT BIT STORAGE
RER =* ;CASSETTE READ ERROR
BITCI *=*+1 ;RS232 RCVR BIT COUNT IN
REZ =* ;CASSETTE READING ZEROES
RINONE *=*+1 ;RS232 RCVR FLAG FOR START BIT CHECK
RDFLG =* ;CASSETTE READ MODE
RIDATA *=*+1 ;RS232 RCVR BYTE BUFFER
RIPRTY *=*+1 ;RS232 RCVR PARITY STORAGE
SHCNH =RIPRTY ;CASSETTE SHORT COUNT
SAL *=*+1 ;POINTER: TAPE BUFFER/SCREEN SCROLLING
SAH *=*+1
EAL *=*+1
EAH *=*+1
CMP0 *=*+1 ;TAPE TIMING CONSTANT
TEMP *=*+1 ;TAPE TIMING CONSTANT
TAPE1 *=*+2 ;START OF TAPE BUFFER
;
SNSW1 =* ;CASSETTE STUFF
BITTS *=*+1 ;RS232 TRNS BIT COUNT
NXTBIT *=*+1 ;RS232 TRNS NEXT BIT TO BE SENT
DIFF =NXTBIT ;EOT RECEIVED FROM TAPE
PRP =*
RODATA *=*+1 ;RS232 TRNS BYTE BUFFER
FNLEN *=*+1 ;LENGTH OF CURRENT FILE NAME
LA *=*+1 ;CURRENT FILE LOGICAL ADDRESS
SA *=*+1 ;CURRENT FILE SECONDARY ADDRESS
FA *=*+1 ;CURRENT FILE PRIMARY ADDRESS
FILADR *=*+2 ;CURRENT FILE NAME ADDRESS
OCHAR =*
ROPRTY *=*+1 ;RS232 TRNS PARITY BUFFER
FSBLK *=*+1 ;CASSETTE READ BLOCK COUNT
MYCH *=*+1 ;SERIAL WORD BUFFER
CAS1 *=*+1 ;CASSETTE MANUAL/CONTROLLED SWITCH
STAL *=*+1 ;TAPE START ADDRESS
STAH *=*+1
TMP2 =*
MEMUSS *=*+2 ;TAPE LOAD TEMPS
;
;  VARIABLES FOR SCREEN EDITOR
;
LSTX *=*+1 ;KEY SCAN INDEX
NEWKEY =LSTX
NDX *=*+1 ;KEY BUFFER POINTER
RVS *=*+1 ;REVERSE FIELD ON FLAG
INDX *=*+1 ;BYTE POINTER TO END OF LINE FOR INPUT
LSXP *=*+1 ;START OF SCREEN INPUT (ROW)
LSTP *=*+1 ;START OF SCREEN INPUT (COLUMN)
SFDX *=*+1 ;SHIFT MODE ON PRINT
BLNSW *=*+1 ;CURSOR BLINK ENABLE
BLNCT *=*+1 ;COUNTER TO FLIP CURSOR
GDBLN *=*+1 ;OLD CHAR BEFORE BLINK
BLNON *=*+1 ;ON/OFF BLINK FLAG
CRSW *=*+1 ;INPUT/GET FLAG
PNT *=*+2 ;POINTER TO START OF LINE WHERE
CURLIN =PNT ;CURSOR IS FLASHING.
PNTR *=*+1 ;COLUMN POSITION WHERE CURSOR
COLPOS =PNTR ;IS FLASHING.
QTSW *=*+1 ;FLAG FOR QUOTE MODE
QUOTE =QTSW
LNMX *=*+1 ;CURRENT SCREEN LINE LENGTH (39/79)
TBLX *=*+1 ;LINE NUMBER WHERE CURSOR IS FLASHING
ROWPOS =TBLX
DATA *=*+1 ;TEMP DATA AREA
INSRT *=*+1 ;NUMBER OF INSERT KEYS PUSHED TO GO
WRPTB *=*+26 ;LINE FLAGS+ENDSPACE
LDTB1 =WRPTB
USER *=*+2 ;SCREEN EDITOR COLOR POINTER
KEYTAB *=*+2 ;KEYBOARD DECODE TABLE
;
RIBUF *=*+2 ;RS232 INPUT BUFFER ADDRESS
ROBUF *=*+2 ;RS232 OUTPUT BUFFER ADDRESS
FREKZP *=*+5 ;FREE KERNAL Z-PAGE SPACE
;
;  END OF PAGE ZERO
;
STACK *=*+256 ;SYSTEM STACK
FBUFFR =STACK ;FPASC WORK AREA (15 BYTES)
BAD =STACK ;TAPE INPUT ERROR LOG
;
;
ERTLEN *=*+1 ;LENGTH OF ERTEXT
MAXERT =79 ;MAX. LENGTH OF ERTEXT
ERTEXT *=*+MAXERT ;BUFFER TO HOLD ERROR MESSAGE
;
;
;  STORAGE FOR CON COMMAND:
;
CONPNT *=*+2 ;OLD PRGPNT
CONFLG *=*+1 ;OLD EXCINF
CONCOD *=*+1 ;OLD CODPNT
CONFOR *=*+2 ;OLD FORPT
;
FPWORK *=*+1
EXTROM *=*+1 ;EXTERNAL ROM FLAG (0=NO, 'I'=YES)
IEEEIN *=*+1 ;IEEE INSTALLED    (0=NO, 'I'=YES)
;
LAT *=*+10 ;TABLE OF LA'S
FAT *=*+10 ;TABLE OF FA'S
SAT *=*+10 ;TABLE OF SA'S
KEYBUF *=*+10 ;KEYBOARD BUFFER QUEUE (FIFO)
;
MEMSTR *=*+2 ;START OF MEMORY
MEMSIZ *=*+2 ;TOP OF MEMORY
TIMOUT *=*+1 ;IEEE TIME OUT DEFEAT
;
;  SCREEN EDITOR STORAGE
;
COLOR *=*+1 ;ACTIVE COLOR NYBBLE
GDCOL *=*+1 ;ORIGINAL COLOR UNDER CURSOR
HIBASE *=*+1 ;BAS LOCATION OF SCREEN
KBFLIM *=*+1 ;SIZE OF KEYBOARD BUFFER
RPTFLG *=*+1 ;KEY REPEAT FLAG
RPTCNT *=*+1 ;REPEAT SPEED COUNTER
DELAY *=*+1 ;REPEAT DELAY COUNTER
SHFLAG *=*+1 ;KEYBOARD SHIFT KEY/CTRL KEY/C= KEY
LSTSHF *=*+1 ;LAST KEYBOARD SHIFT PATTERN
KEYLOG *=*+2 ;VECTOR: KEYBOARD TABLE SETUP
SHMODE *=*+1 ;0=PET MODE, 1=CATTACANNA
AUTODN *=*+1 ;AUTO SCROLL DOWN, 0=ON
;
;  RS232 STORAGE
;
M51CTR *=*+1 ;6551 CONTROL REGISTER IMAGE
M51CDR *=*+1 ;6551 COMMAND REGISTER IMAGE
M51AJB *=*+2 ;NON-STANDARD BPS (TIME/2-100) USA
RSSTAT *=*+1 ;6551 STATUS REGISTER
BITNUM *=*+1 ;NUMBER OF BITS LEFT TO SEND
BAUDOF *=*+2 ;BAUD RATE: FULL BIT TIME (MICROSEC)
RIDBE *=*+1 ;INDEX TO END OF INPUT BUFFER
RIDBS *=*+1 ;START OF INPUT BUFFER (PAGE)
RODBS *=*+1 ;START OF OUTPUT BUFFER (PAGE)
RODBE *=*+1 ;INDEX TO END OF OUTPUT BUFFER
;
IRQTMP *=*+2 ;HOLDS IRQ-VECTOR DURING TAPE I/O
;
;  TEMP SPACE FOR C64 VARIABLES
;
ENABL *=*+1 ;RS232 ENABLES
CASTON *=*+1 ;TOD SENSE DURING CASSETTE I/O
KIKA26 *=*+1 ;TEMP STORAGE FOR CASSETTE READ
STUPID *=*+1 ;TEMP D1IRQ INDICATOR FOR CASSETTE READ
LINTMP *=*+1 ;TEMP FOR LINE INDEX
PALNTS *=*+1 ;FLAG: 0=NTSC, 1=PAL
;
FNMAX =55
FILNAM *=*+FNMAX ;USED FOR STORAGE OF FILE NAME
TBUFF =FILNAM ;USED FOR STORAGE OF DISC COMMAND
RANGNO *=*+1 ;LINE # RANGE POINTER
RANGPT *=*+1 ;LINE # RANGE POINTER
RANGMX =32
RANGES *=*+RANGMX ;LINE # RANGES
IERROR *=*+2 ;VECTOR: PRINT BASIC ERROR MESSAGE
NUMBER =TEMPF3 ;FP WORK AREA (SYNTAX ANALYSIS)
 *=*+5 ;NOT USED
NUM2 *=*+5 ;FP WORK AREA (PRINT USING)
SAREG *=*+8 ;UNUSED
;
;  KERNAL VECTORS:
;
CINV *=*+2 ;IRQ RAM VECTOR
IRQVCT =CINV
CBINV *=*+2 ;BRK INSTR RAM VECTOR
BRKVCT =CBINV
NMIVCT *=*+2 ;NMI RAM VECTOR
IOPEN *=*+2 ;OPEN ROUTINE VECTOR
ICLOSE *=*+2 ;CLOSE ROUTINE VECTOR
ICHKIN *=*+2 ;CHKIN ROUTINE VECTOR
ICKOUT *=*+2 ;CKOUT ROUTINE VECTOR
ICLRCH *=*+2 ;CLRCHN ROUTINE VECTOR
IBASIN *=*+2 ;CHRIN ROUTINE VECTOR
IBSOUT *=*+2 ;CHROUT ROUTINE VECTOR
ISTOP *=*+2 ;STOP ROUTINE VECTOR
IGETIN *=*+2 ;GETIN ROUTINE VECTOR
ICLALL *=*+2 ;CLALL ROUTINE VECTOR
USRCMD *=*+2 ;FOR MACHINE LANGUAGE MONITOR
ILOAD *=*+2 ;LOAD ROUTINE VECTOR
ISAVE *=*+2 ;SAVE ROUTINE VECTOR
 *=*+8 ;UNUSED
TBUFFR *=*+192 ;TAPE I/O BUFFER
 *=*+4 ;UNUSED
SCSIZE =1000 ;SCREEN SIZE
SCREEN *=*+SCSIZE ;SCREEN MEMORY AREA
 *=*+16 ;SCREEN MEMORY EXCESS
SPRPNT *=*+8 ;SPRITE DATA POINTERS
;
;
;  COMAL PROGRAM FOLLOWS HERE:
;
MBEGIN *=*+4 ;START OF MEMORY
MBEGN1 *=*+1 ;START OF NAME TABLE
MBEGN2 *=*+1 ;START OF STACKS
;
;
;
;  START HERE TO PUT BUFFERS, VARIABLES, AND JUMP TABLE
;
 *=$C000
;
RSIBUF *=*+256 ;RS232 INPUT BUFFER
RSOBUF *=*+256 ;RS232 OUTPUT BUFFER
;
STDPCK *=*+1000 ;VARIABLES FOR STANDARD PACKAGES
;
INLEN =121
INBUF *=*+INLEN ;INPUT BUFFER
CDBUF *=*+CLIMIT ;CODE BUFFER
TXT *=*+TLIMIT ;STRING CONSTANT BUFFER
TXT1 =TXT-1
;
FLEVEL *=*+1 ;FOR/TRAP NESTING LEVEL DURING PREPASS
Q6 *=*+2 ;TEMPORARY
Q7 *=*+2 ;TEMPORARY
Q8 *=*+2 ;TEMPORARY
Q9 *=*+2 ;TEMPORARY
 *=*+3 ;UNUSED
MOVELN =MULT1
MOVETY =MULT2
;
SPSAV *=*+1 ;SAVE OF .S DURING EXECUTION
SCINF *=*+2 ;NAME POINTER
;
PSTART =*
;
AUTO1 *=*+2 ;CURRENT LINE NUMBER FOR AUTO
AUTOST *=*+2 ;STEP FOR AUTO
;
DSTART *=*+2 ;START OF DATA QUEUE
;
TABSET *=*+1 ;VALUE OF LAST ZONE STATEMENT
ALTPOS *=*+1 ;POSITION IN SELECT OUTPUT FILE
INTRNO *=*+2 ;PROCEDURE GIVEN BY INTERRUPT STMT.
;
PEND =*
;
ERRPNT *=*+1 ;CHAR POS OF ERROR
NORINT *=*+2 ;NORMAL INTERRUPT VECTOR
SAFE *=*+1 ;SAFE STATUS
MAINRV *=*+1 ;MAIN REVISION
SUBRV *=*+1 ;SUB REVISION
TESTRV *=*+1 ;TEST VERSION
MSGLIN *=*+2 ;ADDRESS OF MESSAGE LINE
UPPER2 *=*+1 ;COPY OF BORGE
EXTPRC *=*+1 ;FLAG FOR LOADING OF EXTERNAL PROC/FUNC
EXTCNT *=*+2 ;NESTING LEVEL OF EXTERNAL PROC/FUNC
SSIZE *=*+1 ;40 COL./80 COL.
LUNIT *=*+1 ;LAST DISC (STATUS)
BORGE *=*+1 ;SPECIAL FLAGS FOR LISTING
OPENFL *=*+1 ;FLAG USED BY COPEN
DFUNLN *=*+1 ;LENGTH OF DEFAULT UNIT TEXT
DFUNIT *=*+2 ;DEFAULT UNIT (POWER UP VALUE: .BYTE '0')
DEFOUT *=*+1 ;SELECT OUTPUT FLAG
;
IOVECT =* ;VECTORS:
TRAPVC *=*+2 ;  PAGEB; ERROR HANDLER
EXTNVC *=*+2 ;  PAGEB; EXTERNAL LOAD
USRQVC *=*+2 ;  PAGEB; INTERRUPT FACILITY
IERTXT *=*+3 ;         ERROR MESSAGE DATA
IGETLN *=*+2 ;  PAGEA; INPUT COMMAND LINE
ISAVEC *=*+2 ;  PAGEC; SAVE ADDITIONAL INFO
ILOADC *=*+2 ;  PAGEC; LOAD ADDITIONAL INFO
IFNKEY *=*+2 ;  PAGEA; HANDLE FUNCTION KEYS
;
LIBPT *=*+1 ;PTR TO PLACE FOR NEXT LIBRARY DESCRIPTION
;
LIBLEN =10 ;NO. OF LIBRARY DESCRIPTIONS
;
LIBLO *=*+LIBLEN
LIBHI *=*+LIBLEN
LIBPAG *=*+LIBLEN
;
;
; OPEN FILE MODES (COPEN & CFNAME):
;
MREAD =1 ;READ
MWRITE =2 ;WRITE
MREL =4 ;RELATIVE (RANDOM)
;
; FILE ATTRIBUTES (COPEN):
;
MDISK =8 ;DISK FILE
MS =16 ;SECONDARY ADDRESS SELECTION
ML =32 ;AUTO LINEFEED
MT =64 ;TIME OUT
MA =128 ;ASCII I/O
;
; FILE TYPES (CFNAME):
;
TAPPND =8
TPRG =16
TSEQ =TPRG+TPRG
TREL =TSEQ+TPRG
TUSR =TREL+TPRG
;
MODET *=*+10 ;OPEN MODE FOR FILES
COUNTT *=*+10 ;TABLE OF BYTE COUNT FOR FILES
STT *=*+10 ;STATUS FOR OPENED FILES
RECOTL *=*+10 ;TABLE OF RECORD POS. FOR FILES
RECOTH *=*+10
;
PPAGE *=*+1 ;OVERLAY TO PEEK/POKE/SYS
NOREST *=*+1 ;<>0: DISABLE STOP/RESTORE
LOADIN *=*+1 ;<>0: LOADING COMAL PROGRAM
UNITFL *=*+1 ;0: SIMP.DEV; 1: DRIVE; 2: CASSETTE
MODE *=*+1 ;FILE MODE
CSTAT *=*+1 ;STATUS OF COMAL PROGRAM
;
;    1: INPUT ANALYSIS FROM SCREEN
;    2:   -       -      -  FILE
;    3: PREPASSING
;    4: EXECUTING A COMMAND
;    5: EXECUTING PROGRAM
;
LSTFLG *=*+1 ;BIT VECTOR FOR RCREAT:
;
ININD =$01
OUTIND =$02
LSTCON =$04
NOIND =$08
LSTEXT =$10
;
LPMODE *=*+1 ;DEFAULT PRINTER OPEN MODE
LPSA *=*+1 ;DEFAULT PRINTER SECONDARY ADDRESS
LPFA *=*+1 ;DEFAULT PRINTER UNIT
;
RECDEL *=*+1 ;RECORD POSITIONING DELAY
ENDADR *=*+2 ;TOP OF RAM
HEADLN *=*+1 ;POWER ON MESSAGE FLAG
;
KWTAB *=*+2 ;KEYWORD TABLE (PAGEA)
;
DFBORD *=*+1 ;DEFAULT BORDER COLOR
DFBACK *=*+1 ;DEFAULT BACKGROUND COLOR
DFFORG *=*+1 ;DEFAULT FOREGROUND COLOR
ACBORD *=*+1 ;ACTUAL TEXT BORDER
ACBACK *=*+1 ;ACTUAL TEXT BACKGROUND
;
KEYLEN *=*+16 ;LENGTHS OF FUNC.KEY DEF'S
KLEN *=*+1 ;# OF CHARS LEFT OF DEF.
KPNT *=*+2 ;PNT TO KEY DEF
DEFINP *=*+1 ;SELECT INPUT FLAG
HZ50 *=*+1 ;0=60 HZ, 1=50 HZ TOD
;
 *=*+17 ;RESERVED FOR FUTURE USE
MTO =*
;
;
;  SUBROUTINES TO USE IN ASSEMBLER
;  CODED SUBROUTINES IN COMAL:
;
COLD *=*+3 ;COLD START OF COMAL
WARM *=*+3 ;WARM START OF COMAL
CALL *=*+3 ;JSR TO ANOTHER PAGE.
GOTO *=*+3 ;JMP TO ANOTHER PAGE.
LOAD *=*+3 ;LOAD FROM PAGEX
STORE *=*+3 ;STORE TO PAGEX
EXEC *=*+3 ;JSR TO PAGEX
;
LDAC1 *=*+3 ;LOAD AC1
LDAC2 *=*+3 ;LOAD AC2
FNDPAR *=*+3 ;FIND PARAMETER (ASM.CALLS)
COPY *=*+9 ;COPY AREA TOWARDS LOWER ADDRESSES
COPYDN *=*+9 ;COPY AREA TOWARDS HIGHER ADDRESSES
FPADD *=*+3 ;LOAD AC2 AND ADD AC2 TO AC1
FPADD2 *=*+9 ;ADD AC2 TO AC1
FPAHF *=*+9 ;ADD 0.5 TO AC1
FPSUB *=*+3 ;LOAD AC2 AND SUB AC2 FROM AC1
FPSUB2 *=*+9 ;SUB AC2 FROM AC1
FPMUL *=*+3 ;LOAD AC2 AND MUL AC2 BY AC1
FPMUL2 *=*+9 ;MUL AC2 BY AC1
FPDIV *=*+3 ;LOAD AC2 AND DIV AC2 BY AC1
FPDIV2 *=*+9 ;DIV AC2 BY AC1
MUL10 *=*+9 ;MULTIPLY AC1 BY 10.0
DIV10 *=*+9 ;DIVIDE AC1 BY 10.0
STAC1 *=*+3 ;STORE AC1
C1T2 *=*+9 ;COPY AC1 TO AC2
C2T1 *=*+9 ;COPY AC2 TO AC1
FPNEG *=*+9 ;NEGATE AC1
FPSGN *=*+9 ;SIGN OF AC1
FPSIN *=*+9 ;SINE OF AC1
FPCOS *=*+9 ;COSINE OF AC1
FPSQR *=*+9 ;SQUARE ROOT OF AC1
FPTAN *=*+9 ;TANGENT OF AC1
FPPOW *=*+9 ;RAISE AC2 TO THE POWER OF AC1
FPATN *=*+9 ;ARCTANGENT OF AC1
FPEXP *=*+9 ;RAISE AC1 TO THE POWER OF E
FPLOG *=*+9 ;LOGARITHM BASE E OF AC1
FPRND *=*+9 ;COMPUTE PSEUDO-RANDOM NUMBER (RANGE 0 TO 1)
FPCOM *=*+9 ;COMPARE NUMBER TO AC1
TRUNC *=*+9 ;CONVERT AC1 INTO INTEGER (-32768 .. 32767)
FPINT =TRUNC
FPINTG *=*+9 ;CONVERT AC1 INTO INTEGER (-2^24 .. 2^24-1)
FPINTA *=*+9 ;CONVERT AC1 INTO INTEGER (0 .. 65535)
INTFP *=*+9 ;CONVERT INTEGER INTO FP IN AC1
FPASC *=*+9 ;CONVERT AC1 INTO ASCII EQUIVALENT (STR$)
;
VAL *=*+6 ;CONVERT DECIMAL STRING INTO BINARY IN AC1
POPA1 *=*+9 ;POP AC1
POPA2 *=*+9 ;POP AC2
PUSHA1 *=*+9 ;PUSH AC1
PUSHRL *=*+9 ;PUSH REAL NUMBER
PSHINT *=*+9 ;FLOAT & PUSH INTEGER (-32768 .. 32767)
INTFPA *=*+9 ;FLOAT & PUSH INTEGER (0 .. 65535)
;
EXCGST *=*+9 ;ALLOCATE LOCAL STORAGE
EXCREM *=*+9 ;RECLAIM LOCAL STORAGE
RESTOP *=*+9 ;ALLOCATE GLOBAL STORAGE
RUNERR *=*+6 ;GO TO COMAL ERROR HANDLER
;
CRDT *=*+3 ;READ CHARACTER
SPACE *=*+2 ;WRITE SPACE
CWRT *=*+3 ;WRITE CHARACTER
CCHKIN *=*+3 ;SELECT INPUT FILE
CCKOUT *=*+3 ;SELECT OUTPUT FILE
CCLRCH *=*+3 ;CLEAR CHANNEL
CFNAME *=*+7 ;PARSE & COPY FILE NAME
COPEN *=*+3 ;OPEN FILE
CCLOSE *=*+3 ;CLOSE FILE
CRLF *=*+3 ;OUTPUT CR AND LF
GETLIN *=*+7 ;INPUT KEYBOARD LINE
;
RESET *=*+6 ;RESET PROGRAM POINTERS
DUMMY *=*+1 ;EMPTY SUBROUTINE (RTS)
COMAL *=*+6 ;GO TO COMAL EDITOR
EXCUTE *=*+7 ;EXECUTE CODE IN CDBUF
JLOAD *=*+7 ;LOAD COMAL PROGRAM
ARRLEN *=*+7 ;COMPUTE NO. OF ELEMENTS IN ARRAY
;
 *=$D000
;
;  6566 VIDEO INTERFACE CONTROLLER
;
VIC =*
SPRPOS *=*+16 ;SPRITES 0-7  X & Y POS
SPRXPS *=*+1 ;SPRITES 0-7  X-POS (MSB OF X-COORD.)
VCTRL1 *=*+1 ;VIC CONTROL REGISTER
RWRAST *=*+1 ;READ/WRITE RASTER VALUE FOR COMPARE IRQ
PENX *=*+1 ;LIGHT-PEN LATCH X-POS
PENY *=*+1 ;LIGHT-PEN LATCH Y-POS
SPRDSP *=*+1 ;SPRITE DISPLAY ENABLE
VCTRL2 *=*+1 ;VIC CONTROL REGISTER
SPRYEX *=*+1 ;SPRITES 0-7 EXPAND 2*VERTICAL (Y)
VCTRL3 *=*+1 ;VIC MEMORY CONTROL REGISTER
IRQOCC *=*+1 ;VIC INTERRUPT FLAG REGISTER
IRQMSK *=*+1 ;IRQ MASK REGISTER
SPRBDP *=*+1 ;SPRITE TO BACKGROUND DISPLAY PRIORITY
SPRMCM *=*+1 ;SPRITES 0-7 MULTI-COLOR MODE SELECT
SPRXEX *=*+1 ;SPRITES 0-7 EXPAND 2*HORIZONTAL (X)
SPRSPR *=*+1 ;SPRITE TO SPRITE COLLISION DETECT
SPRBCK *=*+1 ;SPRITE TO BACKGROUND COLLISION DETECT
BORCOL *=*+1 ;BORDER COLOR
BCKCOL *=*+4 ;BACKGROUND COLOR 0-3
SPRMCL *=*+2 ;SPRITE MULTI-COLOR REGISTER 0-1
SPRCOL *=*+8 ;SPRITE 0-7 COLOR
;
 *=$D400
;
;  6581 SOUND INTERFACE DEVICE
;
SID =* ;VOICE 1:
V1FREQ *=*+2 ;  FREQUENCY CONTROL
V1PWW *=*+2 ;  PULSE WAVEFORM WIDTH
V1CTRL *=*+1 ;  CONTROL REGISTER
V1ENVL *=*+2 ;  ENVELOPE GENERATOR (ADSR)
 ;VOICE 2:
V2FREQ *=*+2 ;  FREQUENCY CONTROL
V2PWW *=*+2 ;  PULSE WAVEFORM WIDTH
V2CTRL *=*+1 ;  CONTROL REGISTER
V2ENVL *=*+2 ;  ENVELOPE GENERATOR (ADSR)
 ;VOICE 3:
V3FREQ *=*+2 ;  FREQUENCY CONTROL
V3PWW *=*+2 ;  PULSE WAVEFORM WIDTH
V3CTRL *=*+1 ;  CONTROL REGISTER
V3ENVL *=*+2 ;  ENVELOPE GENERATOR (ADSR)
 ;FILTERS:
FCUTOF *=*+2 ;  FILTER CUTOFF FREQUENCY
FRESON *=*+1 ;  FILTER RESONANCE/VOICE INPUT CONTROL
FMOVOL *=*+1 ;  SELECT FILTER MODE AND VOLUME
PADDL1 *=*+1 ;A/D-CONVERTER: GAME PADDLE 1
PADDL2 *=*+1 ;A/D-CONVERTER: GAME PADDLE 2
OSC *=*+1 ;OSCILLATOR 3 RANDOM NUMBER GENERATOR
ENV *=*+1 ;ENVELOPE GENERATOR 3 OUTPUT
 *=$D500
SIDIMG *=*+768 ;SID IMAGES
COLRAM *=*+SCSIZE+24 ;COLOR RAM (NYBBLES)
;
 *=$DC00
;
;  6526 COMPLEX INTERFACE ADAPTER #1
;
COLM =* ;KEYBOARD MATRIX
D1PRA *=*+1
ROWS =* ;KEYBOARD MATRIX
D1PRB *=*+1
D1DDRA *=*+1
D1DDRB *=*+1
D1T1L *=*+1
D1T1H *=*+1
D1T2L *=*+1
D1T2H *=*+1
D1TOD1 *=*+1
D1TODS *=*+1
D1TODM *=*+1
D1TODH *=*+1
D1SDR *=*+1
D1ICR *=*+1
D1CRA *=*+1
D1CRB *=*+1
;
 *=$DD00
;
;  6526 COMPLEX INTERFACE ADAPTER #2
;
D2PRA *=*+1
D2PRB *=*+1
D2DDRA *=*+1
D2DDRB *=*+1
D2T1L *=*+1
D2T1H *=*+1
D2T2L *=*+1
D2T2H *=*+1
D2TOD1 *=*+1
D2TODS *=*+1
D2TODM *=*+1
D2TODH *=*+1
D2SDR *=*+1
S2ICR *=*+1
D2CRA *=*+1
D2CRB *=*+1
;
 *=$DE00
;
OVRLAY *=*+256 ;OVERLAY CONTROL PORT
;
;  KERNAL JUMP TABLE
;
 *=$FF81
;
CINT *=*+3 ;INIT SCREEN EDITOR
IOINIT *=*+3 ;INIT I/O $ff84
RAMTAS *=*+3 ;INIT RAM $ff87
RESTOR *=*+3 ;RESTORE DEFAULT I/O VECTORS $ff8a
VECTOR *=*+3 ;READ/SET VECTORED I/O $ff8d
SETMSG *=*+3 ;CONTROL KERNAL MESSAGES $ff90
SECOND *=*+3 ;SEND SA AFTER LISTEN $ff93
TKSA *=*+3 ;SEND SA AFTER TALK $ff96
MEMTOP *=*+3 ;READ/SET TOP OF MEMORY $ff99
MEMBOT *=*+3 ;READ/SET BOTTOM OF MEMORY $ff9c
SCNKEY *=*+3 ;SCAN KEYBOARD $ff9f
SETTMO *=*+3 ;SET TIMEOUT DEFEAT $ffa2
ACPTR *=*+3 ;INPUT BYTE FROM SERIAL PORT $ffa5
CIOUT *=*+3 ;OUTPUT BYTE TO  SERIAL PORT $ffa8
UNTLK *=*+3 ;COMMAND DEVICE TO UNTALK $ffab
UNLSN *=*+3 ;COMMAND DEVICE TO UNLISTEN $ffae
LISTN *=*+3 ;COMMAND DEVICE TO LISTEN $ffb1
TALK *=*+3 ;COMMANDS DEVICE TO TALK $ffb4
RDSTAT *=*+3 ;READ I/O STATUS WORD $ffb7
SETLFS *=*+3 ;SET LOGICAL, FIRST, AND SECOND ADDR. $ffba
SETNAM *=*+3 ;SET FILE NAME $ffbd
OPEN *=*+3 ;OPEN LOGICAL FILE $ffc0
CLOSE *=*+3 ;CLOSE LOGICAL FILE $ffc3
CHKIN *=*+3 ;OPEN CHANNEL FOR INPUT $ffc6
CHKOUT *=*+3 ;OPEN CHANNEL FOR OUTPUT $ffc9
CKOUT =CHKOUT
CLRCHN *=*+3 ;CLOSE I/O CHANNELS $ffcc
CLRCH =CLRCHN
CHRIN *=*+3 ;INPUT CHAR FROM CHANNEL $ffcf
RDT =CHRIN
CHROUT *=*+3 ;OUTPUT CHAR TO CHANNEL $ffd2
WRT =CHROUT
LOADF *=*+3 ;LOAD RAM FROM A DEVICE $ffd5
SAVEF *=*+3 ;SAVE RAM TO DEVICE $ffd8
SETTIM *=*+3 ;SET REAL TIME CLOCK $ffdb
RDTIM *=*+3 ;READ REAL TIME CLOCK $ffde
STOP *=*+3 ;SCAN STOP KEY $ffe1
GET *=*+3 ;GET CHAR FROM KEYBOARD BUFFER $ffe4
CLALL *=*+3 ;CLOSE ALL CHANNELS AND FILES $ffe7
UDTIM *=*+3 ;INC. REAL TIME CLOCK $ffea
SCREN *=*+3 ;RETURN ROW,COLUMN OF CURSOR $ffed
PLOT *=*+3 ;READ/SET ROW,COLUMN FOR CURSOR $fff0
IOBASE *=*+3 ;RETURNS BASE ADDRESS OF I/O DEVICES $fff3
;
SKIP =$2C ;OPCODE FOR 'BIT <ABS>' (SKIP 2 BYTES)
;
;
 *=$FFFA
;
CNMI *=*+2 ;NON-MASKABLE INTERRUPT VECTOR $fffa
CRESET *=*+2 ;SYSTEM RESET VECTOR $fffc
CIRQ *=*+2 ;INTERRUPT REQUEST VECTOR $fffe
;
;
;********************************************************
;
;
; FOR USE IN ASSEMBLER CODED SUBROUTINES IN COMAL:
;
; LABELS FOR PROC/FUNC DEFINITIONS
;
CART =%10000000 ;10XRXPPP (IN CARTRIDGE AT $8000-$BFFF)
C64 =%01000111 ;01XRXPPP (IN C64       AT $0900-$FFFF)
ROMMED =%00010000
;
DEFPAG =C64-LORAM
;
PROC =112
ENDPRC =126
;
FUNC =227
ENDFNC =126
;
PARAM =114
VALUE =PARAM+0
REF =PARAM+3
ARRAY =6
;
REAL =0
INT =1
STR =2
;
;
;  SIGNAL TYPES:
;
POWER1 =0 ;POWER UP SEI (ONLY FOR ROMMED LIBRARIES)
POWER2 =1 ;POWER UP CLI (ONLY FOR ROMMED LIBRARIES)
LINK =2 ;AFTER LINK/LOAD-COMMAND (ONLY LIBRARY JUST LINKED)
DSCRD =3 ;BEFORE DISCARD-COMMAND
NEW =4 ;AFTER NEW-COMMAND OR BAD LOAD/RUN/CHAIN
CLRTAB =5 ;AFTER NAME TABLE IS CLEARED
RUN =6 ;BEFORE RUN/CHAIN
WARM1 =7 ;WARM START SEI
CON =8 ;BEFORE CONTINUATION (CON COMMAND)
ERROR =9 ;AFTER ERROR MESSAGE PRINTED
STOP1 =10 ;AFTER STOP/END
BASIC =11 ;BEFORE LEAVING COMAL
;
;
.END