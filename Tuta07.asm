; TUTA7.ASM 11MAR02
; the use of loops while checking zero status
; illustrating both down and up counts

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully clockwise (max.rate) 
; LCD display:  off
; 7-segment display:  off
; Version 2 board settings:  J14 links: Digital 
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
W	EQU	0		;
F	EQU	1		;
Z	EQU	2		;
				
COUNT	EQU	H'20'		; name program location 20 (hex) as variable called COUNT
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
				
	CLRF	PORTB		;
	PAGE1			;
	CLRF	TRISB		;
	PAGE0			;
	CLRF	COUNT		; set COUNT to zero
				
				; up count
LOOP1	MOVF	COUNT,W		; load the value of COUNT into Working register
	MOVWF	PORTB		; set Port B to the value of COUNT
	INCFSZ	COUNT,F		; increment (add 1 to) the value of COUNT and check
				; if it has reached zero (rolled over from 255 to 0)
	GOTO	LOOP1		; this command is actioned only if COUNT is not yet 0
				; the program jumping back to the address called LOOP1
				; if COUNT has reached zero, the next routine starting
				; at address LOOP2 is begun

				; down count
LOOP2	MOVF	COUNT,W		; load the value of COUNT into Working register
	MOVWF	PORTB		; set Port B to the value of COUNT
	DECFSZ	COUNT,F		; decrement (subtract 1 from) the value of COUNT and
				; check if it has reached zero
	GOTO	LOOP2		; this command is actioned only if COUNT is not yet 0
				; the program jumping back to address LOOP2
	GOTO	LOOP1		; this command is actioned only if COUNT has become
				; zero, in which case the program jumps back to LOOP1

	END			; final statement
