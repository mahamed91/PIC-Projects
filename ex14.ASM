;****************************************************************
;  PIC project for WJEC AS Electronics ET3 <Spring Term 2012>
;  By <add name + candidate number>
;  Saved as <Title.asm>
;****************************************************************
;  The board must be set to <FAST*/SLOW*> mode
; [ Choose either FAST or SLOW and delete the other!   ]
; [ State position of VR1 if necessary,                ]
; [ especially if operating in SLOW mode               ]
;****************************************************************
; The following line embeds configuration data into the PICmicro
	__CONFIG H'3FFB'                ; RC mode                
;****************************************************************
; Definitions
#DEFINE	PAGE0	BCF	STATUS,5
#DEFINE	PAGE1	BSF	STATUS,5
; [make any other definitions of your own here]

; Declarations
STATUS	EQU	H'03'	
TRISA	EQU	H'05'	
PORTA	EQU	H'05'	
TRISB	EQU	H'06'	
PORTB	EQU	H'06'	
temp1	EQU	H'0C'	
temp2	EQU	H'0D'	
temp3	EQU	H'0E'
COUNT	EQU	H'20'
		
; [Declare name(s) of any other registers you use here]
; [Use addresses H'10' to H'2F']

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
	MOVLW	B'00000011'	; value to set up port A
	MOVWF	TRISA		; [replace each x with 1 or 0]
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


;************************ Main Program **************************

MAIN				; start of main program

WAIT1 	BTFSS PORTA, 0		;
	GOTO  WAIT1		;

Start	CLRF	H'06'		; set all Port B pins to logic 0
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
WAIT2 	BTFSS	PORTA,1		;
	GOTO 	Start		;
	CLRF 	PORTB ;

 	GOTO 	MAIN		;



;****************************************************************

;******************* INTERRUPT SERVICE ROUTINE ******************
;The interrupt service routine (if required) goes here
INTER				; used in A2 work only
;****************************************************************
	END			; all programs must end with this

