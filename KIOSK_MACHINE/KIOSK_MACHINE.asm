
_INIT_SOFT_UART:

;KIOSK_MACHINE.c,7 :: 		void INIT_SOFT_UART(){
;KIOSK_MACHINE.c,10 :: 		error = SOFT_UART_INIT(&PORTC, 2, 1, 9600, 0);
	MOVLW       PORTC+0
	MOVWF       FARG_Soft_UART_Init_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Soft_UART_Init_port+1 
	MOVLW       2
	MOVWF       FARG_Soft_UART_Init_rx_pin+0 
	MOVLW       1
	MOVWF       FARG_Soft_UART_Init_tx_pin+0 
	MOVLW       128
	MOVWF       FARG_Soft_UART_Init_baud_rate+0 
	MOVLW       37
	MOVWF       FARG_Soft_UART_Init_baud_rate+1 
	MOVLW       0
	MOVWF       FARG_Soft_UART_Init_baud_rate+2 
	MOVWF       FARG_Soft_UART_Init_baud_rate+3 
	CLRF        FARG_Soft_UART_Init_inverted+0 
	CALL        _Soft_UART_Init+0, 0
;KIOSK_MACHINE.c,11 :: 		}
L_end_INIT_SOFT_UART:
	RETURN      0
; end of _INIT_SOFT_UART

_INIT_PORTS:

;KIOSK_MACHINE.c,12 :: 		void INIT_PORTS(){
;KIOSK_MACHINE.c,13 :: 		TRISC.RC4 = 0;
	BCF         TRISC+0, 4 
;KIOSK_MACHINE.c,14 :: 		TRISC.RC5 = 0;
	BCF         TRISC+0, 5 
;KIOSK_MACHINE.c,15 :: 		}
L_end_INIT_PORTS:
	RETURN      0
; end of _INIT_PORTS

_main:

;KIOSK_MACHINE.c,16 :: 		void main() {
;KIOSK_MACHINE.c,17 :: 		INIT_PORTS();
	CALL        _INIT_PORTS+0, 0
;KIOSK_MACHINE.c,18 :: 		INIT_SOFT_UART();
	CALL        _INIT_SOFT_UART+0, 0
;KIOSK_MACHINE.c,19 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;KIOSK_MACHINE.c,20 :: 		delay_ms(100);
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
;KIOSK_MACHINE.c,22 :: 		do{
L_main1:
;KIOSK_MACHINE.c,23 :: 		if(UART1_DATA_READY()){  //CHECK IF THE DATA IS READY TO READ
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;KIOSK_MACHINE.c,24 :: 		output = UART1_READ(); //READ CHARACTER
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _output+0 
;KIOSK_MACHINE.c,26 :: 		if(output == 'T' && stx_Counter < 3){
	MOVF        R0, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
	MOVLW       128
	XORWF       _stx_Counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       3
	SUBWF       _stx_Counter+0, 0 
L__main37:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
L__main33:
;KIOSK_MACHINE.c,27 :: 		stx[stx_Counter] = output;
	MOVLW       _stx+0
	ADDWF       _stx_Counter+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_stx+0)
	ADDWFC      _stx_Counter+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _output+0, 0 
	MOVWF       POSTINC1+0 
;KIOSK_MACHINE.c,28 :: 		}
	GOTO        L_main8
L_main7:
;KIOSK_MACHINE.c,29 :: 		else if(output == 'R' && stx_Counter < 3){
	MOVF        _output+0, 0 
	XORLW       82
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       128
	XORWF       _stx_Counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVLW       3
	SUBWF       _stx_Counter+0, 0 
L__main38:
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
L__main32:
;KIOSK_MACHINE.c,30 :: 		stx[stx_Counter] = output;
	MOVLW       _stx+0
	ADDWF       _stx_Counter+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_stx+0)
	ADDWFC      _stx_Counter+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _output+0, 0 
	MOVWF       POSTINC1+0 
;KIOSK_MACHINE.c,31 :: 		}
	GOTO        L_main12
L_main11:
;KIOSK_MACHINE.c,32 :: 		else if(output == 'G' && stx_Counter < 3){
	MOVF        _output+0, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVLW       128
	XORWF       _stx_Counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       3
	SUBWF       _stx_Counter+0, 0 
L__main39:
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
L__main31:
;KIOSK_MACHINE.c,33 :: 		stx[stx_Counter] = output;
	MOVLW       _stx+0
	ADDWF       _stx_Counter+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_stx+0)
	ADDWFC      _stx_Counter+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _output+0, 0 
	MOVWF       POSTINC1+0 
;KIOSK_MACHINE.c,34 :: 		}
	GOTO        L_main16
L_main15:
;KIOSK_MACHINE.c,36 :: 		if(output == 0X1A){ // END OF TEXT, RETURN TO STATE 0
	MOVF        _output+0, 0 
	XORLW       26
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;KIOSK_MACHINE.c,37 :: 		stx[0] = 0;       //EMPTY CHARACTER
	CLRF        _stx+0 
;KIOSK_MACHINE.c,38 :: 		stx[1] = 0;       //EMPTY CHARACTER
	CLRF        _stx+1 
;KIOSK_MACHINE.c,39 :: 		stx[2] = 0;       //EMPTY CHARACTER
	CLRF        _stx+2 
;KIOSK_MACHINE.c,40 :: 		stx_Counter = stx_Counter - stx_Counter - 1; //stx_Counter = 0
	MOVLW       255
	MOVWF       _stx_Counter+0 
	MOVLW       255
	MOVWF       _stx_Counter+1 
;KIOSK_MACHINE.c,41 :: 		state = 0;
	CLRF        _state+0 
	CLRF        _state+1 
;KIOSK_MACHINE.c,42 :: 		}
L_main17:
;KIOSK_MACHINE.c,43 :: 		if(stx[0] == 'R' && stx[1] == 'R' && stx[2] == 'R' && state == 0){ //RFID MODULE
	MOVF        _stx+0, 0 
	XORLW       82
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
	MOVF        _stx+1, 0 
	XORLW       82
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
	MOVF        _stx+2, 0 
	XORLW       82
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVLW       0
	XORWF       _state+0, 0 
L__main40:
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
L__main30:
;KIOSK_MACHINE.c,44 :: 		LATC.RC4 = 0; //A
	BCF         LATC+0, 4 
;KIOSK_MACHINE.c,45 :: 		LATC.RC5 = 0; //B
	BCF         LATC+0, 5 
;KIOSK_MACHINE.c,46 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;KIOSK_MACHINE.c,47 :: 		}
L_main20:
;KIOSK_MACHINE.c,48 :: 		if(stx[0] == 'T' && stx[1] == 'T' && stx[2] == 'T' && state == 0){ //THERMAL PRINTER
	MOVF        _stx+0, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	MOVF        _stx+1, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	MOVF        _stx+2, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVLW       0
	XORWF       _state+0, 0 
L__main41:
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
L__main29:
;KIOSK_MACHINE.c,49 :: 		LATC.RC4 = 1; //A
	BSF         LATC+0, 4 
;KIOSK_MACHINE.c,50 :: 		LATC.RC5 = 0; //B
	BCF         LATC+0, 5 
;KIOSK_MACHINE.c,51 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;KIOSK_MACHINE.c,52 :: 		}
L_main23:
;KIOSK_MACHINE.c,53 :: 		if(stx[0] == 'G' && stx[1] == 'G' && stx[2] == 'G' && state == 0){ //GSM MODULE
	MOVF        _stx+0, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	MOVF        _stx+1, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	MOVF        _stx+2, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main42
	MOVLW       0
	XORWF       _state+0, 0 
L__main42:
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
L__main28:
;KIOSK_MACHINE.c,54 :: 		LATC.RC4 = 0; //A
	BCF         LATC+0, 4 
;KIOSK_MACHINE.c,55 :: 		LATC.RC5 = 1; //B
	BSF         LATC+0, 5 
;KIOSK_MACHINE.c,56 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;KIOSK_MACHINE.c,57 :: 		}
L_main26:
;KIOSK_MACHINE.c,58 :: 		if(state != 0){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main43
	MOVLW       0
	XORWF       _state+0, 0 
L__main43:
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
;KIOSK_MACHINE.c,59 :: 		SOFT_UART_WRITE(output); //PRINT CHARACTER
	MOVF        _output+0, 0 
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;KIOSK_MACHINE.c,60 :: 		}
L_main27:
;KIOSK_MACHINE.c,61 :: 		}
L_main16:
L_main12:
L_main8:
;KIOSK_MACHINE.c,62 :: 		stx_Counter++;
	INFSNZ      _stx_Counter+0, 1 
	INCF        _stx_Counter+1, 1 
;KIOSK_MACHINE.c,63 :: 		}
L_main4:
;KIOSK_MACHINE.c,64 :: 		}while(1);
	GOTO        L_main1
;KIOSK_MACHINE.c,65 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
