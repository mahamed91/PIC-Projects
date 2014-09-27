; TUTA3.ASM  06MAR02

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully clockwise (max.rate) 
; LCD display: off 
; 7-segment display: off 
; Version 2 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
				
; using names to ease writing of TUTA2
				
STATUS	EQU	H'03'		; name program location 3 as STATUS
PORTB	EQU	H'06'		; name program location 6 as PORTB
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	PORTB		; clear Port B data pins
	BSF	STATUS,5		; Page 1
	CLRF	PORTB		; set all Port B as output via Page 1
	BCF	STATUS,5		; Page 0
				
Begin   MOVLW 01010101   ; Loaded some values to the PORTB
	MOVWF PORTB	   ;
	End 		; 
