
_Serial_println:

;THERMAL_PRINTER.c,3 :: 		void Serial_println(char *s){
;THERMAL_PRINTER.c,4 :: 		while(*s){
L_Serial_println0:
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_println1
;THERMAL_PRINTER.c,5 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_println_s+0, 1 
	INCF        FARG_Serial_println_s+1, 1 
;THERMAL_PRINTER.c,6 :: 		}
	GOTO        L_Serial_println0
L_Serial_println1:
;THERMAL_PRINTER.c,7 :: 		UART1_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;THERMAL_PRINTER.c,8 :: 		}
L_end_Serial_println:
	RETURN      0
; end of _Serial_println

_Serial_print:

;THERMAL_PRINTER.c,9 :: 		void Serial_print(char *s){
;THERMAL_PRINTER.c,10 :: 		while(*s){
L_Serial_print2:
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_print3
;THERMAL_PRINTER.c,11 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_print_s+0, 1 
	INCF        FARG_Serial_print_s+1, 1 
;THERMAL_PRINTER.c,12 :: 		}
	GOTO        L_Serial_print2
L_Serial_print3:
;THERMAL_PRINTER.c,13 :: 		}
L_end_Serial_print:
	RETURN      0
; end of _Serial_print

_main:

;THERMAL_PRINTER.c,15 :: 		void main() {
;THERMAL_PRINTER.c,16 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;THERMAL_PRINTER.c,17 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;THERMAL_PRINTER.c,19 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;THERMAL_PRINTER.c,20 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
	NOP
;THERMAL_PRINTER.c,22 :: 		do{
L_main5:
;THERMAL_PRINTER.c,23 :: 		if(state == 0){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       0
	XORWF       _state+0, 0 
L__main18:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;THERMAL_PRINTER.c,24 :: 		LATC.RC0 = 0; //A
	BCF         LATC+0, 0 
;THERMAL_PRINTER.c,25 :: 		LATC.RC1 = 0; //B
	BCF         LATC+0, 1 
;THERMAL_PRINTER.c,26 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	DECFSZ      R11, 1, 1
	BRA         L_main9
	NOP
	NOP
;THERMAL_PRINTER.c,28 :: 		Serial_println("Hello World, this is output 1");
	MOVLW       ?lstr1_THERMAL_PRINTER+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr1_THERMAL_PRINTER+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;THERMAL_PRINTER.c,30 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;THERMAL_PRINTER.c,31 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
	NOP
;THERMAL_PRINTER.c,32 :: 		}
	GOTO        L_main11
L_main8:
;THERMAL_PRINTER.c,33 :: 		else if(state == 1){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       1
	XORWF       _state+0, 0 
L__main19:
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;THERMAL_PRINTER.c,34 :: 		LATC.RC0 = 1; //A
	BSF         LATC+0, 0 
;THERMAL_PRINTER.c,35 :: 		LATC.RC1 = 0; //B
	BCF         LATC+0, 1 
;THERMAL_PRINTER.c,36 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
	NOP
;THERMAL_PRINTER.c,38 :: 		Serial_print("Hello World, this is output 2");
	MOVLW       ?lstr2_THERMAL_PRINTER+0
	MOVWF       FARG_Serial_print_s+0 
	MOVLW       hi_addr(?lstr2_THERMAL_PRINTER+0)
	MOVWF       FARG_Serial_print_s+1 
	CALL        _Serial_print+0, 0
;THERMAL_PRINTER.c,40 :: 		state = 0;
	CLRF        _state+0 
	CLRF        _state+1 
;THERMAL_PRINTER.c,41 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
;THERMAL_PRINTER.c,42 :: 		}
L_main12:
L_main11:
;THERMAL_PRINTER.c,43 :: 		}while(1);
	GOTO        L_main5
;THERMAL_PRINTER.c,44 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
