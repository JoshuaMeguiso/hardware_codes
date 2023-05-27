#line 1 "D:/MikroC/HARDWARE_CODES/FROI_CODE/Serial_PIC.c"
char uart_rd;

void main() {
 UART1_INIT(9600);
 delay_ms(100);

 while(1){
 if(UART1_Data_Ready()){
 uart_rd = UART1_READ();
 UART1_WRITE(uart_rd);
 }
 }
}
