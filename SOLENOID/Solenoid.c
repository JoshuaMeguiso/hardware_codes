void interrupt(){
  if(INTCON.INT0IF == 1){
    PORTC.F0 = 0;
    delay_ms(3000);
    PORTC.F0 = 1;
    INTCON.INT0IF = 0;
  }
}

void main() {
  TRISB.RB0 = 1; //Set port as interrupt
  TRISC.RC0 = 0; //Set port as output
  
  PORTC.RC0 = 1;
  
  INTCON.INT0IF = 0;
  INTCON.INT0IE = 1;
  INTCON.GIE = 1;
  
  while(1);
}