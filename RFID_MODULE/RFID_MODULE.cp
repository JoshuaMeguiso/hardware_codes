#line 1 "D:/MikroC/HARDWARE_CODES/RFID_MODULE/RFID_MODULE.c"
#line 1 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
#line 51 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
sbit Chip_Select at RA0_bit;
sbit SoftSpi_SDI at RA3_bit;
sbit SoftSpi_SDO at RA2_bit;
sbit SoftSpi_CLK at RA1_bit;

sbit Chip_Select_Direction at TRISA0_bit;
sbit SoftSpi_SDI_Direction at TRISA3_bit;
sbit SoftSpi_SDO_Direction at TRISA2_bit;
sbit SoftSpi_CLK_Direction at TRISA1_bit;
#line 182 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  serNum[5];

 unsigned char  writeData[16]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100};
 unsigned char  moneyConsume = 18 ;
 unsigned char  moneyAdd = 10 ;

 unsigned char  sectorKeyA[16][16] = {{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},
 {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},

 {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, };

 unsigned char  sectorNewKeyA[16][16] = {{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},
 {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xff,0x07,0x80,0x69, 0x19,0x84,0x07,0x15,0x76,0x14},



 {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xff,0x07,0x80,0x69, 0x19,0x33,0x07,0x15,0x34,0x14}, };

 unsigned char  old_led = 0;
const  unsigned short  inputStringLen = 1;
 unsigned char  inputString[inputStringLen] = "";
 bit  stringComplete;
 unsigned short  bytevar3, bytevar4, Output1, receiv_cnt = 0;
 unsigned short  receive[8];
 unsigned char  bytevar1, bytevar2 = 0;
 unsigned char  uchar_send[8];
 unsigned char  read[10];

void delay1ms( unsigned int  delayTime);


void SetFormatRDM630(void);
void MFRC522_Init(void);
void TimeOut1(void);
 unsigned char  Separate_hexP10( unsigned char  val);
 unsigned char  Separate_hexP1( unsigned char  val);
void Write_MFRC522( unsigned char  addr,  unsigned char  val);
 unsigned char  Read_MFRC522( unsigned char  addr);
void SetBitMask( unsigned char  reg,  unsigned char  mask);
void ClearBitMask( unsigned char  reg,  unsigned char  mask);
void AntennaOn(void);
void AntennaOff(void);
void MFRC522_Reset(void);
void MFRC522_Init(void);
 unsigned char  MFRC522_Request( unsigned char  reqMode,  unsigned char  *TagType);
 unsigned char  MFRC522_ToCard( unsigned char  command,  unsigned char  *sendData,  unsigned char  sendLen,  unsigned char  *backData, unsigned int *backLen);
 unsigned char  MFRC522_Anticoll( unsigned char  *serNum);
void CalulateCRC( unsigned char  *pIndata,  unsigned char  len,  unsigned char  *pOutData);
 unsigned char  MFRC522_SelectTag( unsigned char  *serNum);
 unsigned char  MFRC522_Auth( unsigned char  authMode,  unsigned char  BlockAddr,  unsigned char  *Sectorkey,  unsigned char  *serNum);
 unsigned char  MFRC522_Read( unsigned char  blockAddr,  unsigned char  *recvData);
 unsigned char  MFRC522_Write( unsigned char  blockAddr,  unsigned char  *writeData);
void MFRC522_Halt(void);
#line 244 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void delay1ms( unsigned int  delayTime)
{
  unsigned int  loop1;
 for (loop1=0;loop1<delayTime;loop1++)
 {
 delay_ms(1);
 }
}

void SetFormatRDM630(void)
{
#line 260 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 uchar_send[0] = Separate_hexP10(serNum[0]);
 uchar_send[1] = Separate_hexP1(serNum[0]);
 uchar_send[2] = Separate_hexP10(serNum[1]);
 uchar_send[3] = Separate_hexP1(serNum[1]);
 uchar_send[4] = Separate_hexP10(serNum[2]);
 uchar_send[5] = Separate_hexP1(serNum[2]);
 uchar_send[6] = Separate_hexP10(serNum[3]);
 uchar_send[7] = Separate_hexP1(serNum[3]);








 read[0]= uchar_send[0];
 read[1]= uchar_send[1];
 read[2]= uchar_send[2];
 read[3]= uchar_send[3];
 read[4]= uchar_send[4];
 read[5]= uchar_send[5];
 read[6]= uchar_send[6];
 read[7]= uchar_send[7];

}
#line 313 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void interrupt(void)
{
  unsigned short  RCREG_temp = 0;

 if (PIR1.RCIF)
 {
 PIR1.RCIF = 0;
 bytevar3=0;
 bytevar4=0;
 RCREG_temp = RCREG;

 if (RCREG_temp == 35)
 {
 receiv_cnt = 0;
 }
 else
 {
 receiv_cnt++;
 }
 receive[receiv_cnt] = RCREG_temp;

 if (receive[2] == 70)
 {
 receive[2] = 0;
 Output1 = 0;
 stringComplete = 1;
 }
 if (receive[2] == 78)
 {
 receive[2] = 0;
 Output1 = 1;
 stringComplete = 1;
 }
 }
}
#line 354 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  Separate_hexP10( unsigned char  val)
{
 val = val & 0xF0;
 val = val >> 4;
 if (val < 10)
 {
 return val + 48;
 }
 else
 {
 return val + 55;
 }
}
#line 374 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  Separate_hexP1( unsigned char  val)
{
 val = val & 0x0F;
 if (val < 10)
 {
 return val + 48;
 }
 else
 {
 return val + 55;
 }
}
#line 393 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void Write_MFRC522( unsigned char  addr,  unsigned char  val)
{
  RA0_bit  = 0;


 Soft_SPI_Write((addr<<1)&0x7E);
 Soft_SPI_Write(val);

  RA0_bit  = 1;
}
#line 411 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  Read_MFRC522( unsigned char  addr)
{
  unsigned char  val;

  RA0_bit  = 0;


 Soft_SPI_Write(((addr<<1)&0x7E) | 0x80);
 val = Soft_SPI_Read(0x00);

  RA0_bit  = 1;

 return val;
}
#line 432 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void SetBitMask( unsigned char  reg,  unsigned char  mask)
{
  unsigned char  tmp;
 tmp = Read_MFRC522(reg);
 Write_MFRC522(reg, tmp | mask);
}
#line 446 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void ClearBitMask( unsigned char  reg,  unsigned char  mask)
{
  unsigned char  tmp;
 tmp = Read_MFRC522(reg);
 Write_MFRC522(reg, tmp & (~mask));
}
#line 460 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void AntennaOn(void)
 {
  unsigned char  temp;

 temp = Read_MFRC522( 0x14 );
 if (!(temp & 0x03))
 {
 SetBitMask( 0x14 , 0x03);
}
}
#line 478 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void AntennaOff(void)
{
 ClearBitMask( 0x14 , 0x03);
}
#line 490 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void MFRC522_Reset(void)
{
 Write_MFRC522( 0x01 ,  0x0F );
}
#line 502 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void MFRC522_Init(void)
{
  RB2_bit  = 1;

 MFRC522_Reset();


 Write_MFRC522( 0x2A , 0x8D);
 Write_MFRC522( 0x2B , 0x3E);
 Write_MFRC522( 0x2D , 30);
 Write_MFRC522( 0x2C , 0);

 Write_MFRC522( 0x15 , 0x40);
 Write_MFRC522( 0x11 , 0x3D);





 AntennaOn();
}
#line 537 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_Request( unsigned char  reqMode,  unsigned char  *TagType)
{
  unsigned char  status;
  unsigned int  backBits;

 Write_MFRC522( 0x0D , 0x07);

 TagType[0] = reqMode;
 status = MFRC522_ToCard( 0x0C , TagType, 1, TagType, &backBits);

 if ((status !=  0 ) || (backBits != 0x10))
 {
 status =  2 ;
 }

 return status;
}
#line 566 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_ToCard( unsigned char  command,  unsigned char  *sendData,  unsigned char  sendLen,  unsigned char  *backData,  unsigned int  *backLen)
{
  unsigned char  status =  2 ;
  unsigned char  irqEn = 0x00;
  unsigned char  waitIRq = 0x00;
  unsigned char  lastBits;
  unsigned char  n;
  unsigned int  i;

 switch (command)
 {
 case  0x0E :
 {
 irqEn = 0x12;
 waitIRq = 0x10;
 break;
 }
 case  0x0C :
 {
 irqEn = 0x77;
 waitIRq = 0x30;
 break;
 }
 default:
 break;
 }

 Write_MFRC522( 0x02 , irqEn|0x80);
 ClearBitMask( 0x04 , 0x80);
 SetBitMask( 0x0A , 0x80);

 Write_MFRC522( 0x01 ,  0x00 );


 for (i=0; i<sendLen; i++)
 {
 Write_MFRC522( 0x09 , sendData[i]);
 }


 Write_MFRC522( 0x01 , command);
 if (command ==  0x0C )
 {
 SetBitMask( 0x0D , 0x80);
 }


 i = 2000;
 do
 {


 n = Read_MFRC522( 0x04 );
 i--;
 }
 while ((i!=0) && !(n&0x01) && !(n&waitIRq));

 ClearBitMask( 0x0D , 0x80);

 if (i != 0)
 {
 if(!(Read_MFRC522( 0x06 ) & 0x1B))
 {
 status =  0 ;
 if (n & irqEn & 0x01)
 {
 status =  1 ;
 }

 if (command ==  0x0C )
 {
 n = Read_MFRC522( 0x0A );
 lastBits = Read_MFRC522( 0x0C ) & 0x07;
 if (lastBits)
 {
 *backLen = (n-1)*8 + lastBits;
 }
 else
 {
 *backLen = n*8;
 }

 if (n == 0)
 {
 n = 1;
 }
 if (n >  16 )
 {
 n =  16 ;
 }


 for (i=0; i<n; i++)
 {
 backData[i] = Read_MFRC522( 0x09 );
 }
 }
 }
 else
 {
 status =  2 ;
 }

 }




 return status;
}
#line 684 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_Anticoll( unsigned char  *serNum)
{
  unsigned char  status;
  unsigned char  i;
  unsigned char  serNumCheck=0;
  unsigned int  unLen;




 Write_MFRC522( 0x0D , 0x00);

 serNum[0] =  0x93 ;
 serNum[1] = 0x20;
 status = MFRC522_ToCard( 0x0C , serNum, 2, serNum, &unLen);

 if (status ==  0 )
 {

 for (i=0; i<4; i++)
 {
 serNumCheck ^= serNum[i];
 }
 if (serNumCheck != serNum[i])
 {
 status =  2 ;
 }
 }



 return status;
}
#line 723 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void CalulateCRC( unsigned char  *pIndata,  unsigned char  len,  unsigned char  *pOutData)
{
  unsigned char  i, n;

 ClearBitMask( 0x05 , 0x04);
 SetBitMask( 0x0A , 0x80);



 for (i=0; i<len; i++)
 {
 Write_MFRC522( 0x09 , *(pIndata+i));
 }
 Write_MFRC522( 0x01 ,  0x03 );


 i = 0xFF;
 do
 {
 n = Read_MFRC522( 0x05 );
 i--;
 }
 while ((i!=0) && !(n&0x04));


 pOutData[0] = Read_MFRC522( 0x22 );
 pOutData[1] = Read_MFRC522( 0x21 );
}
#line 757 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_SelectTag( unsigned char  *serNum)
{
  unsigned char  i;
  unsigned char  status;
  unsigned char  size;
  unsigned int  recvBits;
  unsigned char  buffer[9];



 buffer[0] =  0x93 ;
 buffer[1] = 0x70;
 for (i=0; i<5; i++)
 {
 buffer[i+2] = *(serNum+i);
 }
 CalulateCRC(buffer, 7, &buffer[7]);
 status = MFRC522_ToCard( 0x0C , buffer, 9, buffer, &recvBits);

 if ((status ==  0 ) && (recvBits == 0x18))
 {
 size = buffer[0];
 }
 else
 {
 size = 0;
 }

 return size;
}
#line 798 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_Auth( unsigned char  authMode,  unsigned char  BlockAddr,  unsigned char  *Sectorkey,  unsigned char  *serNum)
{
  unsigned char  status;
  unsigned int  recvBits;
  unsigned char  i;
  unsigned char  buff[12];


 buff[0] = authMode;
 buff[1] = BlockAddr;
 for (i=0; i<6; i++)
 {
 buff[i+2] = *(Sectorkey+i);
 }
 for (i=0; i<4; i++)
 {
 buff[i+8] = *(serNum+i);
 }
 status = MFRC522_ToCard( 0x0E , buff, 12, buff, &recvBits);

 if ((status !=  0 ) || (!(Read_MFRC522( 0x08 ) & 0x08)))
 {
 status =  2 ;
 }

 return status;
}
#line 831 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_Read( unsigned char  blockAddr,  unsigned char  *recvData)
{
  unsigned char  status;
  unsigned int  unLen;

 recvData[0] =  0x30 ;
 recvData[1] = blockAddr;
 CalulateCRC(recvData,2, &recvData[2]);
 status = MFRC522_ToCard( 0x0C , recvData, 4, recvData, &unLen);

 if ((status !=  0 ) || (unLen != 0x90))
 {
 status =  2 ;
 }

 return status;
}
#line 854 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
 unsigned char  MFRC522_Write( unsigned char  blockAddr,  unsigned char  *writeData)
{
  unsigned char  status;
  unsigned int  recvBits;
  unsigned char  i;
  unsigned char  buff[18];

 buff[0] =  0xA0 ;
 buff[1] = blockAddr;
 CalulateCRC(buff, 2, &buff[2]);
 status = MFRC522_ToCard( 0x0C , buff, 4, buff, &recvBits);

 if ((status !=  0 ) || (recvBits != 4) || ((buff[0] & 0x0F) != 0x0A))
 {
 status =  2 ;
 }

 if (status ==  0 )
 {
 for (i=0; i<16; i++)
 {
 buff[i] = *(writeData+i);
 }
 CalulateCRC(buff, 16, &buff[16]);
 status = MFRC522_ToCard( 0x0C , buff, 18, buff, &recvBits);

 if ((status !=  0 ) || (recvBits != 4) || ((buff[0] & 0x0F) != 0x0A))
 {
 status =  2 ;
 }
 }

 return status;
}
#line 894 "d:/mikroc/hardware_codes/rfid_module/rc522.h"
void MFRC522_Halt(void)
{
  unsigned char  status;
  unsigned int  unLen;
  unsigned char  buff[4];

 buff[0] =  0x50 ;
 buff[1] = 0;
 CalulateCRC(buff, 2, &buff[2]);

 status = MFRC522_ToCard( 0x0C , buff, 4, buff,&unLen);
}
#line 3 "D:/MikroC/HARDWARE_CODES/RFID_MODULE/RFID_MODULE.c"
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
  unsigned char  status;
  unsigned char  str[ 16 ];
 TRISB = 0B11111111;
 delay1ms(500);
 TRISA = 0B00000000;
 TRISB = 0B00000010;
 ADCON1=15;
 INTCON = 0B11000000;
 TRISC.F6=0;
 PORTC.F6=0;
 Soft_SPI_Init();
 Chip_Select = 1;
 MFRC522_Init();
 while (1)
 {

 status = MFRC522_Request( 0x26 , str);

 status = MFRC522_Anticoll(str);
 memcpy(serNum, str, 5);

 if (status ==  0 )
 {
 SetFormatRDM630(void);
 Serial_print("ID: ");
 Serial_println(read);
 }
 else
 {
 MFRC522_Halt();
 delay1ms(50);
 }

 }
}
