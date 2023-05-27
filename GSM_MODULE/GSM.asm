
_serial_println:

;GSM.c,2 :: 		void serial_println(char *s){
;GSM.c,3 :: 		while(*s){
L_serial_println0:
	MOVFF       FARG_serial_println_s+0, FSR0L+0
	MOVFF       FARG_serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_serial_println1
;GSM.c,4 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_serial_println_s+0, FSR0L+0
	MOVFF       FARG_serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_serial_println_s+0, 1 
	INCF        FARG_serial_println_s+1, 1 
;GSM.c,5 :: 		}
	GOTO        L_serial_println0
L_serial_println1:
;GSM.c,6 :: 		UART1_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;GSM.c,7 :: 		}
L_end_serial_println:
	RETURN      0
; end of _serial_println

_serial_print:

;GSM.c,8 :: 		void serial_print(char *s){
;GSM.c,9 :: 		while(*s){
L_serial_print2:
	MOVFF       FARG_serial_print_s+0, FSR0L+0
	MOVFF       FARG_serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_serial_print3
;GSM.c,10 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_serial_print_s+0, FSR0L+0
	MOVFF       FARG_serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_serial_print_s+0, 1 
	INCF        FARG_serial_print_s+1, 1 
;GSM.c,11 :: 		}
	GOTO        L_serial_print2
L_serial_print3:
;GSM.c,12 :: 		}
L_end_serial_print:
	RETURN      0
; end of _serial_print

_main:

;GSM.c,13 :: 		void main(){
;GSM.c,14 :: 		UART1_INIT(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;GSM.c,15 :: 		delay_ms(40000); //40 seconds
	MOVLW       203
	MOVWF       R11, 0
	MOVLW       236
	MOVWF       R12, 0
	MOVLW       132
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;GSM.c,17 :: 		do{
L_main5:
;GSM.c,18 :: 		serial_println("AT+CMGF=1");
	MOVLW       ?lstr1_GSM+0
	MOVWF       FARG_serial_println_s+0 
	MOVLW       hi_addr(?lstr1_GSM+0)
	MOVWF       FARG_serial_println_s+1 
	CALL        _serial_println+0, 0
;GSM.c,19 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;GSM.c,20 :: 		serial_print("AT+CMGS=\"");
	MOVLW       ?lstr2_GSM+0
	MOVWF       FARG_serial_print_s+0 
	MOVLW       hi_addr(?lstr2_GSM+0)
	MOVWF       FARG_serial_print_s+1 
	CALL        _serial_print+0, 0
;GSM.c,21 :: 		serial_print("09614680406");
	MOVLW       ?lstr3_GSM+0
	MOVWF       FARG_serial_print_s+0 
	MOVLW       hi_addr(?lstr3_GSM+0)
	MOVWF       FARG_serial_print_s+1 
	CALL        _serial_print+0, 0
;GSM.c,22 :: 		serial_print("\"\x0D");
	MOVLW       ?lstr4_GSM+0
	MOVWF       FARG_serial_print_s+0 
	MOVLW       hi_addr(?lstr4_GSM+0)
	MOVWF       FARG_serial_print_s+1 
	CALL        _serial_print+0, 0
;GSM.c,23 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;GSM.c,24 :: 		serial_println("Testing from Joshua, Rachel, and Angelica");
	MOVLW       ?lstr5_GSM+0
	MOVWF       FARG_serial_println_s+0 
	MOVLW       hi_addr(?lstr5_GSM+0)
	MOVWF       FARG_serial_println_s+1 
	CALL        _serial_println+0, 0
;GSM.c,25 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
	NOP
	NOP
;GSM.c,26 :: 		UART1_WRITE(0x1A);
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;GSM.c,27 :: 		delay_ms(14000);
	MOVLW       72
	MOVWF       R11, 0
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       159
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
	NOP
;GSM.c,29 :: 		}while(1);
	GOTO        L_main5
;GSM.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
