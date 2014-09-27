; TUTA15.ASM 11MAR02				
; showing how a switch on RA1 can cause a note on RA0

;::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, fast, VR1 your choice of setting 
; LCD display: off 
; 7-segment display: off 
; High impedance headphones should be connected to audio jack
; Version 2 board settings: J14 links: Digital 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::
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
				
NOTE	EQU	H'20'		; note counter
FREQ	EQU	H'21'		; note tuning value
				
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
	MOVLW	B'00011110'	; RA0 as output
	MOVWF	TRISA		;
	PAGE0			;
				
SOUND	MOVLW	D'80'		; load W with value of 80
				; (try using different values to change note)
	MOVWF	NOTE		; copy it into NOTE
	MOVWF	FREQ		; and into FREQ. It sets the tuning frequency

GETKEY	BTFSS	PORTA,1		; get data on Port A RA1, is it high
	GOTO	GETKEY		; no, so keep on reading Port A
	DECFSZ	NOTE,F		; yes, now decrement NOTE counter. Is it now = 0?
	GOTO	GETKEY		; no, so again read Port A
	MOVF	FREQ,W		; yes, so first load W with value held in FREQ
	MOVWF	NOTE		; and copy it into NOTE
	INCF	PORTA,F		; now increment Port A RA0
	GOTO	GETKEY		; and go back to reading Port A

	END			; final statement
