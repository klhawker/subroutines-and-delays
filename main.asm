    processor 18F8722
    config OSC=HS, WDT=OFF, LVP=OFF
    radix decimal
    org 0x00
   
TRISA equ 0xF92
TRISF equ 0xF97
LATA equ 0xF89
LATF equ 0xF8E
PORTB equ 0xF81
PORTJ equ 0xF88
ADCON1 equ 0xFC1
PB1 equ 0x08
PB2 equ 0x09
COUNTER equ 0x400
COUNTER2 equ 0x10
COUNTER3 equ 0x11
COUNTER4 equ 0x12
 
    MOVLW B'00001111'
    MOVWF ADCON1
   
    SETF PORTJ; SET PB1 TO INPUT
    SETF PORTB ;SET PB2 TO INPUT

    MOVLW 53
    MOVLB 0x01       ; Set bank selection flag to 1
    MOVWF COUNTER, 1 ; Store value at address 0x400
   
    MOVLW 1
    MOVWF COUNTER2
   
    MOVLW 255
    MOVWF COUNTER3
   
    MOVLW 255
    MOVWF COUNTER4

   
    BCF TRISA, 4
    BCF TRISF, 0
    BSF LATF, 0
    BCF LATA, 4
   
   
PB2_LOOP ;     LOOP INDEFINITELY UNTIL PB2 IS PRESSED
    MOVF PORTB, W
    MOVWF PB2
    BTFSC PB2, 0
    BRA PB2_LOOP
   
   
L_MAIN
    MOVF PORTJ, W
    MOVWF PB1
    BTFSS PB1, 5
    BRA LOOP_FOR_400MS
    BSF LATA, 4
    CALL DELAY_40MS
    BCF LATA,4
    CALL DELAY_40MS
    BRA L_MAIN
   
LOOP_FOR_400MS
    BSF LATA, 4
    CALL DELAY_400MS
    BCF LATA,4
    CALL DELAY_400MS
    BRA LOOP_FOR_400MS
 
;-----------------SUBROUTINES------------------
DELAY_40MS
    CALL NEW_SUB
    DECF COUNTER, 1 ; Decrease value at address 0x400
    BNZ DELAY_40MS
   
    RETURN

NEW_SUB
    DECF COUNTER2
    BNZ NEW_SUB
    RETURN
   
   
DELAY_400MS
    CALL NEW_SUB2
    DECF COUNTER3; Decrease value at address 0x400
    BNZ DELAY_40MS
   
    RETURN

NEW_SUB2
    DECF COUNTER4
    BNZ NEW_SUB
    RETURN
   
    end