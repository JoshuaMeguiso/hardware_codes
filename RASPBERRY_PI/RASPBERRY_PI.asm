
_main:

;RASPBERRY_PI.c,1 :: 		void main(){
;RASPBERRY_PI.c,2 :: 		UART1_INIT(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;RASPBERRY_PI.c,3 :: 		delay_ms(100);
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
;RASPBERRY_PI.c,5 :: 		do{
L_main1:
;RASPBERRY_PI.c,6 :: 		delay_ms(10000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;RASPBERRY_PI.c,7 :: 		UART1_WRITE_TEXT("1|Joshua Uriel Meguiso|RM001|April 20, 2023 - May 20, 2023|2700.00|300.00|1000|2000|1000|400.00|200.00|3200.00\x0D");
	MOVLW       ?lstr1_RASPBERRY_PI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_RASPBERRY_PI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;RASPBERRY_PI.c,8 :: 		delay_ms(10000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;RASPBERRY_PI.c,9 :: 		UART1_WRITE_TEXT("2|Joshua Uriel Meguiso|RM001|April, 2023|April 20, 2023|May 20, 2023|2700.00|300.00|200.00|3200.00|0.00|May 22, 2023\x0D");
	MOVLW       ?lstr2_RASPBERRY_PI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_RASPBERRY_PI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;RASPBERRY_PI.c,10 :: 		delay_ms(10000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;RASPBERRY_PI.c,11 :: 		UART1_WRITE_TEXT("3|February|3200.00|March 01, 2023|+639614680406\x0D");
	MOVLW       ?lstr3_RASPBERRY_PI+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_RASPBERRY_PI+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;RASPBERRY_PI.c,13 :: 		}while(1);
	GOTO        L_main1
;RASPBERRY_PI.c,14 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
