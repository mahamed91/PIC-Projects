;****************************************************************
;  PIC project for WJEC AS Electronics ET3 <Spring Term 2013>
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
temp4	EQU	H'0F'
		
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
	MOVLW	B'00000000'	; value to set up port A
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

;************************ Main Program **************************

MAIN				; start of main program

	BSF	STATUS,C	; set the Carry bit in STATUS

LOOP	RLF	PORTB,F		; rotate left PORTB
	CALL 	second		;
	GOTO	LOOP		; repeat


;****************************************************************

;******************* INTERRUPT SERVICE ROUTINE ******************
;The interrupt service routine (if required) goes here
INTER				; used in A2 work only
;****************************************************************
	END			; all programs must end with this

