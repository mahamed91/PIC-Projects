; TUTA6.ASM 11MAR02				
; as TUTA4 but using Z and RRF

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully clockwise (max.rate) 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
;
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; 16F84 Config word - RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

				
#DEFINE	PAGE0	BCF 	STATUS,5	
#DEFINE	PAGE1	BSF 	STATUS,5	
				
STATUS	EQU	H'03'		;
TRISB	EQU	H'86'		;
PORTB	EQU	H'06'		;
W	EQU	0		; Working
F	EQU	1		; File
C	EQU	0		; Carry
Z	EQU	2		; Zero
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTB		;
	PAGE1			;
	CLRF	TRISB		;
	PAGE0			;
				
LOOP1	MOVLW	D'128'		; load value of 128 into Working register
	MOVWF	PORTB		; load this value (10000000) into Port B
	BCF	STATUS,C		; clear Carry bit
				
LOOP2	RRF	PORTB,F		; rotate value of PORTB right by 1 logical place
	MOVF	PORTB,F		; cause status of Zero bit to be registered
				; (the command movf PORTB,W has the same effect)
	BTFSS	STATUS,Z		; check if the Zero flag (bit 2) of the STATUS
				; register has been set to high, indicating that
				; PORTB has returned to a value 0 after it has been
				; shifted right 8 times
	GOTO	LOOP2		; this command is actioned only if PORTB is not yet 0
				; the program jumping back to the address called LOOP2
	GOTO	LOOP1		; this command is only actioned when PORTB now = 0

	END			; final statement
