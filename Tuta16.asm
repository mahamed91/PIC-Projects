; TUTA16.ASM 11MAR02				
; showing use of CALL and RETURN

;:::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, fast, VR1 your choice of setting 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings: J14 links: Digital 
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
F	EQU	1		;
Z	EQU	2		;
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	PORTB		;
	PAGE1			;
	MOVLW	B'00011111'	; RA0-RA4 as input
	MOVWF	TRISA		;
	CLRF	TRISB		;
	PAGE0			;
				
LOOP	CALL	PROG1		
	MOVWF	PORTB		
	GOTO	LOOP		
				
PROG1	MOVF	PORTA,W		
	RETURN			
				
	END			; final statement
