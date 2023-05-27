#line 1 "D:/MikroC/HARDWARE_CODES/PIC_RFID/rc522.c"
#line 1 "d:/mikroc/hardware_codes/pic_rfid/rc522.h"
#line 1 "d:/mikroc/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "d:/mikroc/mikroc pro for pic/include/stdio.h"
#line 1 "d:/mikroc/mikroc pro for pic/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "d:/mikroc/mikroc pro for pic/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 128 "d:/mikroc/hardware_codes/pic_rfid/rc522.h"
unsigned char MFRC522_Rd(unsigned char address);
void MFRC522_Wr(unsigned char address, unsigned char value);
static void MFRC522_Clear_Bit(char addr, char mask);
static void MFRC522_Set_Bit(char addr, char mask);
void MFRC522_Reset(void);
void MFRC522_AntennaOn(void);
void MFRC522_AntennaOff(void);
void MFRC522_Init(void);
char MFRC522_ToCard(char command, char *sendData, char sendLen, char *backData, unsigned *backLen);
char MFRC522_Request(char reqMode, char *TagType);
void MFRC522_CRC(char *dataIn, char length, char *dataOut);
char MFRC522_SelectTag(char *serNum);
void MFRC522_Halt(void);
char MFRC522_AntiColl(char *serNum);
char MFRC522_IsCard(char *TagType);
char MFRC522_ReadCardSerial(char *str);
char MFRC522_Compare_UID(char *l, char *u);
#line 2 "D:/MikroC/HARDWARE_CODES/PIC_RFID/rc522.c"
unsigned char MFRC522_Rd(unsigned char address)
{
 unsigned int i, ucAddr;
 unsigned int ucResult = 0;
  LATDbits.LD1  = 0;
  LATAbits.LA3  = 0;
 ucAddr = ((address << 1) & 0x7E) | 0x80;

 for(i=8; i>0; i--)
 {
  LATDbits.LD3  = ((ucAddr & 0x80) == 0x80);
  LATDbits.LD1  = 1;
 ucAddr <<= 1;
  LATDbits.LD1  = 0;
 }
 for(i=8; i>0; i--)
 {
  LATDbits.LD1  = 1;
 ucResult <<= 1;
 ucResult |= (short) PORTDbits.RD2 ;
  LATDbits.LD1  = 0;
 }
  LATAbits.LA3  = 1;
  LATDbits.LD1  = 1;
 return ucResult;
}

void MFRC522_Wr(unsigned char address, unsigned char value)
{
 unsigned char i, ucAddr;
  LATDbits.LD1  = 0;
  LATAbits.LA3  = 0;
 ucAddr = ((address << 1) & 0x7E);

 for(i=8; i>0; i--)
 {
  LATDbits.LD3  = ((ucAddr&0x80) == 0x80);
  LATDbits.LD1  = 1;
 ucAddr <<= 1;
  LATDbits.LD1  = 0;
 }
 for(i=8; i>0; i--)
 {
  LATDbits.LD3  = ((value&0x80) == 0x80);
  LATDbits.LD1  = 1;
 value <<= 1;
  LATDbits.LD1  = 0;
 }
  LATAbits.LA3  = 1;
  LATDbits.LD1  = 1;
}

static void MFRC522_Clear_Bit(char addr, char mask)
{
 unsigned char tmp = 0;
 tmp = MFRC522_Rd(addr) ;
 MFRC522_Wr(addr, tmp&~mask);
}

static void MFRC522_Set_Bit(char addr, char mask)
{
 unsigned char tmp = 0;
 tmp = MFRC522_Rd(addr);
 MFRC522_Wr(addr, tmp | mask);
}

void MFRC522_Reset(void)
{
  LATDbits.LD4  = 1;
 delay_us(1);
  LATDbits.LD4  = 0;
 delay_us(1);
  LATDbits.LD4  = 1;
 delay_us(1);
 MFRC522_Wr( 0x01 ,  0x0F );
 delay_us(1);
}

void MFRC522_AntennaOn(void)
{
 unsigned char stt;
 stt = MFRC522_Rd( 0x14 );
 MFRC522_Set_Bit( 0x14 , 0x03);
}

void MFRC522_AntennaOff(void)
{
 MFRC522_Clear_Bit( 0x14 , 0x03);
}

void MFRC522_Init(void)
{
  TRISDbits.RD3  = 0;
  TRISDbits.RD1  = 0;
  TRISAbits.RA3  = 0;
  TRISAbits.RA2  = 0;
  TRISAbits.RA1  = 0;
  TRISAbits.RA0  = 0;
  TRISDbits.RD2  = 1;
  TRISDbits.RD4  = 0;
  LATDbits.LD1  = 0;
  LATDbits.LD3  = 0;
  LATAbits.LA3  = 1;
  LATAbits.LA2  = 1;
  LATAbits.LA1  = 1;
  LATAbits.LA0  = 1;
  LATDbits.LD4  = 1;
 MFRC522_Reset();

 MFRC522_Wr( 0x2A , 0x8D);
 MFRC522_Wr( 0x2B , 0x3E);
 MFRC522_Wr( 0x2D , 30);
 MFRC522_Wr( 0x2C , 0);
 MFRC522_Wr( 0x15 , 0x40);
 MFRC522_Wr( 0x11 , 0x3D);
 MFRC522_AntennaOff();
 MFRC522_AntennaOn();
}

char MFRC522_ToCard(char command, char *sendData, char sendLen, char *backData, unsigned *backLen)
{
 char _status =  2 ;
 char irqEn = 0x00;
 char waitIRq = 0x00;
 char lastBits;
 char n;
 unsigned i;

 switch(command)
 {
 case  0x0E :
 irqEn = 0x12;
 waitIRq = 0x10;
 break;

 case  0x0C :
 irqEn = 0x77;
 waitIRq = 0x30;
 break;

 default:
 break;
 }
 MFRC522_Wr( 0x02 , irqEn | 0x80);
 MFRC522_Clear_Bit( 0x04 , 0x80);
 MFRC522_Set_Bit( 0x0A , 0x80);
 MFRC522_Wr( 0x01 ,  0x00 );

 for(i=0; i<sendLen; i++)
 {
 MFRC522_Wr( 0x09 , sendData[i]);
 }
 MFRC522_Wr( 0x01 , command);
 if(command ==  0x0C )
 {
 MFRC522_Set_Bit( 0x0D , 0x80);
 }
 i = 0xFFFF;
 do
 {
 n = MFRC522_Rd( 0x04 );
 i--;
 }while(i && !(n & 0x01) && !(n & waitIRq));

 MFRC522_Clear_Bit( 0x0D , 0x80);
 if(i != 0)
 {
 if(!(MFRC522_Rd( 0x06 ) & 0x1B))
 {
 _status =  0 ;
 if(n & irqEn & 0x01)
 {
 _status =  1 ;
 }
 if(command ==  0x0C )
 {
 n = MFRC522_Rd( 0x0A );
 lastBits = MFRC522_Rd( 0x0C ) & 0x07;
 if(lastBits)
 {
 *backLen = (n-1) * 8 + lastBits;
 }
 else
 {
 *backLen = n * 8;
 }
 if(n == 0)
 {
 n = 1;
 }
 if(n > 16)
 {
 n = 16;
 }
 for(i=0; i<n; i++)
 {
 backData[i] = MFRC522_Rd( 0x09 );
 }
 backData[i] = 0;
 }
 }
 else
 {
 _status =  2 ;
 }
 }
 return _status;
}

char MFRC522_Request(char reqMode, char *TagType)
{
 char _status;
 unsigned backBits;
 MFRC522_Wr( 0x0D , 0x07);
 TagType[0] = reqMode;
 _status = MFRC522_ToCard( 0x0C , TagType, 1, TagType, &backBits);
 if((_status !=  0 ) || (backBits != 0x10))
 {
 _status =  2 ;
 }
 return _status;
}

void MFRC522_CRC(char *dataIn, char length, char *dataOut)
{
 char i, n;
 MFRC522_Clear_Bit( 0x05 , 0x04);
 MFRC522_Set_Bit( 0x0A , 0x80);
 for(i=0; i<length; i++)
 {
 MFRC522_Wr( 0x09 , *dataIn++);
 }
 MFRC522_Wr( 0x01 ,  0x03 );
 i = 0xFF;
 do
 {
 n = MFRC522_Rd(  0x05  );
 i--;
 }
 while(i && !(n & 0x04));
 dataOut[0] = MFRC522_Rd( 0x22 );
 dataOut[1] = MFRC522_Rd( 0x21 );
}

char MFRC522_SelectTag(char *serNum)
{
 char i;
 char _status;
 char size;
 unsigned recvBits;
 char buffer[9];
 buffer[0] =  0x93 ;
 buffer[1] = 0x70;

 for(i=2; i<7; i++)
 {
 buffer[i] = *serNum++;
 }
 MFRC522_CRC(buffer, 7, &buffer[7]);
 _status = MFRC522_ToCard( 0x0C , buffer, 9, buffer, &recvBits);
 if((_status ==  0 ) && (recvBits == 0x18))
 {
 size = buffer[0];
 }
 else
 {
 size = 0;
 }
 return size;
}

void MFRC522_Halt(void)
{
 unsigned unLen;
 char buff[4];
 buff[0] =  0x50 ;
 buff[1] = 0;
 MFRC522_CRC(buff, 2, &buff[2]);
 MFRC522_Clear_Bit( 0x08 , 0x80);
 MFRC522_ToCard( 0x0C , buff, 4, buff, &unLen);
 MFRC522_Clear_Bit( 0x08 , 0x08);
}

char MFRC522_AntiColl(char *serNum)
{
 char _status;
 char i;
 char serNumCheck = 0;
 unsigned unLen;
 MFRC522_Wr( 0x0D , 0x00);
 serNum[0] =  0x93 ;
 serNum[1] = 0x20;
 MFRC522_Clear_Bit( 0x08 , 0x08);
 _status = MFRC522_ToCard( 0x0C , serNum, 2, serNum, &unLen);
 if(_status ==  0 )
 {
 for(i=0; i<5; i++)
 {
 serNumCheck ^= serNum[i];
 }
 if(serNumCheck != serNum[5])
 {
 _status =  2 ;
 }
 }
 return _status;
}

char MFRC522_IsCard(char *TagType)
{
 if(MFRC522_Request( 0x26 , TagType) ==  0 )
 return 1;
 else
 return 0;
}

char MFRC522_ReadCardSerial(char *str)
{
 char _status;
 _status = MFRC522_AntiColl(str);
 str[5] = 0;
 if(_status ==  0 )
 return 1;
 else
 return 0;
}

char MFRC522_Compare_UID(char *l, char *u)
{
 for(char i=0; i<4; i++)
 {
 if(l[i] != u[i])
 {
 return 0;
 }
 }
 return 1;
}
