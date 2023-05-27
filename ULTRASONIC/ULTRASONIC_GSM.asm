
_setup:

;config.h,12 :: 		void setup(){
;config.h,13 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;config.h,14 :: 		TRISB.B5 = 0; /* Set RB0 pin as a digital output pin */
	BCF         TRISB+0, 5 
;config.h,15 :: 		LATB.B5 =0;  /* Initially sets the RB0 pin as activ low */
	BCF         LATB+0, 5 
;config.h,16 :: 		TRISB.B6 = 1; /* Set RB4 pin as a digital input pin */
	BSF         TRISB+0, 6 
;config.h,17 :: 		LATB.B6 =0;  /* Initially sets the RB4 pin as activ low */
	BCF         LATB+0, 6 
;config.h,18 :: 		T1CON = 0x10; /* Set timer1 prescaler value to 1:2 prscale and disable timer1 */
	MOVLW       16
	MOVWF       T1CON+0 
;config.h,20 :: 		UART1_INIT(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;config.h,21 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_setup0:
	DECFSZ      R13, 1, 1
	BRA         L_setup0
	DECFSZ      R12, 1, 1
	BRA         L_setup0
	NOP
	NOP
;config.h,23 :: 		Serial_println("AT");
	MOVLW       ?lstr1_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr1_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,24 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup1:
	DECFSZ      R13, 1, 1
	BRA         L_setup1
	DECFSZ      R12, 1, 1
	BRA         L_setup1
	DECFSZ      R11, 1, 1
	BRA         L_setup1
	NOP
	NOP
;config.h,25 :: 		Serial_println("AT+CREG=2");
	MOVLW       ?lstr2_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr2_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,26 :: 		delay_ms(500);
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
;config.h,27 :: 		Serial_println("AT+CREG?");
	MOVLW       ?lstr3_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr3_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,28 :: 		delay_ms(500);
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
;config.h,29 :: 		Serial_println("AT+CREG=1");
	MOVLW       ?lstr4_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr4_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,30 :: 		delay_ms(500);
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
;config.h,31 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_timer:

;config.h,33 :: 		void timer(){
;config.h,35 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;config.h,36 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;config.h,39 :: 		LATB.F5 = 1;
	BSF         LATB+0, 5 
;config.h,40 :: 		Delay_us(10);
	MOVLW       3
	MOVWF       R13, 0
L_timer5:
	DECFSZ      R13, 1, 1
	BRA         L_timer5
;config.h,41 :: 		LATB.F5 = 0;
	BCF         LATB+0, 5 
;config.h,43 :: 		while(!PORTB.F6);   /* wait till echo output signal goes high */
L_timer6:
	BTFSC       PORTB+0, 6 
	GOTO        L_timer7
	GOTO        L_timer6
L_timer7:
;config.h,44 :: 		T1CON.F0 = 1;    /* enable the Timer1 */
	BSF         T1CON+0, 0 
;config.h,45 :: 		while(PORTB.F6);  /* wait till echo output signal goes low */
L_timer8:
	BTFSS       PORTB+0, 6 
	GOTO        L_timer9
	GOTO        L_timer8
L_timer9:
;config.h,46 :: 		T1CON.F0 = 0; /*disable timer1 */
	BCF         T1CON+0, 0 
;config.h,48 :: 		time_taken= (TMR1L | (TMR1H<<8)); /*read the content of Timer1 registers */
	MOVF        TMR1H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        TMR1L+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _time_taken+0 
	MOVF        R1, 0 
	MOVWF       _time_taken+1 
;config.h,49 :: 		time_taken= time_taken/58.82;/*convert cm to ft */
	CALL        _int2double+0, 0
	MOVLW       174
	MOVWF       R4 
	MOVLW       71
	MOVWF       R5 
	MOVLW       107
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _time_taken+0 
	MOVF        R1, 0 
	MOVWF       _time_taken+1 
;config.h,50 :: 		}
L_end_timer:
	RETURN      0
; end of _timer

_Serial_println:

;config.h,52 :: 		void Serial_println(char *s){
;config.h,53 :: 		while(*s){
L_Serial_println10:
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_println11
;config.h,54 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_println_s+0, 1 
	INCF        FARG_Serial_println_s+1, 1 
;config.h,55 :: 		}
	GOTO        L_Serial_println10
L_Serial_println11:
;config.h,56 :: 		UART1_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,57 :: 		}
L_end_Serial_println:
	RETURN      0
; end of _Serial_println

_Serial_print:

;config.h,59 :: 		void Serial_print(char *s){
;config.h,60 :: 		while(*s){
L_Serial_print12:
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_print13
;config.h,61 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_print_s+0, 1 
	INCF        FARG_Serial_print_s+1, 1 
;config.h,62 :: 		}
	GOTO        L_Serial_print12
L_Serial_print13:
;config.h,63 :: 		}
L_end_Serial_print:
	RETURN      0
; end of _Serial_print

_send_Message:

;config.h,65 :: 		void send_Message(char *num, char *mesg){
;config.h,66 :: 		Serial_println("AT+CMGF=1");
	MOVLW       ?lstr5_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr5_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,67 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_send_Message14:
	DECFSZ      R13, 1, 1
	BRA         L_send_Message14
	DECFSZ      R12, 1, 1
	BRA         L_send_Message14
	DECFSZ      R11, 1, 1
	BRA         L_send_Message14
	NOP
	NOP
;config.h,68 :: 		Serial_print("AT+CMGS=\"");
	MOVLW       ?lstr6_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_print_s+0 
	MOVLW       hi_addr(?lstr6_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_print_s+1 
	CALL        _Serial_print+0, 0
;config.h,69 :: 		Serial_print(num);
	MOVF        FARG_send_Message_num+0, 0 
	MOVWF       FARG_Serial_print_s+0 
	MOVF        FARG_send_Message_num+1, 0 
	MOVWF       FARG_Serial_print_s+1 
	CALL        _Serial_print+0, 0
;config.h,70 :: 		Serial_println("\"");
	MOVLW       ?lstr7_ULTRASONIC_GSM+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(?lstr7_ULTRASONIC_GSM+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;config.h,71 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_send_Message15:
	DECFSZ      R13, 1, 1
	BRA         L_send_Message15
	DECFSZ      R12, 1, 1
	BRA         L_send_Message15
	DECFSZ      R11, 1, 1
	BRA         L_send_Message15
	NOP
	NOP
;config.h,72 :: 		Serial_print(mesg);
	MOVF        FARG_send_Message_mesg+0, 0 
	MOVWF       FARG_Serial_print_s+0 
	MOVF        FARG_send_Message_mesg+1, 0 
	MOVWF       FARG_Serial_print_s+1 
	CALL        _Serial_print+0, 0
;config.h,73 :: 		UART1_WRITE(26);
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;config.h,74 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_send_Message16:
	DECFSZ      R13, 1, 1
	BRA         L_send_Message16
	DECFSZ      R12, 1, 1
	BRA         L_send_Message16
	DECFSZ      R11, 1, 1
	BRA         L_send_Message16
	NOP
	NOP
;config.h,75 :: 		}
L_end_send_Message:
	RETURN      0
; end of _send_Message

_main:

;ULTRASONIC_GSM.c,3 :: 		void main() {
;ULTRASONIC_GSM.c,4 :: 		setup();
	CALL        _setup+0, 0
;ULTRASONIC_GSM.c,6 :: 		while(1){
L_main17:
;ULTRASONIC_GSM.c,7 :: 		timer();
	CALL        _timer+0, 0
;ULTRASONIC_GSM.c,9 :: 		if(time_taken < 10){
	MOVLW       128
	XORWF       _time_taken+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       10
	SUBWF       _time_taken+0, 0 
L__main37:
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
;ULTRASONIC_GSM.c,10 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;ULTRASONIC_GSM.c,11 :: 		send_Message("+639917927269", "Distance 1");
	MOVLW       ?lstr8_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_num+0 
	MOVLW       hi_addr(?lstr8_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_num+1 
	MOVLW       ?lstr9_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_mesg+0 
	MOVLW       hi_addr(?lstr9_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_mesg+1 
	CALL        _send_Message+0, 0
;ULTRASONIC_GSM.c,12 :: 		}
	GOTO        L_main20
L_main19:
;ULTRASONIC_GSM.c,13 :: 		else if (time_taken > 9 && time_taken < 20){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _time_taken+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        _time_taken+0, 0 
	SUBLW       9
L__main38:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVLW       128
	XORWF       _time_taken+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       20
	SUBWF       _time_taken+0, 0 
L__main39:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
L__main30:
;ULTRASONIC_GSM.c,14 :: 		LATD = 0x02;
	MOVLW       2
	MOVWF       LATD+0 
;ULTRASONIC_GSM.c,15 :: 		send_Message("+639917927269", "Distance 2");
	MOVLW       ?lstr10_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_num+0 
	MOVLW       hi_addr(?lstr10_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_num+1 
	MOVLW       ?lstr11_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_mesg+0 
	MOVLW       hi_addr(?lstr11_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_mesg+1 
	CALL        _send_Message+0, 0
;ULTRASONIC_GSM.c,16 :: 		}
	GOTO        L_main24
L_main23:
;ULTRASONIC_GSM.c,17 :: 		else if (time_taken > 19 && time_taken < 30){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _time_taken+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVF        _time_taken+0, 0 
	SUBLW       19
L__main40:
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
	MOVLW       128
	XORWF       _time_taken+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVLW       30
	SUBWF       _time_taken+0, 0 
L__main41:
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
L__main29:
;ULTRASONIC_GSM.c,18 :: 		LATD = 0x04;
	MOVLW       4
	MOVWF       LATD+0 
;ULTRASONIC_GSM.c,19 :: 		send_Message("+639917927269", "Distance 3");
	MOVLW       ?lstr12_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_num+0 
	MOVLW       hi_addr(?lstr12_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_num+1 
	MOVLW       ?lstr13_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_mesg+0 
	MOVLW       hi_addr(?lstr13_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_mesg+1 
	CALL        _send_Message+0, 0
;ULTRASONIC_GSM.c,20 :: 		}
	GOTO        L_main28
L_main27:
;ULTRASONIC_GSM.c,22 :: 		LATD = 0x08;
	MOVLW       8
	MOVWF       LATD+0 
;ULTRASONIC_GSM.c,23 :: 		send_Message("+639917927269", "Distance 4");
	MOVLW       ?lstr14_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_num+0 
	MOVLW       hi_addr(?lstr14_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_num+1 
	MOVLW       ?lstr15_ULTRASONIC_GSM+0
	MOVWF       FARG_send_Message_mesg+0 
	MOVLW       hi_addr(?lstr15_ULTRASONIC_GSM+0)
	MOVWF       FARG_send_Message_mesg+1 
	CALL        _send_Message+0, 0
;ULTRASONIC_GSM.c,24 :: 		}
L_main28:
L_main24:
L_main20:
;ULTRASONIC_GSM.c,25 :: 		}
	GOTO        L_main17
;ULTRASONIC_GSM.c,26 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
