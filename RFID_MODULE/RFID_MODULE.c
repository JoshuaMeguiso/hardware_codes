#include"RC522.h"

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
void main()
{
  uchar status;
  uchar str[MAX_LEN];
  TRISB = 0B11111111;   // protection for ICSP TIME - W/ OUT MCLR - DON'T REMOVE THIS!
  delay1ms(500);        // protection for ICSP TIME - W/ OUT MCLR - DON'T REMOVE THIS!
  TRISA = 0B00000000;
  TRISB = 0B00000010;
  ADCON1=15;
  INTCON = 0B11000000;
  TRISC.F6=0;         //lcd back light
  PORTC.F6=0;
  Soft_SPI_Init();  // start the SPI library:
  Chip_Select = 1;  // SlaveSelect (SS) RFID reader
  MFRC522_Init();
  while (1)  // loop forever
  {
    //Find cards, return card type - Don't remove this sub
    status = MFRC522_Request(PICC_REQIDL, str);
    //Anti-collision, return card serial number 4 bytes
    status = MFRC522_Anticoll(str);
    memcpy(serNum, str, 5);

    if (status == MI_OK)   //if ther is a new card detected
    {
     SetFormatRDM630(void); // take serNum and format it and retern read
     Serial_print("ID: ");
     Serial_println(read);
    }
    else
    {
     MFRC522_Halt();                       // Command card into hibernation
     delay1ms(50);                       // wait for low consuption
    }

  }
}