#line 1 "D:/MikroC/HARDWARE_CODES/SMART_LOCK/Smart_Lock.c"
#line 1 "d:/mikroc/hardware_codes/smart_lock/config.h"
#line 20 "d:/mikroc/hardware_codes/smart_lock/config.h"
void setup(){

  TRISB.RB1  =  1 ;
  TRISB.RB2  =  1 ;
  TRISD.RD0  =  0 ;
  TRISD.RD1  =  0 ;
  TRISD.RD2  =  0 ;
}
#line 3 "D:/MikroC/HARDWARE_CODES/SMART_LOCK/Smart_Lock.c"
void main() {
 setup();

 while(1){

 if( PORTB.RB1  == 0 &&  PORTB.RB2  == 1){
  LATD.RD0  =  1 ;
  LATD.RD1  =  0 ;
  LATD.RD2  =  0 ;
 }
 else if( PORTB.RB1  == 1 &&  PORTB.RB2  == 0){
  LATD.RD1  =  1 ;
  LATD.RD0  =  0 ;
  LATD.RD2  =  1 ;
 }
 else{
  LATD.RD0  =  0 ;
  LATD.RD1  =  0 ;
  LATD.RD2  =  1 ;
 }
 }




}
