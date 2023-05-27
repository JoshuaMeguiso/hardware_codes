
_interrupt:

;config.h,58 :: 		void interrupt(){
;config.h,59 :: 		if(INTCON.INT0IF == 1){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;config.h,60 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;config.h,61 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
;config.h,62 :: 		billCounter++;  //increment bill
	INFSNZ      _billCounter+0, 1 
	INCF        _billCounter+1, 1 
;config.h,64 :: 		INTCON.INT0IF = 0;  //reset to 0
	BCF         INTCON+0, 1 
;config.h,65 :: 		}
L_interrupt0:
;config.h,66 :: 		}
L_end_interrupt:
L__interrupt86:
	RETFIE      1
; end of _interrupt

_setup:

;config.h,68 :: 		void setup(){
;config.h,69 :: 		TRISB.RB0 = 1;    //init port pulse
	BSF         TRISB+0, 0 
;config.h,70 :: 		TRISD.RD0 = 0;
	BCF         TRISD+0, 0 
;config.h,71 :: 		TRISD.RC1 = 0;
	BCF         TRISD+0, 1 
;config.h,72 :: 		A = 1;
	BSF         LATD+0, 0 
;config.h,73 :: 		B = 0;
	BCF         LATD+0, 1 
;config.h,74 :: 		UART1_INIT(BAUD_RATE); //init hardware uart
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;config.h,75 :: 		SOFT_UART_INIT(&PORTC, SOFT_RX, SOFT_TX, BAUD_RATE, 0);
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
;config.h,76 :: 		delay_ms(100);    //to stabilized the ports
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_setup1:
	DECFSZ      R13, 1, 1
	BRA         L_setup1
	DECFSZ      R12, 1, 1
	BRA         L_setup1
	NOP
	NOP
;config.h,79 :: 		Soft_Serial_println("AT");
	MOVLW       ?lstr1_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr1_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,80 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup2:
	DECFSZ      R13, 1, 1
	BRA         L_setup2
	DECFSZ      R12, 1, 1
	BRA         L_setup2
	DECFSZ      R11, 1, 1
	BRA         L_setup2
	NOP
	NOP
;config.h,81 :: 		Soft_Serial_println("AT+CREG=2");
	MOVLW       ?lstr2_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr2_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,82 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup3:
	DECFSZ      R13, 1, 1
	BRA         L_setup3
	DECFSZ      R12, 1, 1
	BRA         L_setup3
	DECFSZ      R11, 1, 1
	BRA         L_setup3
	NOP
	NOP
;config.h,83 :: 		Soft_Serial_println("AT+CREG?");
	MOVLW       ?lstr3_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr3_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,84 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup4:
	DECFSZ      R13, 1, 1
	BRA         L_setup4
	DECFSZ      R12, 1, 1
	BRA         L_setup4
	DECFSZ      R11, 1, 1
	BRA         L_setup4
	NOP
	NOP
;config.h,85 :: 		Soft_Serial_println("AT+CREG=1");
	MOVLW       ?lstr4_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr4_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,86 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup5:
	DECFSZ      R13, 1, 1
	BRA         L_setup5
	DECFSZ      R12, 1, 1
	BRA         L_setup5
	DECFSZ      R11, 1, 1
	BRA         L_setup5
	NOP
	NOP
;config.h,87 :: 		Reset();
	CALL        _Reset+0, 0
;config.h,89 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;config.h,90 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;config.h,91 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;config.h,92 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_printerConfig:

;config.h,93 :: 		void printerConfig(){
;config.h,95 :: 		SOFT_UART_WRITE(0x1C);
	MOVLW       28
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,96 :: 		SOFT_UART_WRITE(0x2E);
	MOVLW       46
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,99 :: 		SOFT_UART_WRITE(0x1D);
	MOVLW       29
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,100 :: 		SOFT_UART_WRITE(0x4C);
	MOVLW       76
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,101 :: 		SOFT_UART_WRITE(0x46); //Length Value
	MOVLW       70
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,102 :: 		SOFT_UART_WRITE(0x00); //Length Value
	CLRF        FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,103 :: 		}
L_end_printerConfig:
	RETURN      0
; end of _printerConfig

_Serial_println:

;config.h,104 :: 		void Serial_println(char *s){
;config.h,105 :: 		while(*s){
L_Serial_println6:
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_println7
;config.h,106 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_println_s+0, 1 
	INCF        FARG_Serial_println_s+1, 1 
;config.h,107 :: 		}
	GOTO        L_Serial_println6
L_Serial_println7:
;config.h,108 :: 		UART1_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,109 :: 		}
L_end_Serial_println:
	RETURN      0
; end of _Serial_println

_Serial_print:

;config.h,110 :: 		void Serial_print(char *s){
;config.h,111 :: 		while(*s){
L_Serial_print8:
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_print9
;config.h,112 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_print_s+0, 1 
	INCF        FARG_Serial_print_s+1, 1 
;config.h,113 :: 		}
	GOTO        L_Serial_print8
L_Serial_print9:
;config.h,114 :: 		}
L_end_Serial_print:
	RETURN      0
; end of _Serial_print

_Soft_Serial_println:

;config.h,115 :: 		void Soft_Serial_println(char *s){
;config.h,116 :: 		while(*s){
L_Soft_Serial_println10:
	MOVFF       FARG_Soft_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Soft_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Soft_Serial_println11
;config.h,117 :: 		SOFT_UART_WRITE(*s++);
	MOVFF       FARG_Soft_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Soft_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
	INFSNZ      FARG_Soft_Serial_println_s+0, 1 
	INCF        FARG_Soft_Serial_println_s+1, 1 
;config.h,118 :: 		}
	GOTO        L_Soft_Serial_println10
L_Soft_Serial_println11:
;config.h,119 :: 		SOFT_UART_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,120 :: 		}
L_end_Soft_Serial_println:
	RETURN      0
; end of _Soft_Serial_println

_Soft_Serial_print:

;config.h,121 :: 		void Soft_Serial_print(char *s){
;config.h,122 :: 		while(*s){
L_Soft_Serial_print12:
	MOVFF       FARG_Soft_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Soft_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Soft_Serial_print13
;config.h,123 :: 		SOFT_UART_WRITE(*s++);
	MOVFF       FARG_Soft_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Soft_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
	INFSNZ      FARG_Soft_Serial_print_s+0, 1 
	INCF        FARG_Soft_Serial_print_s+1, 1 
;config.h,124 :: 		}
	GOTO        L_Soft_Serial_print12
L_Soft_Serial_print13:
;config.h,125 :: 		}
L_end_Soft_Serial_print:
	RETURN      0
; end of _Soft_Serial_print

_Bill_Counter:

;config.h,126 :: 		void Bill_Counter(){
;config.h,127 :: 		if(billCounter == 20){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter94
	MOVLW       20
	XORWF       _billCounter+0, 0 
L__Bill_Counter94:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter14
;config.h,128 :: 		UART1_WRITE('1');
	MOVLW       49
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,129 :: 		}
	GOTO        L_Bill_Counter15
L_Bill_Counter14:
;config.h,130 :: 		else if(billCounter == 50){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter95
	MOVLW       50
	XORWF       _billCounter+0, 0 
L__Bill_Counter95:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter16
;config.h,131 :: 		UART1_WRITE('2');
	MOVLW       50
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,132 :: 		}
	GOTO        L_Bill_Counter17
L_Bill_Counter16:
;config.h,133 :: 		else if(billCounter == 100){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter96
	MOVLW       100
	XORWF       _billCounter+0, 0 
L__Bill_Counter96:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter18
;config.h,134 :: 		UART1_WRITE('3');
	MOVLW       51
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,135 :: 		}
	GOTO        L_Bill_Counter19
L_Bill_Counter18:
;config.h,136 :: 		else if(billCounter == 4){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter97
	MOVLW       4
	XORWF       _billCounter+0, 0 
L__Bill_Counter97:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter20
;config.h,137 :: 		UART1_WRITE('4');
	MOVLW       52
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,138 :: 		}
	GOTO        L_Bill_Counter21
L_Bill_Counter20:
;config.h,139 :: 		else if(billCounter == 5){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter98
	MOVLW       5
	XORWF       _billCounter+0, 0 
L__Bill_Counter98:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter22
;config.h,140 :: 		UART1_WRITE('5');
	MOVLW       53
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,141 :: 		}
	GOTO        L_Bill_Counter23
L_Bill_Counter22:
;config.h,142 :: 		else if(billCounter == 6){
	MOVLW       0
	XORWF       _billCounter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Bill_Counter99
	MOVLW       6
	XORWF       _billCounter+0, 0 
L__Bill_Counter99:
	BTFSS       STATUS+0, 2 
	GOTO        L_Bill_Counter24
;config.h,143 :: 		UART1_WRITE('6');
	MOVLW       54
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,144 :: 		}
L_Bill_Counter24:
L_Bill_Counter23:
L_Bill_Counter21:
L_Bill_Counter19:
L_Bill_Counter17:
L_Bill_Counter15:
;config.h,145 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
;config.h,146 :: 		billCounter = 0;
	CLRF        _billCounter+0 
	CLRF        _billCounter+1 
;config.h,147 :: 		state = 0;
	CLRF        _state+0 
	CLRF        _state+1 
;config.h,148 :: 		}
L_end_Bill_Counter:
	RETURN      0
; end of _Bill_Counter

_State_Selector:

;config.h,150 :: 		void State_Selector(char s){
;config.h,151 :: 		if(s == '1'){
	MOVF        FARG_State_Selector_s+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_State_Selector25
;config.h,152 :: 		state = 2;  //Thermal Printer (SOA)
	MOVLW       2
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;config.h,153 :: 		A = 0;
	BCF         LATD+0, 0 
;config.h,154 :: 		B = 0;
	BCF         LATD+0, 1 
;config.h,155 :: 		delay_ms(50);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_State_Selector26:
	DECFSZ      R13, 1, 1
	BRA         L_State_Selector26
	DECFSZ      R12, 1, 1
	BRA         L_State_Selector26
	NOP
;config.h,156 :: 		}
L_State_Selector25:
;config.h,157 :: 		if(s == '2'){
	MOVF        FARG_State_Selector_s+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_State_Selector27
;config.h,158 :: 		state = 3;  //Thermal Printer (Reciept)
	MOVLW       3
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;config.h,159 :: 		A = 0;
	BCF         LATD+0, 0 
;config.h,160 :: 		B = 0;
	BCF         LATD+0, 1 
;config.h,161 :: 		delay_ms(50);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_State_Selector28:
	DECFSZ      R13, 1, 1
	BRA         L_State_Selector28
	DECFSZ      R12, 1, 1
	BRA         L_State_Selector28
	NOP
;config.h,162 :: 		}
L_State_Selector27:
;config.h,163 :: 		if(s == '3'){
	MOVF        FARG_State_Selector_s+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_State_Selector29
;config.h,164 :: 		state = 4;  //GSM
	MOVLW       4
	MOVWF       _state+0 
	MOVLW       0
	MOVWF       _state+1 
;config.h,165 :: 		A = 1;
	BSF         LATD+0, 0 
;config.h,166 :: 		B = 0;
	BCF         LATD+0, 1 
;config.h,167 :: 		delay_ms(50);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_State_Selector30:
	DECFSZ      R13, 1, 1
	BRA         L_State_Selector30
	DECFSZ      R12, 1, 1
	BRA         L_State_Selector30
	NOP
;config.h,168 :: 		}
L_State_Selector29:
;config.h,169 :: 		}
L_end_State_Selector:
	RETURN      0
; end of _State_Selector

_Reset:

;config.h,170 :: 		void Reset(){
;config.h,171 :: 		memset(output, 0, maxLength);
	MOVLW       _output+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       255
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,172 :: 		memset(tenant_Name, 0, minLenght);
	MOVLW       _tenant_Name+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_tenant_Name+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,173 :: 		memset(room_ID, 0, minLenght);
	MOVLW       _room_ID+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_room_ID+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,174 :: 		memset(period_Covered, 0, minLenght);
	MOVLW       _period_Covered+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_period_Covered+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,175 :: 		memset(room_Rate, 0, minLenght);
	MOVLW       _room_Rate+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_room_Rate+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,176 :: 		memset(water_Charge, 0, minLenght);
	MOVLW       _water_Charge+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_water_Charge+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,177 :: 		memset(previous_Reading, 0, minLenght);
	MOVLW       _previous_Reading+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_previous_Reading+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,178 :: 		memset(present_Reading, 0, minLenght);
	MOVLW       _present_Reading+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_present_Reading+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,179 :: 		memset(total_Consume, 0, minLenght);
	MOVLW       _total_Consume+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_total_Consume+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,180 :: 		memset(room_Consume, 0, minLenght);
	MOVLW       _room_Consume+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_room_Consume+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,181 :: 		memset(individual_Consume, 0, minLenght);
	MOVLW       _individual_Consume+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_individual_Consume+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,182 :: 		memset(total_Amount, 0, minLenght);
	MOVLW       _total_Amount+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_total_Amount+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,183 :: 		memset(bill_Month, 0, minLenght);
	MOVLW       _bill_Month+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_bill_Month+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,184 :: 		memset(start_Month, 0, minLenght);
	MOVLW       _start_Month+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_start_Month+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,185 :: 		memset(end_Month, 0, minLenght);
	MOVLW       _end_Month+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_end_Month+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,186 :: 		memset(paid_Amount, 0, minLenght);
	MOVLW       _paid_Amount+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_paid_Amount+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,187 :: 		memset(date_Paid, 0, minLenght);
	MOVLW       _date_Paid+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_date_Paid+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,188 :: 		memset(number, 0, minLenght);
	MOVLW       _number+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_number+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       50
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;config.h,190 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;config.h,191 :: 		i = 0;
	CLRF        _i+0 
	CLRF        _i+1 
;config.h,192 :: 		index = 0;
	CLRF        _index+0 
	CLRF        _index+1 
;config.h,193 :: 		state = 0;
	CLRF        _state+0 
	CLRF        _state+1 
;config.h,194 :: 		}
L_end_Reset:
	RETURN      0
; end of _Reset

_SOA_Seperator:

;config.h,195 :: 		void SOA_Seperator(){
;config.h,196 :: 		while(i <= index){
L_SOA_Seperator31:
	MOVLW       128
	XORWF       _index+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator103
	MOVF        _i+0, 0 
	SUBWF       _index+0, 0 
L__SOA_Seperator103:
	BTFSS       STATUS+0, 0 
	GOTO        L_SOA_Seperator32
;config.h,197 :: 		if(output[i] == '|'){
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       124
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator33
;config.h,198 :: 		counter++;
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;config.h,199 :: 		j = 0;
	CLRF        _j+0 
	CLRF        _j+1 
;config.h,200 :: 		}
	GOTO        L_SOA_Seperator34
L_SOA_Seperator33:
;config.h,202 :: 		if(counter == 1){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator104
	MOVLW       1
	XORWF       _counter+0, 0 
L__SOA_Seperator104:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator35
;config.h,203 :: 		tenant_Name[j] = output[i];
	MOVLW       _tenant_Name+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_tenant_Name+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,204 :: 		}
L_SOA_Seperator35:
;config.h,205 :: 		if(counter == 2){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator105
	MOVLW       2
	XORWF       _counter+0, 0 
L__SOA_Seperator105:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator36
;config.h,206 :: 		room_ID[j] = output[i];
	MOVLW       _room_ID+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_room_ID+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,207 :: 		}
L_SOA_Seperator36:
;config.h,208 :: 		if(counter == 3){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator106
	MOVLW       3
	XORWF       _counter+0, 0 
L__SOA_Seperator106:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator37
;config.h,209 :: 		period_Covered[j] = output[i];
	MOVLW       _period_Covered+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_period_Covered+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,210 :: 		}
L_SOA_Seperator37:
;config.h,211 :: 		if(counter == 4){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator107
	MOVLW       4
	XORWF       _counter+0, 0 
L__SOA_Seperator107:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator38
;config.h,212 :: 		room_Rate[j] = output[i];
	MOVLW       _room_Rate+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_room_Rate+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,213 :: 		}
L_SOA_Seperator38:
;config.h,214 :: 		if(counter == 5){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator108
	MOVLW       5
	XORWF       _counter+0, 0 
L__SOA_Seperator108:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator39
;config.h,215 :: 		water_Charge[j] = output[i];
	MOVLW       _water_Charge+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_water_Charge+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,216 :: 		}
L_SOA_Seperator39:
;config.h,217 :: 		if(counter == 6){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator109
	MOVLW       6
	XORWF       _counter+0, 0 
L__SOA_Seperator109:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator40
;config.h,218 :: 		previous_Reading[j] = output[i];
	MOVLW       _previous_Reading+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_previous_Reading+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,219 :: 		}
L_SOA_Seperator40:
;config.h,220 :: 		if(counter == 7){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator110
	MOVLW       7
	XORWF       _counter+0, 0 
L__SOA_Seperator110:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator41
;config.h,221 :: 		present_Reading[j] = output[i];
	MOVLW       _present_Reading+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_present_Reading+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,222 :: 		}
L_SOA_Seperator41:
;config.h,223 :: 		if(counter == 8){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator111
	MOVLW       8
	XORWF       _counter+0, 0 
L__SOA_Seperator111:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator42
;config.h,224 :: 		total_Consume[j] = output[i];
	MOVLW       _total_Consume+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_total_Consume+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,225 :: 		}
L_SOA_Seperator42:
;config.h,226 :: 		if(counter == 9){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator112
	MOVLW       9
	XORWF       _counter+0, 0 
L__SOA_Seperator112:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator43
;config.h,227 :: 		room_Consume[j] = output[i];
	MOVLW       _room_Consume+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_room_Consume+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,228 :: 		}
L_SOA_Seperator43:
;config.h,229 :: 		if(counter == 10){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator113
	MOVLW       10
	XORWF       _counter+0, 0 
L__SOA_Seperator113:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator44
;config.h,230 :: 		individual_Consume[j] = output[i];
	MOVLW       _individual_Consume+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_individual_Consume+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,231 :: 		}
L_SOA_Seperator44:
;config.h,232 :: 		if(counter == 11){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SOA_Seperator114
	MOVLW       11
	XORWF       _counter+0, 0 
L__SOA_Seperator114:
	BTFSS       STATUS+0, 2 
	GOTO        L_SOA_Seperator45
;config.h,233 :: 		total_Amount[j] = output[i];
	MOVLW       _total_Amount+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_total_Amount+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,234 :: 		}
L_SOA_Seperator45:
;config.h,235 :: 		j++;
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;config.h,236 :: 		}
L_SOA_Seperator34:
;config.h,237 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;config.h,238 :: 		}
	GOTO        L_SOA_Seperator31
L_SOA_Seperator32:
;config.h,239 :: 		}
L_end_SOA_Seperator:
	RETURN      0
; end of _SOA_Seperator

_Reciept_Seperator:

;config.h,240 :: 		void Reciept_Seperator(){
;config.h,241 :: 		while(i <= index){
L_Reciept_Seperator46:
	MOVLW       128
	XORWF       _index+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator116
	MOVF        _i+0, 0 
	SUBWF       _index+0, 0 
L__Reciept_Seperator116:
	BTFSS       STATUS+0, 0 
	GOTO        L_Reciept_Seperator47
;config.h,242 :: 		if(output[i] == '|'){
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       124
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator48
;config.h,243 :: 		counter++;
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;config.h,244 :: 		j = 0;
	CLRF        _j+0 
	CLRF        _j+1 
;config.h,245 :: 		}
	GOTO        L_Reciept_Seperator49
L_Reciept_Seperator48:
;config.h,247 :: 		if(counter == 1){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator117
	MOVLW       1
	XORWF       _counter+0, 0 
L__Reciept_Seperator117:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator50
;config.h,248 :: 		tenant_Name[j] = output[i];
	MOVLW       _tenant_Name+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_tenant_Name+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,249 :: 		}
L_Reciept_Seperator50:
;config.h,250 :: 		if(counter == 2){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator118
	MOVLW       2
	XORWF       _counter+0, 0 
L__Reciept_Seperator118:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator51
;config.h,251 :: 		room_ID[j] = output[i];
	MOVLW       _room_ID+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_room_ID+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,252 :: 		}
L_Reciept_Seperator51:
;config.h,253 :: 		if(counter == 3){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator119
	MOVLW       3
	XORWF       _counter+0, 0 
L__Reciept_Seperator119:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator52
;config.h,254 :: 		bill_Month[j] = output[i];
	MOVLW       _bill_Month+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_bill_Month+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,255 :: 		}
L_Reciept_Seperator52:
;config.h,256 :: 		if(counter == 4){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator120
	MOVLW       4
	XORWF       _counter+0, 0 
L__Reciept_Seperator120:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator53
;config.h,257 :: 		start_Month[j] = output[i];
	MOVLW       _start_Month+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_start_Month+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,258 :: 		}
L_Reciept_Seperator53:
;config.h,259 :: 		if(counter == 5){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator121
	MOVLW       5
	XORWF       _counter+0, 0 
L__Reciept_Seperator121:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator54
;config.h,260 :: 		end_Month[j] = output[i];
	MOVLW       _end_Month+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_end_Month+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,261 :: 		}
L_Reciept_Seperator54:
;config.h,262 :: 		if(counter == 6){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator122
	MOVLW       6
	XORWF       _counter+0, 0 
L__Reciept_Seperator122:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator55
;config.h,263 :: 		room_Rate[j] = output[i];
	MOVLW       _room_Rate+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_room_Rate+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,264 :: 		}
L_Reciept_Seperator55:
;config.h,265 :: 		if(counter == 7){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator123
	MOVLW       7
	XORWF       _counter+0, 0 
L__Reciept_Seperator123:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator56
;config.h,266 :: 		water_Charge[j] = output[i];
	MOVLW       _water_Charge+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_water_Charge+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,267 :: 		}
L_Reciept_Seperator56:
;config.h,268 :: 		if(counter == 8){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator124
	MOVLW       8
	XORWF       _counter+0, 0 
L__Reciept_Seperator124:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator57
;config.h,269 :: 		individual_Consume[j] = output[i];
	MOVLW       _individual_Consume+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_individual_Consume+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,270 :: 		}
L_Reciept_Seperator57:
;config.h,271 :: 		if(counter == 9){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator125
	MOVLW       9
	XORWF       _counter+0, 0 
L__Reciept_Seperator125:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator58
;config.h,272 :: 		total_Amount[j] = output[i];
	MOVLW       _total_Amount+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_total_Amount+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,273 :: 		}
L_Reciept_Seperator58:
;config.h,274 :: 		if(counter == 10){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator126
	MOVLW       10
	XORWF       _counter+0, 0 
L__Reciept_Seperator126:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator59
;config.h,275 :: 		paid_Amount[j] = output[i];
	MOVLW       _paid_Amount+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_paid_Amount+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,276 :: 		}
L_Reciept_Seperator59:
;config.h,277 :: 		if(counter == 11){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reciept_Seperator127
	MOVLW       11
	XORWF       _counter+0, 0 
L__Reciept_Seperator127:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reciept_Seperator60
;config.h,278 :: 		date_Paid[j] = output[i];
	MOVLW       _date_Paid+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_date_Paid+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,279 :: 		}
L_Reciept_Seperator60:
;config.h,280 :: 		j++;
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;config.h,281 :: 		}
L_Reciept_Seperator49:
;config.h,282 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;config.h,283 :: 		}
	GOTO        L_Reciept_Seperator46
L_Reciept_Seperator47:
;config.h,284 :: 		}
L_end_Reciept_Seperator:
	RETURN      0
; end of _Reciept_Seperator

_GSM_Seperator:

;config.h,285 :: 		void GSM_Seperator(){
;config.h,286 :: 		while(i <= index){
L_GSM_Seperator61:
	MOVLW       128
	XORWF       _index+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GSM_Seperator129
	MOVF        _i+0, 0 
	SUBWF       _index+0, 0 
L__GSM_Seperator129:
	BTFSS       STATUS+0, 0 
	GOTO        L_GSM_Seperator62
;config.h,287 :: 		if(output[i] == '|'){
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       124
	BTFSS       STATUS+0, 2 
	GOTO        L_GSM_Seperator63
;config.h,288 :: 		counter++;
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;config.h,289 :: 		j = 0;
	CLRF        _j+0 
	CLRF        _j+1 
;config.h,290 :: 		}
	GOTO        L_GSM_Seperator64
L_GSM_Seperator63:
;config.h,292 :: 		if(counter == 1){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GSM_Seperator130
	MOVLW       1
	XORWF       _counter+0, 0 
L__GSM_Seperator130:
	BTFSS       STATUS+0, 2 
	GOTO        L_GSM_Seperator65
;config.h,293 :: 		bill_Month[j] = output[i];
	MOVLW       _bill_Month+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_bill_Month+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,294 :: 		}
L_GSM_Seperator65:
;config.h,295 :: 		if(counter == 2){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GSM_Seperator131
	MOVLW       2
	XORWF       _counter+0, 0 
L__GSM_Seperator131:
	BTFSS       STATUS+0, 2 
	GOTO        L_GSM_Seperator66
;config.h,296 :: 		total_Amount[j] = output[i];
	MOVLW       _total_Amount+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_total_Amount+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,297 :: 		}
L_GSM_Seperator66:
;config.h,298 :: 		if(counter == 3){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GSM_Seperator132
	MOVLW       3
	XORWF       _counter+0, 0 
L__GSM_Seperator132:
	BTFSS       STATUS+0, 2 
	GOTO        L_GSM_Seperator67
;config.h,299 :: 		end_Month[j] = output[i];
	MOVLW       _end_Month+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_end_Month+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,300 :: 		}
L_GSM_Seperator67:
;config.h,301 :: 		if(counter == 4){
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GSM_Seperator133
	MOVLW       4
	XORWF       _counter+0, 0 
L__GSM_Seperator133:
	BTFSS       STATUS+0, 2 
	GOTO        L_GSM_Seperator68
;config.h,302 :: 		number[j] = output[i];
	MOVLW       _number+0
	ADDWF       _j+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_number+0)
	ADDWFC      _j+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _output+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;config.h,303 :: 		}
L_GSM_Seperator68:
;config.h,304 :: 		j++;
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;config.h,305 :: 		}
L_GSM_Seperator64:
;config.h,306 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;config.h,307 :: 		}
	GOTO        L_GSM_Seperator61
L_GSM_Seperator62:
;config.h,308 :: 		}
L_end_GSM_Seperator:
	RETURN      0
; end of _GSM_Seperator

_Print_SOA:

;config.h,309 :: 		void Print_SOA(){
;config.h,310 :: 		printerConfig();
	CALL        _printerConfig+0, 0
;config.h,311 :: 		Soft_Serial_print("\rTenant Name: ");
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,312 :: 		Soft_Serial_println(tenant_Name);
	MOVLW       _tenant_Name+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_tenant_Name+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,313 :: 		Soft_Serial_print("Room ID: ");
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,314 :: 		Soft_Serial_println(room_ID);
	MOVLW       _room_ID+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_room_ID+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,315 :: 		Soft_Serial_print("Period Covered: ");
	MOVLW       ?lstr7_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr7_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,316 :: 		Soft_Serial_println(period_Covered);
	MOVLW       _period_Covered+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_period_Covered+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,317 :: 		Soft_Serial_print("Room Rate: P ");
	MOVLW       ?lstr8_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr8_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,318 :: 		Soft_Serial_println(room_Rate);
	MOVLW       _room_Rate+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_room_Rate+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,319 :: 		Soft_Serial_print("Water Charge: P ");
	MOVLW       ?lstr9_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr9_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,320 :: 		Soft_Serial_println(water_Charge);
	MOVLW       _water_Charge+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_water_Charge+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,321 :: 		Soft_Serial_print("Previous Reading: ");
	MOVLW       ?lstr10_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr10_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,322 :: 		Soft_Serial_print(previous_Reading);
	MOVLW       _previous_Reading+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_previous_Reading+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,323 :: 		Soft_Serial_println(" KWH");
	MOVLW       ?lstr11_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr11_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,324 :: 		Soft_Serial_print("Present Reading: ");
	MOVLW       ?lstr12_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr12_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,325 :: 		Soft_Serial_print(present_Reading);
	MOVLW       _present_Reading+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_present_Reading+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,326 :: 		Soft_Serial_println(" KWH");
	MOVLW       ?lstr13_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr13_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,327 :: 		Soft_Serial_print("Total Consume: ");
	MOVLW       ?lstr14_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr14_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,328 :: 		Soft_Serial_print(total_Consume);
	MOVLW       _total_Consume+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_total_Consume+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,329 :: 		Soft_Serial_println(" KWH");
	MOVLW       ?lstr15_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr15_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,330 :: 		Soft_Serial_print("Room Amount: P ");
	MOVLW       ?lstr16_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr16_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,331 :: 		Soft_Serial_println(room_Consume);
	MOVLW       _room_Consume+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_room_Consume+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,332 :: 		Soft_Serial_print("Indiv. Amount: P ");
	MOVLW       ?lstr17_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr17_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,333 :: 		Soft_Serial_println(individual_Consume);
	MOVLW       _individual_Consume+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_individual_Consume+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,334 :: 		Soft_Serial_print("Total Amount: P ");
	MOVLW       ?lstr18_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr18_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,335 :: 		Soft_Serial_println(total_Amount);
	MOVLW       _total_Amount+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_total_Amount+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,336 :: 		Soft_Serial_print("\r\r\r\r");
	MOVLW       ?lstr19_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr19_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,337 :: 		}
L_end_Print_SOA:
	RETURN      0
; end of _Print_SOA

_Print_Reciept:

;config.h,339 :: 		void Print_Reciept(){
;config.h,340 :: 		printerConfig();
	CALL        _printerConfig+0, 0
;config.h,341 :: 		Soft_Serial_print("\rTenant Name: ");
	MOVLW       ?lstr20_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr20_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,342 :: 		Soft_Serial_println(tenant_Name);
	MOVLW       _tenant_Name+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_tenant_Name+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,343 :: 		Soft_Serial_print("Room ID: ");
	MOVLW       ?lstr21_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr21_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,344 :: 		Soft_Serial_println(room_ID);
	MOVLW       _room_ID+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_room_ID+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,345 :: 		Soft_Serial_print("Bill Month: ");
	MOVLW       ?lstr22_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr22_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,346 :: 		Soft_Serial_println(bill_Month);
	MOVLW       _bill_Month+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_bill_Month+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,347 :: 		Soft_Serial_print("Period Covered:");
	MOVLW       ?lstr23_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr23_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,348 :: 		Soft_Serial_print(start_Month);
	MOVLW       _start_Month+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_start_Month+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,349 :: 		Soft_Serial_print(" - ");
	MOVLW       ?lstr24_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr24_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,350 :: 		Soft_Serial_println(end_Month);
	MOVLW       _end_Month+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_end_Month+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,351 :: 		Soft_Serial_print("Room Rate: P ");
	MOVLW       ?lstr25_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr25_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,352 :: 		Soft_Serial_println(room_Rate);
	MOVLW       _room_Rate+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_room_Rate+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,353 :: 		Soft_Serial_print("Water Charge: P ");
	MOVLW       ?lstr26_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr26_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,354 :: 		Soft_Serial_println(water_Charge);
	MOVLW       _water_Charge+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_water_Charge+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,355 :: 		Soft_Serial_print("Individual Consume: P ");
	MOVLW       ?lstr27_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr27_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,356 :: 		Soft_Serial_println(individual_Consume);
	MOVLW       _individual_Consume+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_individual_Consume+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,357 :: 		Soft_Serial_print("Due Amount: P ");
	MOVLW       ?lstr28_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr28_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,358 :: 		Soft_Serial_println(total_Amount);
	MOVLW       _total_Amount+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_total_Amount+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,359 :: 		Soft_Serial_print("Paid Amount: P ");
	MOVLW       ?lstr29_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr29_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,360 :: 		Soft_Serial_println(paid_Amount);
	MOVLW       _paid_Amount+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_paid_Amount+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,361 :: 		Soft_Serial_print("Date Paid: ");
	MOVLW       ?lstr30_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr30_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,362 :: 		Soft_Serial_println(date_Paid);
	MOVLW       _date_Paid+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(_date_Paid+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,363 :: 		Soft_Serial_print("\r\r\r\r");
	MOVLW       ?lstr31_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr31_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,364 :: 		}
L_end_Print_Reciept:
	RETURN      0
; end of _Print_Reciept

_Send_Message:

;config.h,365 :: 		void Send_Message(){
;config.h,367 :: 		Soft_Serial_println("AT+CMGF=1");
	MOVLW       ?lstr32_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr32_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,368 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Send_Message69:
	DECFSZ      R13, 1, 1
	BRA         L_Send_Message69
	DECFSZ      R12, 1, 1
	BRA         L_Send_Message69
	DECFSZ      R11, 1, 1
	BRA         L_Send_Message69
	NOP
	NOP
;config.h,369 :: 		Soft_Serial_print("AT+CMGS=\"");
	MOVLW       ?lstr33_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr33_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,370 :: 		Soft_Serial_print(number);
	MOVLW       _number+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_number+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,371 :: 		Soft_Serial_println("\"");
	MOVLW       ?lstr34_MyProject+0
	MOVWF       FARG_Soft_Serial_println_s+0 
	MOVLW       hi_addr(?lstr34_MyProject+0)
	MOVWF       FARG_Soft_Serial_println_s+1 
	CALL        _Soft_Serial_println+0, 0
;config.h,372 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Send_Message70:
	DECFSZ      R13, 1, 1
	BRA         L_Send_Message70
	DECFSZ      R12, 1, 1
	BRA         L_Send_Message70
	DECFSZ      R11, 1, 1
	BRA         L_Send_Message70
	NOP
	NOP
;config.h,374 :: 		Soft_Serial_print("Hello! Your Statement of Account for the month of ");
	MOVLW       ?lstr35_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr35_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,375 :: 		Soft_Serial_print(bill_Month);
	MOVLW       _bill_Month+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_bill_Month+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,376 :: 		Soft_Serial_print(" is now avaliable. The amount due is ");
	MOVLW       ?lstr36_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr36_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,377 :: 		Soft_Serial_print(total_Amount);
	MOVLW       _total_Amount+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_total_Amount+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,378 :: 		Soft_Serial_print(" pesos and the due date is ");
	MOVLW       ?lstr37_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr37_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,379 :: 		Soft_Serial_print(end_Month);
	MOVLW       _end_Month+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(_end_Month+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,380 :: 		Soft_Serial_print(". To avoid any issue, please make sure to pay before or on the due date.");
	MOVLW       ?lstr38_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr38_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,381 :: 		Soft_Serial_print(" You can visit the Endorm application for more information.");
	MOVLW       ?lstr39_MyProject+0
	MOVWF       FARG_Soft_Serial_print_s+0 
	MOVLW       hi_addr(?lstr39_MyProject+0)
	MOVWF       FARG_Soft_Serial_print_s+1 
	CALL        _Soft_Serial_print+0, 0
;config.h,382 :: 		SOFT_UART_WRITE(26);
	MOVLW       26
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;config.h,383 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Send_Message71:
	DECFSZ      R13, 1, 1
	BRA         L_Send_Message71
	DECFSZ      R12, 1, 1
	BRA         L_Send_Message71
	DECFSZ      R11, 1, 1
	BRA         L_Send_Message71
	NOP
	NOP
;config.h,384 :: 		}
L_end_Send_Message:
	RETURN      0
; end of _Send_Message

_main:

;MyProject.c,3 :: 		void main(){
;MyProject.c,4 :: 		setup();
	CALL        _setup+0, 0
;MyProject.c,6 :: 		while(1){
L_main72:
;MyProject.c,7 :: 		if (UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main74
;MyProject.c,8 :: 		uart_rd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;MyProject.c,9 :: 		if(uart_rd == '\r'){
	MOVF        R0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
;MyProject.c,10 :: 		State_Selector(output[0]);
	MOVF        _output+0, 0 
	MOVWF       FARG_State_Selector_s+0 
	CALL        _State_Selector+0, 0
;MyProject.c,11 :: 		}
	GOTO        L_main76
L_main75:
;MyProject.c,13 :: 		output[index] = uart_rd;
	MOVLW       _output+0
	ADDWF       _index+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_output+0)
	ADDWFC      _index+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _uart_rd+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,14 :: 		index++;
	INFSNZ      _index+0, 1 
	INCF        _index+1, 1 
;MyProject.c,15 :: 		}
L_main76:
;MyProject.c,16 :: 		}
L_main74:
;MyProject.c,17 :: 		if(state == 1){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main138
	MOVLW       1
	XORWF       _state+0, 0 
L__main138:
	BTFSS       STATUS+0, 2 
	GOTO        L_main77
;MyProject.c,18 :: 		timerCounter++;
	INFSNZ      _timerCounter+0, 1 
	INCF        _timerCounter+1, 1 
;MyProject.c,19 :: 		if(timerCounter == 50000){
	MOVF        _timerCounter+1, 0 
	XORLW       195
	BTFSS       STATUS+0, 2 
	GOTO        L__main139
	MOVLW       80
	XORWF       _timerCounter+0, 0 
L__main139:
	BTFSS       STATUS+0, 2 
	GOTO        L_main78
;MyProject.c,20 :: 		Bill_Counter();
	CALL        _Bill_Counter+0, 0
;MyProject.c,21 :: 		}
L_main78:
;MyProject.c,22 :: 		}
	GOTO        L_main79
L_main77:
;MyProject.c,24 :: 		else if(state == 2){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main140
	MOVLW       2
	XORWF       _state+0, 0 
L__main140:
	BTFSS       STATUS+0, 2 
	GOTO        L_main80
;MyProject.c,25 :: 		SOA_Seperator();
	CALL        _SOA_Seperator+0, 0
;MyProject.c,26 :: 		Print_SOA();
	CALL        _Print_SOA+0, 0
;MyProject.c,27 :: 		Reset();
	CALL        _Reset+0, 0
;MyProject.c,29 :: 		}
	GOTO        L_main81
L_main80:
;MyProject.c,31 :: 		else if(state == 3){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main141
	MOVLW       3
	XORWF       _state+0, 0 
L__main141:
	BTFSS       STATUS+0, 2 
	GOTO        L_main82
;MyProject.c,32 :: 		Reciept_Seperator();
	CALL        _Reciept_Seperator+0, 0
;MyProject.c,33 :: 		Print_Reciept();
	CALL        _Print_Reciept+0, 0
;MyProject.c,34 :: 		Reset();
	CALL        _Reset+0, 0
;MyProject.c,35 :: 		}
	GOTO        L_main83
L_main82:
;MyProject.c,37 :: 		else if(state == 4){
	MOVLW       0
	XORWF       _state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main142
	MOVLW       4
	XORWF       _state+0, 0 
L__main142:
	BTFSS       STATUS+0, 2 
	GOTO        L_main84
;MyProject.c,38 :: 		GSM_Seperator();
	CALL        _GSM_Seperator+0, 0
;MyProject.c,39 :: 		Send_Message();
	CALL        _Send_Message+0, 0
;MyProject.c,40 :: 		Reset();
	CALL        _Reset+0, 0
;MyProject.c,41 :: 		}
L_main84:
L_main83:
L_main81:
L_main79:
;MyProject.c,42 :: 		}
	GOTO        L_main72
;MyProject.c,43 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
