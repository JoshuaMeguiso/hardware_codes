#line 1 "D:/MikroC/All_Files/GSM_MODULE/GSM.c"

void serial_println(char *s){
 while(*s){
 UART1_WRITE(*s++);
 }
 UART1_WRITE(0X0D);
}
void serial_print(char *s){
 while(*s){
 UART1_WRITE(*s++);
 }
}
void main(){
 UART1_INIT(9600);
 delay_ms(40000);

 do{
 serial_println("AT+CMGF=1");
 delay_ms(2000);
 serial_print("AT+CMGS=\"");
 serial_print("09614680406");
 serial_print("\"\x0D");
 delay_ms(2000);
 serial_println("Testing from Joshua, Rachel, and Angelica");
 delay_ms(2000);
 UART1_WRITE(0x1A);
 delay_ms(14000);

 }while(1);
}
