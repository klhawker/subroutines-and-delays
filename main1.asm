    processor pic18f8722
    config OSC=HS, LVP=OFF, WDT=OFF
    radix decimal
    org 0x00
    
TRISA equ 0xF92 ; Transistor Q3 powers the LEDs
LATA equ 0xF89
TRISC equ 0xF94 ; Lower 4 switches RC3?0
PORTC equ 0xF82
TRISF equ 0xF97 ; LEDs
LATF equ 0xF8E
TRISH equ 0xF99 ; Transistors (RH1?0) & switches (RH7?4)
LATH equ 0xF90 ; Transistors Q1, Q2 for 7?segments U1, U2, RH0, RH1
PORTH equ 0xF87 ; Upper four switches (RH7?4)
PORTB equ 0xF81
PORTJ equ 0xF88
TRISJ equ 0xF9A
LATJ equ 0xF91
TRISB equ 0xF93
LATB equ 0xF8A
ADCON1 equ 0xFC1
COUNTER1 equ 0x400
COUNTER2 equ 0x09
PB1 equ 0x10
PB2 equ 0x11
COUNTER3 equ 0x12
 
    CALL SUB_400ms
    NOP
 
    MOVLW 71
    MOVLB 1
    MOVWF COUNTER1, 1
    
    MOVLW 57
    MOVWF COUNTER2
    
    MOVLW 3
    MOVWF COUNTER3
 
    SETF LATH ; TURN OFF Q2 AND Q1
    CLRF LATH ;TURN OFF Q3
    
    CLRF TRISF
    CLRF TRISA
    
    MOVLW B'00000001'
    MOVWF LATF
    
    MOVLW B'00001111'
    MOVWF ADCON1
    
    BSF TRISB, 0
    
L_PB2
    MOVF PORTB, W
    MOVWF PB2
    BTFSC PB2, 0
    BRA L_PB2
    
L_MAIN
    CALL SUB_40ms
    BTG LATA, 4
    CALL SUB_40ms
    BRA L_MAIN
    
    
;--------SUBROUTINES-----------
SUB_400ms
    CALL SUB_40ms
    DECF COUNTER3
    BNZ SUB_400ms
    RETURN
    
SUB_40ms
    CALL SUB_200us
    DECF COUNTER2
    
    BNZ SUB_40ms
    RETURN

    
SUB_200us
    NOP
    NOP
    NOP
    NOP
    DECF COUNTER1, 1
    BNZ SUB_200us
    RETURN
 
    end