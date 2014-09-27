; TUTA1.ASM 11MAR02

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
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

				
; minimum requirement
				
	ORG	0		; Reset vector
	GOTO	5		; goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; goto start of program
	ORG	5		; Start of program memory

	; (your program goes in here)

	END			; final statement
