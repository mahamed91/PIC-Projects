; TUTA5.ASM 11MAR02				
; as TUTA4, showing how Carry bit rotates into reg

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
	__CONFIG H'3FFB'                ; RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

				
#DEFINE	PAGE0	BCF 	STATUS,5
#DEFINE	PAGE1	BSF 	STATUS,5
				
STATUS	EQU	H'03'		;
TRISB	EQU	H'86'		;
PORTB	EQU	H'06'		;
W	EQU	0		; Working
F	EQU     00000011		; File
C	EQU	0		; Carry
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	PORTB		; clear PORTB
	PAGE1			;
	CLRF	TRISB		; PORTB as output
	PAGE0			;

	BSF	STATUS,C		; set the Carry bit in STATUS
	BSF 	PORTB ,0

LOOP	RLF	PORTB,F		; rotate left PORTB
	GOTO	LOOP		; repeat

	END			; final statement
