#include "config.h"

void main() {
  setup();
  
  while(1){
    if(signalA == 0 && signalB == 1){           //SUCCESS
      success_LED = ON;
      failed_LED = OFF;
      doorSignal = OPEN;
    }
    else if(signalA == 1 && signalB == 0){      //FAILED
      failed_LED = ON;
      success_LED = OFF;
      doorSignal = CLOSE;
    }
    else{                                       //NEUTRAL
      success_LED = OFF;
      failed_LED = OFF;
      doorSignal = CLOSE;
    }
  }
  
  
  
  
}