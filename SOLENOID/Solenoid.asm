
_interrupt:

;Solenoid.c,1 :: 		void interrupt(){
;Solenoid.c,2 :: 		if(INTCON.INT0IF == 1){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Solenoid.c,3 :: 		PORTC.F0 = 0;
	BCF         PORTC+0, 0 
;Solenoid.c,4 :: 		delay_ms(3000);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_interrupt1:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt1
	DECFSZ      R12, 1, 1
	BRA         L_interrupt1
	DECFSZ      R11, 1, 1
	BRA         L_interrupt1
	NOP
	NOP
;Solenoid.c,5 :: 		PORTC.F0 = 1;
	BSF         PORTC+0, 0 
;Solenoid.c,6 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Solenoid.c,7 :: 		}
L_interrupt0:
;Solenoid.c,8 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;Solenoid.c,10 :: 		void main() {
;Solenoid.c,11 :: 		TRISB.RB0 = 1; //Set port as interrupt
	BSF         TRISB+0, 0 
;Solenoid.c,12 :: 		TRISC.RC0 = 0; //Set port as output
	BCF         TRISC+0, 0 
;Solenoid.c,14 :: 		PORTC.RC0 = 1;
	BSF         PORTC+0, 0 
;Solenoid.c,16 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Solenoid.c,17 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Solenoid.c,18 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Solenoid.c,20 :: 		while(1);
L_main2:
	GOTO        L_main2
;Solenoid.c,21 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
