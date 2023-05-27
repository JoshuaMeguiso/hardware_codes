#line 1 "D:/MikroC/HARDWARE_CODES/BILL_ACCEPTOR/MyProject.c"
#line 1 "d:/mikroc/hardware_codes/bill_acceptor/config.h"








int billCounter = 0;
int timerCounter = 0;
int state = 0;
int index = 0;
int i = 0;
int j = 0;
int counter = 0;
char output[ 255 ];
char uart_rd;


char tenant_Name[ 50 ];
char room_ID[ 50 ];
char period_Covered[ 50 ];
char room_Rate[ 50 ];
char water_Charge[ 50 ];
char previous_Reading[ 50 ];
char present_Reading[ 50 ];
char total_Consume[ 50 ];
char room_Consume[ 50 ];
char individual_Consume[ 50 ];
char total_Amount[ 50 ];


char bill_Month[ 50 ];
char start_Month[ 50 ];
char end_Month[ 50 ];
char paid_Amount[ 50 ];
char date_Paid[ 50 ];


char number[ 50 ];

void setup();
void printerConfig();
void Serial_println(char *s);
void Serial_print(char *s);
void Soft_Serial_println(char *s);
void Soft_Serial_print(char *s);
void Bill_Counter();
void State_Selector(char s);
void Reset();
void SOA_Seperator();
void Reciept_Seperator();
void GSM_Seperator();
void Print_SOA();
void Print_Reciept();
void Send_Message();

void interrupt(){
 if(INTCON.INT0IF == 1){
 state = 1;
 timerCounter = 0;
 billCounter++;

 INTCON.INT0IF = 0;
 }
}

void setup(){
 TRISB.RB0 = 1;
 TRISD.RD0 = 0;
 TRISD.RC1 = 0;
  LATD.RD0  = 1;
  LATD.RD1  = 0;
 UART1_INIT( 9600 );
 SOFT_UART_INIT(&PORTC,  2 ,  1 ,  9600 , 0);
 delay_ms(100);


 Soft_Serial_println("AT");
 delay_ms(500);
 Soft_Serial_println("AT+CREG=2");
 delay_ms(500);
 Soft_Serial_println("AT+CREG?");
 delay_ms(500);
 Soft_Serial_println("AT+CREG=1");
 delay_ms(500);
 Reset();

 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;
 INTCON.GIE = 1;
}
void printerConfig(){

 SOFT_UART_WRITE(0x1C);
 SOFT_UART_WRITE(0x2E);


 SOFT_UART_WRITE(0x1D);
 SOFT_UART_WRITE(0x4C);
 SOFT_UART_WRITE(0x46);
 SOFT_UART_WRITE(0x00);
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
void Soft_Serial_println(char *s){
 while(*s){
 SOFT_UART_WRITE(*s++);
 }
 SOFT_UART_WRITE(0X0D);
}
void Soft_Serial_print(char *s){
 while(*s){
 SOFT_UART_WRITE(*s++);
 }
}
void Bill_Counter(){
 if(billCounter == 20){
 UART1_WRITE('1');
 }
 else if(billCounter == 50){
 UART1_WRITE('2');
 }
 else if(billCounter == 100){
 UART1_WRITE('3');
 }
 else if(billCounter == 4){
 UART1_WRITE('4');
 }
 else if(billCounter == 5){
 UART1_WRITE('5');
 }
 else if(billCounter == 6){
 UART1_WRITE('6');
 }
 timerCounter = 0;
 billCounter = 0;
 state = 0;
}

void State_Selector(char s){
 if(s == '1'){
 state = 2;
  LATD.RD0  = 0;
  LATD.RD1  = 0;
 delay_ms(50);
 }
 if(s == '2'){
 state = 3;
  LATD.RD0  = 0;
  LATD.RD1  = 0;
 delay_ms(50);
 }
 if(s == '3'){
 state = 4;
  LATD.RD0  = 1;
  LATD.RD1  = 0;
 delay_ms(50);
 }
}
void Reset(){
 memset(output, 0,  255 );
 memset(tenant_Name, 0,  50 );
 memset(room_ID, 0,  50 );
 memset(period_Covered, 0,  50 );
 memset(room_Rate, 0,  50 );
 memset(water_Charge, 0,  50 );
 memset(previous_Reading, 0,  50 );
 memset(present_Reading, 0,  50 );
 memset(total_Consume, 0,  50 );
 memset(room_Consume, 0,  50 );
 memset(individual_Consume, 0,  50 );
 memset(total_Amount, 0,  50 );
 memset(bill_Month, 0,  50 );
 memset(start_Month, 0,  50 );
 memset(end_Month, 0,  50 );
 memset(paid_Amount, 0,  50 );
 memset(date_Paid, 0,  50 );
 memset(number, 0,  50 );

 counter = 0;
 i = 0;
 index = 0;
 state = 0;
}
void SOA_Seperator(){
 while(i <= index){
 if(output[i] == '|'){
 counter++;
 j = 0;
 }
 else{
 if(counter == 1){
 tenant_Name[j] = output[i];
 }
 if(counter == 2){
 room_ID[j] = output[i];
 }
 if(counter == 3){
 period_Covered[j] = output[i];
 }
 if(counter == 4){
 room_Rate[j] = output[i];
 }
 if(counter == 5){
 water_Charge[j] = output[i];
 }
 if(counter == 6){
 previous_Reading[j] = output[i];
 }
 if(counter == 7){
 present_Reading[j] = output[i];
 }
 if(counter == 8){
 total_Consume[j] = output[i];
 }
 if(counter == 9){
 room_Consume[j] = output[i];
 }
 if(counter == 10){
 individual_Consume[j] = output[i];
 }
 if(counter == 11){
 total_Amount[j] = output[i];
 }
 j++;
 }
 i++;
 }
}
void Reciept_Seperator(){
 while(i <= index){
 if(output[i] == '|'){
 counter++;
 j = 0;
 }
 else{
 if(counter == 1){
 tenant_Name[j] = output[i];
 }
 if(counter == 2){
 room_ID[j] = output[i];
 }
 if(counter == 3){
 bill_Month[j] = output[i];
 }
 if(counter == 4){
 start_Month[j] = output[i];
 }
 if(counter == 5){
 end_Month[j] = output[i];
 }
 if(counter == 6){
 room_Rate[j] = output[i];
 }
 if(counter == 7){
 water_Charge[j] = output[i];
 }
 if(counter == 8){
 individual_Consume[j] = output[i];
 }
 if(counter == 9){
 total_Amount[j] = output[i];
 }
 if(counter == 10){
 paid_Amount[j] = output[i];
 }
 if(counter == 11){
 date_Paid[j] = output[i];
 }
 j++;
 }
 i++;
 }
}
void GSM_Seperator(){
 while(i <= index){
 if(output[i] == '|'){
 counter++;
 j = 0;
 }
 else{
 if(counter == 1){
 bill_Month[j] = output[i];
 }
 if(counter == 2){
 total_Amount[j] = output[i];
 }
 if(counter == 3){
 end_Month[j] = output[i];
 }
 if(counter == 4){
 number[j] = output[i];
 }
 j++;
 }
 i++;
 }
}
void Print_SOA(){
 printerConfig();
 Soft_Serial_print("\rTenant Name: ");
 Soft_Serial_println(tenant_Name);
 Soft_Serial_print("Room ID: ");
 Soft_Serial_println(room_ID);
 Soft_Serial_print("Period Covered: ");
 Soft_Serial_println(period_Covered);
 Soft_Serial_print("Room Rate: P ");
 Soft_Serial_println(room_Rate);
 Soft_Serial_print("Water Charge: P ");
 Soft_Serial_println(water_Charge);
 Soft_Serial_print("Previous Reading: ");
 Soft_Serial_print(previous_Reading);
 Soft_Serial_println(" KWH");
 Soft_Serial_print("Present Reading: ");
 Soft_Serial_print(present_Reading);
 Soft_Serial_println(" KWH");
 Soft_Serial_print("Total Consume: ");
 Soft_Serial_print(total_Consume);
 Soft_Serial_println(" KWH");
 Soft_Serial_print("Room Amount: P ");
 Soft_Serial_println(room_Consume);
 Soft_Serial_print("Indiv. Amount: P ");
 Soft_Serial_println(individual_Consume);
 Soft_Serial_print("Total Amount: P ");
 Soft_Serial_println(total_Amount);
 Soft_Serial_print("\r\r\r\r");
}

void Print_Reciept(){
 printerConfig();
 Soft_Serial_print("\rTenant Name: ");
 Soft_Serial_println(tenant_Name);
 Soft_Serial_print("Room ID: ");
 Soft_Serial_println(room_ID);
 Soft_Serial_print("Bill Month: ");
 Soft_Serial_println(bill_Month);
 Soft_Serial_print("Period Covered:");
 Soft_Serial_print(start_Month);
 Soft_Serial_print(" - ");
 Soft_Serial_println(end_Month);
 Soft_Serial_print("Room Rate: P ");
 Soft_Serial_println(room_Rate);
 Soft_Serial_print("Water Charge: P ");
 Soft_Serial_println(water_Charge);
 Soft_Serial_print("Individual Consume: P ");
 Soft_Serial_println(individual_Consume);
 Soft_Serial_print("Due Amount: P ");
 Soft_Serial_println(total_Amount);
 Soft_Serial_print("Paid Amount: P ");
 Soft_Serial_println(paid_Amount);
 Soft_Serial_print("Date Paid: ");
 Soft_Serial_println(date_Paid);
 Soft_Serial_print("\r\r\r\r");
}
void Send_Message(){

 Soft_Serial_println("AT+CMGF=1");
 delay_ms(1000);
 Soft_Serial_print("AT+CMGS=\"");
 Soft_Serial_print(number);
 Soft_Serial_println("\"");
 delay_ms(1000);

 Soft_Serial_print("Hello! Your Statement of Account for the month of ");
 Soft_Serial_print(bill_Month);
 Soft_Serial_print(" is now avaliable. The amount due is ");
 Soft_Serial_print(total_Amount);
 Soft_Serial_print(" pesos and the due date is ");
 Soft_Serial_print(end_Month);
 Soft_Serial_print(". To avoid any issue, please make sure to pay before or on the due date.");
 Soft_Serial_print(" You can visit the Endorm application for more information.");
 SOFT_UART_WRITE(26);
 delay_ms(1000);
}
#line 3 "D:/MikroC/HARDWARE_CODES/BILL_ACCEPTOR/MyProject.c"
void main(){
 setup();

 while(1){
 if (UART1_Data_Ready()){
 uart_rd = UART1_Read();
 if(uart_rd == '\r'){
 State_Selector(output[0]);
 }
 else{
 output[index] = uart_rd;
 index++;
 }
 }
 if(state == 1){
 timerCounter++;
 if(timerCounter == 50000){
 Bill_Counter();
 }
 }

 else if(state == 2){
 SOA_Seperator();
 Print_SOA();
 Reset();

 }

 else if(state == 3){
 Reciept_Seperator();
 Print_Reciept();
 Reset();
 }

 else if(state == 4){
 GSM_Seperator();
 Send_Message();
 Reset();
 }
 }
}
