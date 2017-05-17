; control characters
CLS	= 125
EOL	= 155

; memory locations
ROWCRS	= $54
COLCRS	= $55	; 2 bytes
SAVMSC	= $58	; 2 bytes screen memory

; CIO equates for IOCB0
ICHID  =   $0340
ICDNO  =   $0341
ICCOM  =   $0342
ICSTA  =   $0343
ICBAL  =   $0344
ICBAH  =   $0345
ICPTL  =   $0346
ICPTH  =   $0347
ICBLL  =   $0348
ICBLH  =   $0349
ICAX1  =   $034A
ICAX2  =   $034B

SDMCTL	=	$22F
SDLSTL	=	$230
SDLSTH	=	$231

KBCODE	=	$D209	; (R) kbcode of last key pressed
SKSTAT 	=	$D20F	; bit 2 last key still pressed
			; bit 3 shift pressed
STIMER	=	$D20F

VCOUNT	=	$D40B

SETVBV	=	$E45C
XITVBV	=	$E462