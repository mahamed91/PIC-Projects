; TUTA9.ASM 11MAR02				
; using single switch on Port A to increment Port B LED count
; showing how bit testing can be used to test switch status
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F84 
; Oscillator: RC mode, slow, VR1 fully clockwise (max.rate) 
; LCD display: off 
; 7-segment display:off 
; Version 2 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;
; The following line embeds configuration data into the PICmicro


	radix hex

; Register Definitions:
INDF    EQU 00
TMR0    EQU 01
PCL     EQU 02
STATUS  EQU 03
FSR     EQU 04
PORTA   EQU 05
PORTB   EQU 06
EEDATA  EQU 08
EEADR   EQU 09
PCLATH  EQU 0A
INTCON  EQU 0B
OPSHUN  EQU 81
TRISA   EQU 85
TRISB   EQU 86
EECON1  EQU 88
EECON2  EQU 89

COUNT   EQU 20

; Constant Definitions:
W       EQU 00
F       EQU 01


; Program Start:
        ORG 0

        GOTO   005            ; Goto start of program
        NOP                   
        NOP                   
        NOP                   
        GOTO   005            ; Goto start of program
        CLRF   PORTB          
        CLRF   COUNT          
        BSF    STATUS,05      
        MOVLW  01             ; RA0 as input
        MOVWF  TRISA          
        CLRF   TRISB          
        BCF    STATUS,05      

LOOP    BTFSS  PORTA,00       ; test bit 0 of Port A, is it set (= 1)?
        GOTO   LOOP           ; no, it's = 0, so got back to LOOP
        INCF   COUNT,F        ; yes, it's = 1 so increment count
        MOVF   COUNT,W        ; get COUNT value
        MOVWF  PORTB          ; output it to PORTB
        GOTO   LOOP           ; repeat

        END
