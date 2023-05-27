#line 1 "D:/MikroC/HARDWARE_CODES/THERMAL_PRINTER/THERMAL_PRINTER.c"
int state = 0;

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

void main() {
 TRISC.RC0 = 0;
 TRISC.RC1 = 0;

 UART1_Init(9600);
 delay_ms(100);

 do{
 if(state == 0){
 LATC.RC0 = 0;
 LATC.RC1 = 0;
 delay_ms(1000);

 Serial_println("Hello World, this is output 1");

 state = 1;
 delay_ms(5000);
 }
 else if(state == 1){
 LATC.RC0 = 1;
 LATC.RC1 = 0;
 delay_ms(1000);

 Serial_print("Hello World, this is output 2");

 state = 0;
 delay_ms(5000);
 }
 }while(1);
}
