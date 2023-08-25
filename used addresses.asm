;used comal system addresses

PAGEPT  =   $07                 ;pointer used by load/store/exac
PAGEX   =   $09                 ;overlay for load/store/exec routines
RESOL   =   $0C                 ;graphics resolution
LNLEN   =   $1f                 ;length of line to be executed
PRGPNT  =   $31                 ;pnt to start of line

;INFx used for operand checking
INF1    =   $38  
INF2    =   $39
INF3    =   $3a

;Qx = short span work areas
Q1      =   $3b
Q2      =   $3d
Q3      =   $3f
Q4      =   $41
Q5      =   $43

COPY1   =   $45                 ;work For copy: from
COPY2   =   $47                 ;work For copy: to
COPY3   =   $49                 ;work For copy: length

MOVEAD  =   $7a                 ;address for move

TXTLO   =   $7c                 ;address of text for print
TXTHI   =   $7d                 ;address of text for print

FREKZP  =   $fb                 ;free kernal z-page space

TXT     =   $c760               ;string constant buffer
DEFOUT  =   $c7dd               ;select output Flag
IERTXT  =   $C7E4               ;error message data
CALL    =   $c881               ;jsr to another page
GOTO    =   $c884               ;jmp to another page
LOAD    =   $c887               ;load from pagex
STORE   =   $c88a               ;store to pagex
LDAC1   =   $c890               ;load ac1
FNDPAR  =   $c896               ;Find parameter (asm.calls)
FPADD   =   $c8ab               ;load ac2 and add ac2 to ac1
FPSUB   =   $c8c0               ;load ac2 and sub ac2 from ac1
FPMUL   =   $c8cc               ;load ac2 and mul ac2 by ac1
FPDIV   =   $c8d8               ;load ac2 and div ac2 by ac1
STAC1   =   $c8f6               ;store ac1
FPNEG   =   $c90b               ;negate ac1
INTFP   =   $c992               ;convert integer into Fp in ac1
FPASC   =   $c99b               ;convert ac1 into ascii equivalent (str$)
PUSHRL  =   $c9c5               ;push real number
INTFPA  =   $c9d7               ;float and push integer (0 .. 65535)
EXCGST  =   $c9e0               ;allocate local storage
EXCREM  =   $c9e9               ;reclaim local storage
RESTOP  =   $c9f2               ;allocate global storage
RUNERR  =   $c9fb               ;go to comal error handler
SPACE   =   $ca04               ;write space
CWRT    =   $ca06               ;write character
CCKOUT  =   $ca0c               ;select output File
CCLRCH  =   $ca0f               ;clear channel
CRLF    =   $ca1f               ;output cr and lf
DUMMY   =   $ca2f               ;empty subroutine (rts)

RDSTAT  =   $ffb7               ;READ I/O STATUS WORD 
UNLSN   =   $ffae               ;COMMAND DEVICE TO UNLISTEN 
LISTN   =   $ffb1               ;COMMAND DEVICE TO LISTEN 
SECOND  =   $ff93               ;SEND SA AFTER LISTEN 
CIOUT   =   $ffa8               ;OUTPUT BYTE TO  SERIAL PORT 
