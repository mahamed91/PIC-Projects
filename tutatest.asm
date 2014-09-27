; TUTATEST.ASM 11MAR02
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully anticlockwise (min.rate) 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
;
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; RC mode
	
	; Use the following for the 16F88
	; Note - check that you have set the ASMIDE Assemble, Options target to /p16F88
	;__CONFIG H'2007', H'3F3B'      ; 16F88 Config word 1
	;__CONFIG H'2008', H'3FFC'      ; 16F88 Config word 2
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
				
; Test program for tutor board
				
STATUS	EQU	H'03'		
PORTA	EQU	H'05'		
PORTB	EQU	H'06'		
TRISA	EQU	H'85'		
TRISB	EQU	H'86'		
F	EQU	1		
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	PORTA		
	CLRF	PORTB		
	BSF	STATUS,5	; Page 1
	CLRF	TRISA		; Port A all outputs
	CLRF	TRISB		; Port B all outputs
	;CLRF	H'9B'		; uncomment for the 16F88. Sets Analogue pins to digital - Page 1 op
	BCF	STATUS,5	; Page 0
				
LOOPIT	INCF	PORTA,F		
	INCF	PORTB,F		
	GOTO	LOOPIT		
				
	END			
