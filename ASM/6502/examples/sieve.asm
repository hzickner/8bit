

.DEF	NN	= 20000

	org $2000

	ICL "../include/memset.asm"
	ICL "../include/atari/printu16.asm"
	ICL "../include/atari/printfr0.asm"
	ICL "../include/atari/fasc2str.asm"
	ICL "../include/atari/putnchar.asm"
	ICL "../include/atari/putstring.asm"
	ICL "../include/atari/putc.asm"
;	ICL "asmlib/u16_div10.asm"

.align $100
.proc main
	lda #0
	sta 19
	sta 20				; set timer to 0
	sta 82				; set left margin
	sta 85				; set cursor position

	ldx #NN&$FF
	stx u16_N
	ldx #NN/256
	stx u16_N+1
	
	ldx #flagbuf&255
	stx PTR1
	ldx #flagbuf/256
	stx PTR1+1
	ldy u16_N
	ldx u16_N+1
	jsr memset			; clear buffer memory

	lda 20
	ldx 19				; read memset time
	sta u16_tm1
	stx u16_tm1+1
			
	lda #1
	sta flagbuf			; flags[0]=1

	ldy #flagbuf/256
	ldx #flagbuf&$FF
	bne @+
	dey
@	dex
	stx PTR2
	sty PTR2+1			; PTR2=flagbuf-1
	
	ldy #2
	sty u16_i
	lda #0
	sta u16_i+1			; i=2
	sta u16_count
	sta u16_count+1			; count=0
while1					; while(i<=N)
	lda u16_N
	cmp u16_i
	lda u16_N+1
	sbc u16_i+1
	bcc while1out			; i>st

	lda (PTR2),Y			; flag[i]
	bne else1
					; if !flag[i]
	inc u16_count
	bne @+
	inc u16_count+1			; count++
@	tya 				;lda u16_i
	asl
	sta u16_k
	lda u16_i+1
	rol
	sta u16_k+1			; k=i+i

	lda PTR2
	sta PTR3
	lda PTR2+1
	sta PTR3+1			; (PTR2),Y==flag[i-1]

while2
	lda u16_N
	cmp u16_k
	lda u16_N+1
	sbc u16_k+1
	bcc while2out			; while (k<=n)

	lda PTR3
	clc
	adc u16_i
	sta PTR3
	lda PTR3+1
	adc u16_i+1
	sta PTR3+1			; PTR3=PTR3+i		

	lda #1
	sta (PTR3),Y

	lda u16_k
	adc u16_i
	sta u16_k
	lda u16_k+1
	adc u16_i+1
	sta u16_k+1			; k=k+i
			
	bcc while2			; end while2 
while2out		 
else1					; endif
	iny
	sty u16_i
	bne while1
	inc u16_i+1			; i++; PTR1++
	inc PTR2+1
	bne while1			; end while1
while1out
			
	lda 20
	ldx 19				; read calc time
	sta u16_tm2
	stx u16_tm2+1

;
; print primes < N2
	ldy #flagbuf/256
	ldx #flagbuf&$FF
	bne @+
	dey
@	dex
	stx PTR2
	sty PTR2+1			; PTR2=flagbuf-1
	
	lda u16_N
	sta u16_N2
	lda u16_N+1
	sta u16_N2+1

	lsr u16_N2+1
	ror u16_N2
	lsr u16_N2+1
	ror u16_N2
	lsr u16_N2+1
	ror u16_N2			; N2 >>= 3
	
	ldy #2
	sty u16_i
	lda #0
	sta u16_i+1			; i=2
	sta u16_count2
	sta u16_count2+1		; count2=0
while3					; while(i<=N2)
	lda u16_N2
	cmp u16_i
	lda u16_N2+1
	sbc u16_i+1
	bcc while3out			; i>st

	ldy u16_i
	lda (PTR2),Y			; flag[i]
	bne else3
					; if !flag[i]
	inc u16_count2
	bne @+
	inc u16_count2+1		; count2++
@	lda u16_i
	ldx u16_i+1
	jsr printu16
	lda #' '
	jsr putc			; print i

else3
	inc u16_i
	bne while3
	inc u16_i+1			; i++; PTR1++
	inc PTR2+1
	bne while3			; end while3
while3out
	lda #CR
	jsr putc

	lda 20
	ldx 19				; read print time
	sta u16_tm4
	stx u16_tm4+1
	sec
	sbc u16_tm2
	sta u16_tm3
	txa
	sbc u16_tm2+1
	sta u16_tm3+1			; tm3-=tm2
	lda u16_tm2
	sec
	sbc u16_tm1
	sta u16_tm2
	lda u16_tm2+1
	sbc u16_tm1+1
	sta u16_tm2+1			; tm2-=tm1
	
;
; print timings	
	lda u16_N
	ldx u16_N+1			; print N
	jsr printu16
	lda #STR3&$FF
	sta PTR1
	lda #STR3/256
	sta PTR1+1
	jsr putstring
	lda u16_tm1
	ldx u16_tm1+1
	jsr printu16			; print tm memset
	lda #STR2&$FF
	sta PTR1
	lda #STR2/256
	sta PTR1+1
	jsr putstring
				
	lda u16_count
	ldx u16_count+1
	jsr printu16			; print count
	lda #STR1&$FF
	sta PTR1
	lda #STR1/256
	sta PTR1+1
	jsr putstring
	lda u16_tm2
	ldx u16_tm2+1
	jsr printu16			; print tm prime calc
	lda #STR2&$FF
	sta PTR1
	lda #STR2/256
	sta PTR1+1
	jsr putstring
	
	lda u16_count2
	ldx u16_count2+1
	jsr printu16			; print count
	lda #STR1&$FF
	sta PTR1
	lda #STR1/256
	sta PTR1+1
	jsr putstring
	lda u16_tm3
	ldx u16_tm3+1
	jsr printu16			; print tm prime calc
	lda #STR2&$FF
	sta PTR1
	lda #STR2/256
	sta PTR1+1
	jsr putstring
	lda u16_tm4
	ldx u16_tm4+1
	jsr printu16			; print tm prime calc
	lda #STR4&$FF
	sta PTR1
	lda #STR4/256
	sta PTR1+1
	jsr putstring		
	
le	jmp le	
	rts
.endp					; main

CR	= $9B

; zero page locations	
PTR1 	= $80		; users memset, printfr0, putnchar
PTR2	= $82		; users main
PTR3	= $84		; users main

W1	= $80
W2	= $82

B3	= $82
B5	= $84


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

; OS jump table
CIOV   =   $E456

; floating point package
FR0		= $D4	; 6 byte FP register
INBUFF		= $F3	; 2 byte pointer to input buffer
FASC		= $D8E6	; floating point to ATASCII, LBUFF = (string)FR0, INBUFF = last char
IFP		= $D9AA ; 16bit integer in FR0 to floating point in FR0 

STR1		.byte ' PRIMES IN',CR
STR2		.byte ' TICKS',CR
STR3		.byte ' BYTES CLEARED IN',CR
STR4		.byte ' TICKS TOTAL',CR
u16_k		= $88
u16_i		= $90
u16_count	= $92
u16_N		= $94
u16_N2		= $96
u16_count2	= $98

; variables not initialized
.align $100
flagbuf		.DS	NN
u16_tm1		.DS	2
u16_tm2		.DS	2
u16_tm3		.DS	2
u16_tm4		.DS	2
	
	run main	; start address
	
			