#define maxLenght 50

int i=1;
int time_taken;

void setup();
void timer();
void Serial_println(char *s);
void Serial_print(char *s);
void send_Message(char *num, char *mesg);

void setup(){
  TRISD = 0x00;
  TRISB.B5 = 0; /* Set RB0 pin as a digital output pin */
  LATB.B5 =0;  /* Initially sets the RB0 pin as activ low */
  TRISB.B6 = 1; /* Set RB4 pin as a digital input pin */
  LATB.B6 =0;  /* Initially sets the RB4 pin as activ low */
  T1CON = 0x10; /* Set timer1 prescaler value to 1:2 prscale and disable timer1 */

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
  /* Initialize Timer1 register to zero */
  TMR1H = 0;
  TMR1L = 0;

  /* send 10us puls to triger pin of HC-SR04 from RB0 pin */
  LATB.F5 = 1;
  Delay_us(10);
  LATB.F5 = 0;

  while(!PORTB.F6);   /* wait till echo output signal goes high */
  T1CON.F0 = 1;    /* enable the Timer1 */
  while(PORTB.F6);  /* wait till echo output signal goes low */
  T1CON.F0 = 0; /*disable timer1 */

  time_taken= (TMR1L | (TMR1H<<8)); /*read the content of Timer1 registers */
  time_taken= time_taken/58.82;/*convert cm to ft */
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