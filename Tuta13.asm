; TUTA13.ASM 11MAR02				
; as TUTA12 but showing SWAPF

;::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator:  RC mode, fast, VR1 your choice of setting 
; LCD display: off 
; 7-segment display:  off 
; Version 2 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
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
	MOVLW	B'00011111'	;
	MOVWF	TRISA		;
	CLRF	TRISB		;
	PAGE0			;
				
LOOP	SWAPF	PORTA,W		; swap the lefthand and righthand nibbles (4 bits)
				; of Port A into W
	ANDLW	B'11110001'	; AND the answer with 11110001 to get data on
				; bits 0 to 3 (as were, but now in bits 4 to 7)
	MOVWF	PORTB		; put this answer out to Port B
	GOTO	LOOP		; the loop is repeated endlessly

	END			; final statement
