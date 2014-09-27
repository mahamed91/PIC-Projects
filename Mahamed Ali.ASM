;****************************************************************
;  PIC project for WJEC AS Electronics ET3 <Spring Term 2013>
;  By Mahamed Ali 
;  Saved as <Light Project.asm>
;****************************************************************
;  The board must be set to <SLOW> mode
;****************************************************************
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                 ;RC mode                
;****************************************************************
; Definitions
#DEFINE	PAGE0	BCF	STATUS,5
#DEFINE	PAGE1	BSF	STATUS,5
 

; Declarations
STATUS	EQU	H'03'	
TRISA	EQU	H'05'	
PORTA	EQU	H'05'	
TRISB	EQU	H'06'	
PORTB	EQU	H'06'	
temp1	EQU	H'0C'	
temp2	EQU	H'0D'	
temp3	EQU	H'0E'
temp4	EQU	H'0F'
COUNT	EQU	H'20'		

W	EQU	0		; working register label
F	EQU	1		; file register label
C	EQU	0		; carry flag
Z	EQU	2		; zero flag

;**************************  VECTORS  ***************************
; PIC 1684 vectors live at the bottom of memory (0004h to 0007h)
	ORG	0		; reset vector
	GOTO	5		; go to start of program
	ORG	4		; interrupt vector address
	GOTO	5		; go to start of program
	ORG	5		; start of program memory

;************************  PORT SETUP  **************************
PORTS	CLRF 	PORTA		; clear ports
	CLRF 	PORTB		; before program starts
	PAGE1
	MOVLW	B'00011111'	; value to set up port A
	MOVWF	TRISA		; 
	MOVLW 	B'00000000'	; value to set up port B
	MOVWF 	TRISB
	PAGE0

;****************************************************************
	GOTO MAIN
;****************************************************************
;  ****Subroutines  ***
; By convention, subroutines are placed after the vectors so
; that they are at the bottom of memory. This avoids
; memory bank switching for small programs.

; Time delay subroutines for fast mode.
; onems=1ms;  tenth = 0·1s;  quart=0·25ms;  second=1s.
onems	MOVLW	H'0CB'
	MOVWF	temp1
again1 	NOP
	DECFSZ	temp1,F
	GOTO	again1
	NOP
	RETURN

tenth	MOVLW	H'064'
	MOVWF	temp2
again2 	CALL	onems
	DECFSZ	temp2,1
	GOTO	again2
	RETURN

quart  	MOVLW	H'0F9'
	MOVWF	temp3
again3	CALL	onems
	DECFSZ	temp3,F
	GOTO	again3
	RETURN

second	MOVLW	H'04'
	MOVWF	temp4
again4	CALL	quart
	DECFSZ	temp4,F
	GOTO	again4
	RETURN

First	CLRF	H'06'		; set all Port B pins to logic 0
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
	CLRF PORTB		;
	RETURN

UPCOUNT	BCF	STATUS,Z
COUNTU	MOVF	COUNT,W		; load the value of COUNT into Working register
	MOVWF	PORTB		; set Port B to the value of COUNT
	INCFSZ	COUNT,F		; increment (add 1 to) the value of COUNT and check
				; if it has reached zero (rolled over from 255 to 0)
	GOTO	COUNTU		; this command is actioned only if COUNT is not yet 0
				; the program jumping back to the address called LOOP1
				; if COUNT has reached zero, the next routine starting
				; at address LOOP2 is begun
	RETURN

DECOUNT	BSF 	STATUS,Z
COUNTD	MOVF	COUNT,W		; load the value of COUNT into Working register
	MOVWF	PORTB		; set Port B to the value of COUNT
	DECFSZ	COUNT,F		; decrement (subtract 1 from) the value of COUNT and
				; check if it has reached zero
	GOTO	COUNTD		; this command is actioned only if COUNT is not yet 0
				; the program jumping back to address LOOP2
	RETURN			; this command is actioned only if COUNT has become
				; zero, in which case the program jumps back to LOOP1



;************************ Main Program **************************

MAIN				; start of main program


WAIT1 	BTFSS PORTA,0		;
	GOTO  WAIT1		;

	CALL First

 	BTFSS	PORTA,4		; Checks if KILL Switch is pressed
	CALL 	First		; If not it repeats loop or it kills the sequen
	
	CLRF 	PORTB		; Clears the register

WAIT2 	BTFSS PORTA,1		;
	GOTO  WAIT2		;
	
	CALL UPCOUNT

	BTFSS	PORTA,4		; Checks if KILL Switch is pressed
	CALL	UPCOUNT		; If not it repeats loop or it kills the sequen
	CLRF 	PORTB		; Clears the register 
	GOTO	WAIT3


WAIT3 	BTFSS PORTA,2		;
	GOTO  WAIT3		;

	CALL DECOUNT

	BTFSS	PORTA,4		; Checks if KILL Switch is pressed
	GOTO 	UPCOUNT		; If not it repeats loop or it kills the sequen
	CLRF 	PORTB		; Clears the register 	
	GOTO 	WAIT4
	

WAIT4 	BTFSS PORTA,3		;
	GOTO  WAIT4		;

LOOP1	MOVLW	3		; load value of 1 into Working register
	MOVWF	PORTB		; load this value as data into Port B
	BCF	STATUS,C		; clear Carry flag
				
LOOP2	RLF	PORTB,F		; rotate value of PORTB left by 1 logical place#
	BTFSS	STATUS,C		; check Carry flag is set
	GOTO	LOOP2		; this command is actioned only if PORTB is not yet 0
				; the program jumping back to address LOOP2

LOOP3	RRF	PORTB,F		; rotate value of PORTB right by 1 logical place
	BTFSS	STATUS,C		; check Carry flag is set
	GOTO	LOOP3		; this command is actioned only if PORTB is not yet 0
				; the program jumping back to address LOOP2

	GOTO	LOOP1		; this command is only actioned when PORTB now = 0


	END			; End if the program !!