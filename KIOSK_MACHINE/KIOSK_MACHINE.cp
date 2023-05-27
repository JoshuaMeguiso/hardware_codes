#line 1 "D:/MikroC/All_Files/KIOSK_MACHINE/KIOSK_MACHINE.c"
char output = 0;
char stx[3];
char text[255];
int stx_Counter = 0;
int state = 0;

void INIT_SOFT_UART(){
 char error;

 error = SOFT_UART_INIT(&PORTC, 2, 1, 9600, 0);
}
void INIT_PORTS(){
 TRISC.RC4 = 0;
 TRISC.RC5 = 0;
}
void main() {
 INIT_PORTS();
 INIT_SOFT_UART();
 UART1_Init(9600);
 delay_ms(100);

 do{
 if(UART1_DATA_READY()){
 output = UART1_READ();

 if(output == 'T' && stx_Counter < 3){
 stx[stx_Counter] = output;
 }
 else if(output == 'R' && stx_Counter < 3){
 stx[stx_Counter] = output;
 }
 else if(output == 'G' && stx_Counter < 3){
 stx[stx_Counter] = output;
 }
 else{
 if(output == 0X1A){
 stx[0] = 0;
 stx[1] = 0;
 stx[2] = 0;
 stx_Counter = stx_Counter - stx_Counter - 1;
 state = 0;
 }
 if(stx[0] == 'R' && stx[1] == 'R' && stx[2] == 'R' && state == 0){
 LATC.RC4 = 0;
 LATC.RC5 = 0;
 state = 1;
 }
 if(stx[0] == 'T' && stx[1] == 'T' && stx[2] == 'T' && state == 0){
 LATC.RC4 = 1;
 LATC.RC5 = 0;
 state = 2;
 }
 if(stx[0] == 'G' && stx[1] == 'G' && stx[2] == 'G' && state == 0){
 LATC.RC4 = 0;
 LATC.RC5 = 1;
 state = 3;
 }
 if(state != 0){
 SOFT_UART_WRITE(output);
 }
 }
 stx_Counter++;
 }
 }while(1);
}
