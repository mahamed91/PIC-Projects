;TUTA10.ASM 11MAR02				
; using single switch on Port A to increment PORTB LED count
; showing how bit testing can be used to test switch status
; and to cause a count increment only at the moment the switch is pressed

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully clockwise (max.rate) 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings:  J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
				
COUNT	EQU	H'20'		;
SWITCH	EQU	H'21'		; variable to hold previous switch status
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTB		;
	PAGE1			;
	MOVLW	1		;
	MOVWF	TRISA		;
	CLRF	TRISB		;
	PAGE0			;
				
BEGIN	CLRF	COUNT		;
	CLRF	SWITCH		;
				
TESTIT	BTFSC	PORTA,0		; test bit 0 of Port A, is it clear?
	GOTO	TSTPRV		; no, it's = 1 so go to TSTPRV
	BCF	SWITCH,0		; clear bit 0 of SWITCH
	GOTO	TESTIT		; jump back to TESTIT
TSTPRV	BTFSC	SWITCH,0		; test bit 0 of SWITCH, is it clear?
	GOTO	TESTIT		; no, it's = 1 so go to TESTIT
	INCF	COUNT,F		; yes, it's = 0 so inc count
	MOVF	COUNT,W		; get COUNT
	MOVWF	PORTB		; output to PORTB
	BSF	SWITCH,0		; set bit 0 of SWITCH
	GOTO	TESTIT		; repeat

	END			; final statement
