#define BAUD_RATE 9600
#define SOFT_TX 1
#define SOFT_RX 2
#define maxLength 255
#define minLenght 50
#define A LATD.RD0
#define B LATD.RD1

int billCounter = 0;
int timerCounter = 0;
int state = 0;
int index = 0;
int i = 0;
int j = 0;
int counter = 0;
char output[maxLength];
char uart_rd;

//SOA Char Arrays
char tenant_Name[minLenght];
char room_ID[minLenght];
char period_Covered[minLenght];
char room_Rate[minLenght];
char water_Charge[minLenght];
char previous_Reading[minLenght];
char present_Reading[minLenght];
char total_Consume[minLenght];
char room_Consume[minLenght];
char individual_Consume[minLenght];
char total_Amount[minLenght];

//Reciept Char Arrays
char bill_Month[minLenght];
char start_Month[minLenght];
char end_Month[minLenght];
char paid_Amount[minLenght];
char date_Paid[minLenght];

//GSM Char Arrays
char number[minLenght];

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
    billCounter++;  //increment bill

    INTCON.INT0IF = 0;  //reset to 0
  }
}

void setup(){
  TRISB.RB0 = 1;    //init port pulse
  TRISD.RD0 = 0;
  TRISD.RC1 = 0;
  A = 1;
  B = 0;
  UART1_INIT(BAUD_RATE); //init hardware uart
  SOFT_UART_INIT(&PORTC, SOFT_RX, SOFT_TX, BAUD_RATE, 0);
  delay_ms(100);    //to stabilized the ports
  
  //initialize GSM
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
  //Language
  SOFT_UART_WRITE(0x1C);
  SOFT_UART_WRITE(0x2E);

  //Left Margin
  SOFT_UART_WRITE(0x1D);
  SOFT_UART_WRITE(0x4C);
  SOFT_UART_WRITE(0x46); //Length Value
  SOFT_UART_WRITE(0x00); //Length Value
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
    state = 2;  //Thermal Printer (SOA)
    A = 0;
    B = 0;
    delay_ms(50);
  }
  if(s == '2'){
    state = 3;  //Thermal Printer (Reciept)
    A = 0;
    B = 0;
    delay_ms(50);
  }
  if(s == '3'){
    state = 4;  //GSM
    A = 1;
    B = 0;
    delay_ms(50);
  }
}
void Reset(){
  memset(output, 0, maxLength);
  memset(tenant_Name, 0, minLenght);
  memset(room_ID, 0, minLenght);
  memset(period_Covered, 0, minLenght);
  memset(room_Rate, 0, minLenght);
  memset(water_Charge, 0, minLenght);
  memset(previous_Reading, 0, minLenght);
  memset(present_Reading, 0, minLenght);
  memset(total_Consume, 0, minLenght);
  memset(room_Consume, 0, minLenght);
  memset(individual_Consume, 0, minLenght);
  memset(total_Amount, 0, minLenght);
  memset(bill_Month, 0, minLenght);
  memset(start_Month, 0, minLenght);
  memset(end_Month, 0, minLenght);
  memset(paid_Amount, 0, minLenght);
  memset(date_Paid, 0, minLenght);
  memset(number, 0, minLenght);
  
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
  //AT Commands
  Soft_Serial_println("AT+CMGF=1");
  delay_ms(1000);
  Soft_Serial_print("AT+CMGS=\"");
  Soft_Serial_print(number);
  Soft_Serial_println("\"");
  delay_ms(1000);
  //Message
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