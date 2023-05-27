#line 1 "D:/MikroC/HARDWARE_CODES/ULTRASONIC/ULTRASONIC_GSM.c"
#line 1 "d:/mikroc/hardware_codes/ultrasonic/config.h"


int i=1;
int time_taken;

void setup();
void timer();
void Serial_println(char *s);
void Serial_print(char *s);
void send_Message(char *num, char *mesg);

void setup(){
 TRISD = 0x00;
 TRISB.B5 = 0;
 LATB.B5 =0;
 TRISB.B6 = 1;
 LATB.B6 =0;
 T1CON = 0x10;

 UART1_INIT(9600);
 delay_ms(100);

 Serial_println("AT");
 delay_ms(500);
 Serial_println("AT+CREG=2");
 delay_ms(500);
 Serial_println("AT+CREG?");
 delay_ms(500);
 Serial_println("AT+CREG=1");
 delay_ms(500);
}

void timer(){

 TMR1H = 0;
 TMR1L = 0;


 LATB.F5 = 1;
 Delay_us(10);
 LATB.F5 = 0;

 while(!PORTB.F6);
 T1CON.F0 = 1;
 while(PORTB.F6);
 T1CON.F0 = 0;

 time_taken= (TMR1L | (TMR1H<<8));
 time_taken= time_taken/58.82;
}

void Serial_println(char *s){
 while(*s){
 UART1_WRITE(*s++);
 }
 UART1_WRITE(0X0D);
}

void Serial_print(char *s){
 while(*s){
 UART1_WRITE(*s++);
 }
}

void send_Message(char *num, char *mesg){
 Serial_println("AT+CMGF=1");
 delay_ms(500);
 Serial_print("AT+CMGS=\"");
 Serial_print(num);
 Serial_println("\"");
 delay_ms(500);
 Serial_print(mesg);
 UART1_WRITE(26);
 delay_ms(2000);
}
#line 3 "D:/MikroC/HARDWARE_CODES/ULTRASONIC/ULTRASONIC_GSM.c"
void main() {
 setup();

 while(1){
 timer();

 if(time_taken < 10){
 LATD = 0x01;
 send_Message("+639917927269", "Distance 1");
 }
 else if (time_taken > 9 && time_taken < 20){
 LATD = 0x02;
 send_Message("+639917927269", "Distance 2");
 }
 else if (time_taken > 19 && time_taken < 30){
 LATD = 0x04;
 send_Message("+639917927269", "Distance 3");
 }
 else{
 LATD = 0x08;
 send_Message("+639917927269", "Distance 4");
 }
 }
}
