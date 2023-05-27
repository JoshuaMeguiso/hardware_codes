
_setup:

;config.h,20 :: 		void setup(){
;config.h,22 :: 		setInputRB1 = input;
	BSF         TRISB+0, 1 
;config.h,23 :: 		setInputRB2 = input;
	BSF         TRISB+0, 2 
;config.h,24 :: 		setOutputRD0 = output;
	BCF         TRISD+0, 0 
;config.h,25 :: 		setOutputRD1 = output;
	BCF         TRISD+0, 1 
;config.h,26 :: 		setOutputRD2 = output;
	BCF         TRISD+0, 2 
;config.h,27 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_main:

;Smart_Lock.c,3 :: 		void main() {
;Smart_Lock.c,4 :: 		setup();
	CALL        _setup+0, 0
;Smart_Lock.c,6 :: 		while(1){
L_main0:
;Smart_Lock.c,8 :: 		if(signalA == 0 && signalB == 1){           //SUCCESS
	BTFSC       PORTB+0, 1 
	GOTO        L_main4
	BTFSS       PORTB+0, 2 
	GOTO        L_main4
L__main11:
;Smart_Lock.c,9 :: 		success_LED = ON;
	BSF         LATD+0, 0 
;Smart_Lock.c,10 :: 		failed_LED = OFF;
	BCF         LATD+0, 1 
;Smart_Lock.c,11 :: 		doorSignal = OPEN;
	BCF         LATD+0, 2 
;Smart_Lock.c,12 :: 		}
	GOTO        L_main5
L_main4:
;Smart_Lock.c,13 :: 		else if(signalA == 1 && signalB == 0){      //FAILED
	BTFSS       PORTB+0, 1 
	GOTO        L_main8
	BTFSC       PORTB+0, 2 
	GOTO        L_main8
L__main10:
;Smart_Lock.c,14 :: 		failed_LED = ON;
	BSF         LATD+0, 1 
;Smart_Lock.c,15 :: 		success_LED = OFF;
	BCF         LATD+0, 0 
;Smart_Lock.c,16 :: 		doorSignal = CLOSE;
	BSF         LATD+0, 2 
;Smart_Lock.c,17 :: 		}
	GOTO        L_main9
L_main8:
;Smart_Lock.c,19 :: 		success_LED = OFF;
	BCF         LATD+0, 0 
;Smart_Lock.c,20 :: 		failed_LED = OFF;
	BCF         LATD+0, 1 
;Smart_Lock.c,21 :: 		doorSignal = CLOSE;
	BSF         LATD+0, 2 
;Smart_Lock.c,22 :: 		}
L_main9:
L_main5:
;Smart_Lock.c,23 :: 		}
	GOTO        L_main0
;Smart_Lock.c,28 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
