#include "config.h"

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
    //Thermal Printer (SOA)
    else if(state == 2){
      SOA_Seperator();
      Print_SOA();
      Reset();

    }
    //Thermal Printer (Reciept)
    else if(state == 3){
      Reciept_Seperator();
      Print_Reciept();
      Reset();
    }
    //GSM Module (SMS Notification)
    else if(state == 4){
      GSM_Seperator();
      Send_Message();
      Reset();
    }
  }
}