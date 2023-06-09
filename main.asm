    processor 18F8722
    config OSC=HS, WDT=OFF, LVP=OFF
    radix decimal
    org 0x00

TRISA equ 0xF92
TRISB equ 0xF93
TRISF equ 0xF97
TRISJ equ 0xF9A
LATA equ 0xF89
LATF equ 0xF8E
PORTB equ 0xF81
PORTJ equ 0xF88
ADCON1 equ 0xFC1
PB1_STATUS equ 0x13
PB2_STATUS equ 0x14
COUNTER equ 0x400
COUNTER2 equ 0x10
COUNTER3 equ 0x11
COUNTER4 equ 0x12

    MOVLW B'00001111'
    MOVWF ADCON1

    BSF TRISJ, 5 ; SET PB1 TO INPUT
    BSF TRISB, 0 ; SET PB2 TO INPUT

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
    ANDLW B'00000001'
    MOVWF PB2_STATUS
    BTFSC PB2_STATUS, 0
    BRA PB2_LOOP

L_MAIN
    MOVF PORTJ, W
    ANDLW B'00100000'
    MOVWF PB1_STATUS
    BTFSC PB1_STATUS, 5
    BRA SHORT_DELAY
    BRA LONG_DELAY

SHORT_DELAY
    BSF LATA, 4
    CALL DELAY_40MS
    BCF LATA, 4
    CALL DELAY_40MS
    BRA L_MAIN

LONG_DELAY
    BSF LATA, 4
    CALL DELAY_400MS
    BCF LATA, 4
    CALL DELAY_400MS
    BRA L_MAIN

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
    BNZ DELAY_400MS

    RETURN

NEW_SUB2
    NOP
    NOP
    DECF COUNTER4
    BNZ NEW_SUB2
    RETURN

    end
