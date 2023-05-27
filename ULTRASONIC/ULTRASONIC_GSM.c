#include "config.h"

void main() {
  setup();
  
  while(1){
    timer();
    
    if(time_taken < 10){
      LATD = 0x01;
      send_Message("+639917927269", "Distance 1");
    }
    else if (time_taken > 9 && time_taken < 20){
      LATD = 0x02;
      send_Message("+639917927269", "Distance 2");
    }
    else if (time_taken > 19 && time_taken < 30){
      LATD = 0x04;
      send_Message("+639917927269", "Distance 3");
    }
    else{
      LATD = 0x08;
      send_Message("+639917927269", "Distance 4");
    }
  }
}