; TUTA11.ASM 11MAR02				
; using two switches on Port A, one to increment PORTB LED count
; (SA0/RA0) and one to decrement it (SA2/RA2). SA0 takes priority.

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, fast, VR1 your choice of setting 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings: J14 links: Digital 
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
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
SWITCH	EQU	H'21'		;
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTB		;
	PAGE1			;
	MOVLW	B'00000101'	; RA0, RA2 as inputs
	MOVWF	TRISA		;
	CLRF	TRISB		;
	PAGE0			;
				
BEGIN	CLRF	COUNT		;
	CLRF	SWITCH		;
				
TEST1	BTFSC	PORTA,0		; test bit 0 of Port A, is it clear?
	GOTO	TSTPR1		; no, it's = 1 so go to TSTPR1
	BCF	SWITCH,0		; clear bit 0 of SWITCH
	GOTO	TEST2		; go to check bit 2
TSTPR1	BTFSC	SWITCH,0		; test bit 0 of SWITCH, is it clear?
	GOTO	TEST2		; no, it's = 1 so go to check bit 2
	BSF	SWITCH,0		; set bit 0 of SWITCH
	INCF	COUNT,F		; yes, it's = 0 so inc count
	GOTO	OUTPUT		; bypass TEST2 completely
				
TEST2	BTFSC	PORTA,2		; test bit 2 of Port A, is it clear?
	GOTO	TSTPR2		; no, it's = 1 so go to TSTPR2
	BCF	SWITCH,2		; clear bit 2 of SWITCH
	GOTO	TEST1		; jump back to TEST1
TSTPR2	BTFSC	SWITCH,2		; test bit 2 of SWITCH, is it clear?
	GOTO	TEST1		; no, it's = 1 so go to TEST1
	BSF	SWITCH,2		; set bit 2 of SWITCH
	DECF	COUNT,F		; yes, it's = 0 so dec count
				
OUTPUT	MOVF	COUNT,W		;
	MOVWF	PORTB		;
	GOTO	TEST1		;
				
	END			; final statement
