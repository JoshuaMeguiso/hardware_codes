#include "rc522.h"
#define _XTAL_FREQ 27000000
#define F_CPU _XTAL_FREQ/64
#define Baud_value (((float)(F_CPU)/(float)baud_rate)-1)
#define LENGTH 20

uint8_t UID_1[LENGTH], UID_2[LENGTH], UID_3[LENGTH], UID_4[LENGTH];                                // Fix for storing UID code
unsigned char status_1, status_2, status_3, status_4;
unsigned char TagType1, TagType2, TagType3, TagType4;

void USART_Init(long);
void USART_TxChar(char*);
char USART_RxChar();

void main(void) {
    MFRC522_Init();                                 
    USART_Init(9600);

    INTCONbits.GIE = 1; /* Enable Global Interrupt */
    INTCONbits.PEIE = 1;/* Enable Peripheral Interrupt */
    //PIE1bits.RCIE = 1;  /* Enable Receive Interrupt*/
    //PIE1bits.TXIE = 1;  /* Enable Transmit Interrupt*/

    while (1) {
        MFRC522_IsCard(&TagType1);
        MFRC522_ReadCardSerial(&UID_1);
        status_1 = MFRC522_AntiColl(&UID_1);

        if(status_1 == MI_OK){
            for(uint8_t i = 0; i < 5; i++)                // Print the UID code
            {
                sprintf(data_buffer, "%X", UID_1[i]);               
                
                USART_TxChar(data_buffer);
            }
            LCD_Goto(1, 1);
            LCD_Print("Pos1");
            __delay_ms(500);
        } else {
            __delay_ms(50);
            MFRC522_Halt();
        }
    }
}

void USART_Init(long baud_rate){
    float temp;
    TRISC6 = 0;                       /*Make Tx pin as output*/
    TRISC7 = 1;                       /*Make Rx pin as input*/
    temp = Baud_value;     
    SPBRG=(int)temp;                /*baud rate=9600, SPBRG = (F_CPU /(64*9600))-1*/
    TXSTA = 0x20;                     /*Transmit Enable(TX) enable*/ 
    RCSTA = 0x90;                     /*Receive Enable(RX) enable and serial port enable */
}

void USART_TxChar(char* out){        
        while(TXIF == 0);            /*wait for transmit interrupt flag*/
        for (uint8_t i = 0; i < strlen(out); i++) {
            TXREG = out[i];                 /*transmit data via TXREG register*/
        }

}

char USART_RxChar(){
    while(RCIF==0);       /*wait for receive interrupt flag*/
        if(RCSTAbits.OERR)
        {           
            CREN = 0;
            NOP();
            CREN=1;
        }
        return(RCREG);   /*receive data is stored in RCREG register and return */
}