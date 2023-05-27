char uart_rd;
char number[] = "+639614680406"
char message[] = "Hello World"

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
  UART1_INIT(9600);
  delay_ms(100);
  
  while(1){
    Serial_println("AT");
    delay_ms(1000);
    Serial_println("AT+CREG=2");
    delay_ms(1000);
    Serial_println("AT+CREG?");
    delay_ms(1000);
    Serial_println("AT+CREG=1");
    delay_ms(1000);
    Serial_println("AT+CMGF=1");
    delay_ms(1000);
    Serial_print("AT+CMGS=\"");
    Serial_print(number);
    Serial_println("\"");
    delay_ms(500);
    Serial_print(message);
    UART_WRITE(26);
  }
}