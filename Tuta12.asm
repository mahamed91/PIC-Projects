; TUTA12.ASM 11MAR02				
; using 5 switches on Port A, showing their status on Port B

;:::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, fast, VR1 your choice of setting 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings:  J14 links: Digital 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::: 
;
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

				
#DEFINE	PAGE0	BCF 	STATUS,5	
#DEFINE	PAGE1	BSF 	STATUS,5	
				
STATUS	EQU	H'03'		;
TRISA	EQU	H'85'		;
PORTA	EQU	H'05'		;
TRISB	EQU	H'86'		;
PORTB	EQU	H'06'		;
W	EQU	0		;
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTB		;
	PAGE1			;
	MOVLW	B'00011111'	; all PORTA as input
	MOVWF	TRISA		;
	CLRF	TRISB		;
	PAGE0			;
				
LOOP	MOVF	PORTA,W		; get value of PORTA
	ANDLW	B'00011111'	; ANDED with binary 11111 so that only
				; first 5 bits of 8-bit value in W
				; have any effect
	MOVWF	PORTB		; set Port B to the value of Port A
	GOTO	LOOP		; the loop is repeated endlessly

	END			; final statement
