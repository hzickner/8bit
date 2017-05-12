; control characters
CLS	= 125
EOL	= 155

; memory locations
ROWCRS	= $54
COLCRS	= $55	; 2 bytes

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

KBCODE	=	$D209	; bit 2 last key still pressed
			; bit 3 shift pressed
SKSTAT 	=	$D20F	; (R) kbcode of last key pressed
STIMER	=	$D20F	; (W)

VCOUNT	=	$D40B 