#line 1 "D:/MikroC/All_Files/SOLENOID/Solenoid.c"
void interrupt(){
 if(INTCON.INT0IF == 1){
 PORTC.F0 = 0;
 delay_ms(3000);
 PORTC.F0 = 1;
 INTCON.INT0IF = 0;
 }
}

void main() {
 TRISB.RB0 = 1;
 TRISC.RC0 = 0;

 PORTC.RC0 = 1;

 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;
 INTCON.GIE = 1;

 while(1);
}
