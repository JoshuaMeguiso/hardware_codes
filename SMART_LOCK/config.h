#define output 0
#define input 1
#define setButton TRISB.RB0
#define setInputRB1 TRISB.RB1
#define setInputRB2 TRISB.RB2
#define setOutputRD0 TRISD.RD0
#define setOutputRD1 TRISD.RD1
#define setOutputRD2 TRISD.RD2
#define success_LED LATD.RD0
#define failed_LED LATD.RD1
#define doorSignal LATD.RD2
#define signalA PORTB.RB1
#define signalB PORTB.RB2
#define ON 1
#define OFF 0
#define OPEN 0
#define CLOSE 1


void setup(){
  //init ports
  setInputRB1 = input;
  setInputRB2 = input;
  setOutputRD0 = output;
  setOutputRD1 = output;
  setOutputRD2 = output;
}
