; $0000 - $00FF		zero page
; $0100 - $01FF		stack
; $D000 - $D7FF		hardware registers
; $FFFA - $FFFF		machine vectors

; do not modify these bytes or warm start won't work
PUPBT1		EQU	$033D	;1-byte power-up validation byte 1
PUPBT2		EQU	$033E	;1-byte power-up validation byte 2
PUPBT3		EQU	$033F	;1-byte power-up validation byte 3

CONSOL		equ	$D01F
PORTB		equ	$D301
DMACTL		equ	$D400
NMIEN		equ	$D40E

COLDSV		equ	$E477

M_NMI		equ	$FFFA
M_RESET		equ	$FFFC
M_IRQ		equ	$FFFE

CASINI		equ	$02
DOSVEC		equ	$0A
DOSINI		equ	$0C

	org $0080
RTCLOK		.DS 2
RESET_COUNT	.DS 1
	
	org $2000

.proc start
	jsr disableOS
	lda #0
	sta RESET_COUNT
	jmp main
.endp

.proc reset
	lda #%00000010
	and CONSOL
	bne s1
	jmp COLDSV	; reset + select for cold start	
s1:	jsr disableOS
	inc RESET_COUNT
	jmp main	
.endp
	
.proc disableOS
	lda #0
	sta NMIEN	; disable NMI
	sei		; disable interrupts
	sta DMACTL	; ANTIC off
	lda #%11111110
	sta PORTB	; OS ROM and BASIC off
	
	cld		; use binary arithmetik

	lda #<nmi
	sta M_NMI
	lda #>nmi
	sta M_nmi+1
	lda #<irq
	sta M_IRQ
	lda #>irq
	sta M_IRQ+1	; set machine vectors
	lda #<reset
	sta CASINI
	sta DOSVEC
	sta DOSINI
	lda #>reset
	sta CASINI+1
	sta DOSVEC+1
	sta DOSINI+1
	
	lda #%01000000
	sta NMIEN	; enable VBI NMI
	cli		; enable interrupts
	
	rts
.endp

.proc main
loop:
	jmp loop
.endp


.proc nmi
	inc RTCLOK
	bne s1
	inc RTCLOK+1	
s1:	
	rti
.endp

.proc irq
	rti
.endp

	run start	