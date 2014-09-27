; TUTA8.ASM 11MAR02				
; using single switch on Port A to increment Port B LED count

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
TRISA	EQU	H'85'		; equivalent of TRISB, but for Port A DDR
PORTA	EQU	H'05'		; equivalent of PORTB, but for Port A
W	EQU	0		;
F	EQU	1		;
				
COUNT	EQU	H'20'		; variable used to count up when switch is pressed
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTA		;
	CLRF	PORTB		;
	PAGE1			;
	MOVLW	B'00000001'	; this binary value shows which bits are set to 1
				; in this case, only bit 0 is set to 1 and the value
	MOVWF	TRISA		; is used to set Port A with pin RA0 as input
				; and pins RA1, RA2, RA3 and RA4 as outputs
				; (but will not be used in this example)
	CLRF	TRISB		; Port B is set with all pins as outputs as before
	PAGE0			;
				
BEGIN	CLRF	COUNT		; clear counter
LOOP	MOVF	PORTA,W		; copy the value of PORTA into W
	ANDLW	B'00000001'	; the value is ANDed with binary 1 so that only
				; the status of the first bit (bit 0) of Port A will
				; have any effect
	ADDWF	COUNT,F		; the value of Port A bit 0 is added to the counter
				; if switch is pressed bit 0 = 1;
				; if switch is unpressed bit 0 = 0
	MOVF	COUNT,W		; copy the value of COUNT into W
	MOVWF	PORTB		; and set Port B to that value
	GOTO	LOOP		; in this example, the loop is repeated endlessly

	END			; final statement
