; TUTA4.ASM 11MAR02

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84
; Oscillator:  RC mode, slow, VR1 fully clockwise (max.rate)
; LCD display: off 
; 7-segment display: off
; Version 2 board settings: J14 links: Digital 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
;
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
				
; using aliases, bit names and conditional loops
				
#DEFINE	PAGE0	BCF	STATUS,5
#DEFINE	PAGE1	BSF	STATUS,5
				
STATUS	EQU	H'03'		; STATUS register
TRISB	EQU	H'86'		; Port B direction register
PORTB	EQU	H'06'		; Port B data register
PORTA	EQU	H'05'  		;
TRISA	EQU 	H'05'		;
W	EQU	0		; Working register flag
F	EQU	1		; File register flag
C	EQU	0		; Carry flag
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	PORTB		; clear Port B data register
	PAGE1			; PAGE1
	CLRF	TRISB		; Port B direction register for output
	PAGE0			; PAGE0
				
WAIT1 	BTFSC PORTA,0		;
	GOTO  WAIT1		;

LOOP1	MOVLW	3		; load value of 1 into Working register
	MOVWF	PORTB		; load this value as data into Port B
	BCF	STATUS,C		; clear Carry flag
				
LOOP2	RLF	PORTB,F		; rotate value of PORTB left by 1 logical place
	BTFSS	STATUS,C		; check Carry flag is set
	GOTO	LOOP2		; this command is actioned only if PORTB is not yet 0
				; the program jumping back to address LOOP2

LOOP3	RRF	PORTB,F		; rotate value of PORTB right by 1 logical place
	BTFSS	STATUS,C		; check Carry flag is set
	GOTO	LOOP3		; this command is actioned only if PORTB is not yet 0
				; the program jumping back to address LOOP2

	GOTO	LOOP1		; this command is only actioned when PORTB now = 0

	END			; final statement
