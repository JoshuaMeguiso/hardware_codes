
_main:

;Serial_PIC.c,3 :: 		void main() {
;Serial_PIC.c,4 :: 		UART1_INIT(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Serial_PIC.c,5 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
	NOP
;Serial_PIC.c,7 :: 		while(1){
L_main1:
;Serial_PIC.c,8 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;Serial_PIC.c,9 :: 		uart_rd = UART1_READ();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Serial_PIC.c,10 :: 		UART1_WRITE(uart_rd);
	MOVF        R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Serial_PIC.c,11 :: 		}
L_main3:
;Serial_PIC.c,12 :: 		}
	GOTO        L_main1
;Serial_PIC.c,13 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
