; TUTA2.ASM  06MAR02

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
	__CONFIG H'3F3B'                ; RC mode
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
				
; setting Port B to output mode and turn on each led
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory

	CLRF	H'06'		; set all Port B pins to logic 0
	BSF	H'03',5		; instruct program that a Page 1 command comes next
	CLRF	H'86'		; set all Port B pins as outputs from within Page 1
	BCF	H'03',5		; instruct program that a Page 0 command comes next
	BSF	H'06',7		; set Port B pin 0 to logic 1
	BSF	H'06',6		; set Port B pin 1 to logic 1
	BSF	H'06',5		; set Port B pin 2 to logic 1
	BSF	H'06',4		; set Port B pin 3 to logic 1
	BSF	H'06',3		; set Port B pin 4 to logic 1
	BSF	H'06',2		; set Port B pin 5 to logic 1
	BSF	H'06',1		; set Port B pin 6 to logic 1
	BSF	H'06',0		; set Port B pin 7 to logic 1
	CLRF 	H'06' 		; Resets all the registers
	BSF	H'06',0		; set Port B pin 0 to logic 1
	BSF	H'06',1		; set Port B pin 1 to logic 1
	BSF	H'06',2		; set Port B pin 2 to logic 1
	BSF	H'06',3		; set Port B pin 3 to logic 1
	BSF	H'06',4		; set Port B pin 4 to logic 1
	BSF	H'06',5		; set Port B pin 5 to logic 1
	BSF	H'06',6		; set Port B pin 6 to logic 1
	BSF	H'06',7		; set Port B pin 7 to logic 1
	GOTO 	5 		; Goes to the begginig of the program !!
	END			; final statement
