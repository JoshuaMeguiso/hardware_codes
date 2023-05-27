void main(){
  UART1_INIT(9600);
  delay_ms(100);
  
  do{
    delay_ms(10000);
    UART1_WRITE_TEXT("1|Joshua Uriel Meguiso|RM001|April 20, 2023 - May 20, 2023|2700.00|300.00|1000|2000|1000|400.00|200.00|3200.00\x0D");
    delay_ms(10000);
    UART1_WRITE_TEXT("2|Joshua Uriel Meguiso|RM001|April, 2023|April 20, 2023|May 20, 2023|2700.00|300.00|200.00|3200.00|0.00|May 22, 2023\x0D");
    delay_ms(10000);
    UART1_WRITE_TEXT("3|February|3200.00|March 01, 2023|+639614680406\x0D");

  }while(1);
}
