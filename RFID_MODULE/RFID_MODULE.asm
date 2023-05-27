
_delay1ms:

;rc522.h,244 :: 		void delay1ms(uint delayTime)
;rc522.h,247 :: 		for (loop1=0;loop1<delayTime;loop1++)
	CLRF        R1 
	CLRF        R2 
L_delay1ms0:
	MOVF        FARG_delay1ms_delayTime+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay1ms102
	MOVF        FARG_delay1ms_delayTime+0, 0 
	SUBWF       R1, 0 
L__delay1ms102:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay1ms1
;rc522.h,249 :: 		delay_ms(1);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_delay1ms3:
	DECFSZ      R13, 1, 1
	BRA         L_delay1ms3
	DECFSZ      R12, 1, 1
	BRA         L_delay1ms3
;rc522.h,247 :: 		for (loop1=0;loop1<delayTime;loop1++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;rc522.h,250 :: 		}
	GOTO        L_delay1ms0
L_delay1ms1:
;rc522.h,251 :: 		}
L_end_delay1ms:
	RETURN      0
; end of _delay1ms

_SetFormatRDM630:

;rc522.h,253 :: 		void SetFormatRDM630(void)
;rc522.h,260 :: 		uchar_send[0] = Separate_hexP10(serNum[0]);
	MOVF        _serNum+0, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
	CALL        _Separate_hexP10+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+0 
;rc522.h,261 :: 		uchar_send[1] = Separate_hexP1(serNum[0]);
	MOVF        _serNum+0, 0 
	MOVWF       FARG_Separate_hexP1_val+0 
	CALL        _Separate_hexP1+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+1 
;rc522.h,262 :: 		uchar_send[2] = Separate_hexP10(serNum[1]);
	MOVF        _serNum+1, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
	CALL        _Separate_hexP10+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+2 
;rc522.h,263 :: 		uchar_send[3] = Separate_hexP1(serNum[1]);
	MOVF        _serNum+1, 0 
	MOVWF       FARG_Separate_hexP1_val+0 
	CALL        _Separate_hexP1+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+3 
;rc522.h,264 :: 		uchar_send[4] = Separate_hexP10(serNum[2]);
	MOVF        _serNum+2, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
	CALL        _Separate_hexP10+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+4 
;rc522.h,265 :: 		uchar_send[5] = Separate_hexP1(serNum[2]);
	MOVF        _serNum+2, 0 
	MOVWF       FARG_Separate_hexP1_val+0 
	CALL        _Separate_hexP1+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+5 
;rc522.h,266 :: 		uchar_send[6] = Separate_hexP10(serNum[3]);
	MOVF        _serNum+3, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
	CALL        _Separate_hexP10+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+6 
;rc522.h,267 :: 		uchar_send[7] = Separate_hexP1(serNum[3]);
	MOVF        _serNum+3, 0 
	MOVWF       FARG_Separate_hexP1_val+0 
	CALL        _Separate_hexP1+0, 0
	MOVF        R0, 0 
	MOVWF       _uchar_send+7 
;rc522.h,276 :: 		read[0]= uchar_send[0];
	MOVF        _uchar_send+0, 0 
	MOVWF       _read+0 
;rc522.h,277 :: 		read[1]= uchar_send[1];
	MOVF        _uchar_send+1, 0 
	MOVWF       _read+1 
;rc522.h,278 :: 		read[2]= uchar_send[2];
	MOVF        _uchar_send+2, 0 
	MOVWF       _read+2 
;rc522.h,279 :: 		read[3]= uchar_send[3];
	MOVF        _uchar_send+3, 0 
	MOVWF       _read+3 
;rc522.h,280 :: 		read[4]= uchar_send[4];
	MOVF        _uchar_send+4, 0 
	MOVWF       _read+4 
;rc522.h,281 :: 		read[5]= uchar_send[5];
	MOVF        _uchar_send+5, 0 
	MOVWF       _read+5 
;rc522.h,282 :: 		read[6]= uchar_send[6];
	MOVF        _uchar_send+6, 0 
	MOVWF       _read+6 
;rc522.h,283 :: 		read[7]= uchar_send[7];
	MOVF        R0, 0 
	MOVWF       _read+7 
;rc522.h,285 :: 		}
L_end_SetFormatRDM630:
	RETURN      0
; end of _SetFormatRDM630

_interrupt:

;rc522.h,313 :: 		void interrupt(void)
;rc522.h,315 :: 		ushort RCREG_temp = 0;
	CLRF        interrupt_RCREG_temp_L0+0 
;rc522.h,317 :: 		if (PIR1.RCIF) // USART Receive Interrupt Flag bit
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt4
;rc522.h,319 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;rc522.h,320 :: 		bytevar3=0; // CLEAR THE TIMEOUT TO RESET BLUETOOTH MODULE
	CLRF        _bytevar3+0 
;rc522.h,321 :: 		bytevar4=0; // CLEAR THE TIMEOUT TO RESET BLUETOOTH MODULE
	CLRF        _bytevar4+0 
;rc522.h,322 :: 		RCREG_temp = RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       interrupt_RCREG_temp_L0+0 
;rc522.h,324 :: 		if (RCREG_temp == 35)  // 35 = "#" - (# ???)
	MOVF        interrupt_RCREG_temp_L0+0, 0 
	XORLW       35
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;rc522.h,326 :: 		receiv_cnt = 0;
	CLRF        _receiv_cnt+0 
;rc522.h,327 :: 		}
	GOTO        L_interrupt6
L_interrupt5:
;rc522.h,330 :: 		receiv_cnt++;
	INCF        _receiv_cnt+0, 1 
;rc522.h,331 :: 		}
L_interrupt6:
;rc522.h,332 :: 		receive[receiv_cnt] = RCREG_temp;
	MOVLW       _receive+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_receive+0)
	MOVWF       FSR1L+1 
	MOVF        _receiv_cnt+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        interrupt_RCREG_temp_L0+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,334 :: 		if (receive[2] == 70) // 70 = "F"  - (#OFF1# ???)
	MOVF        _receive+2, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;rc522.h,336 :: 		receive[2] = 0;
	CLRF        _receive+2 
;rc522.h,337 :: 		Output1 = 0;
	CLRF        _Output1+0 
;rc522.h,338 :: 		stringComplete = 1;
	BSF         _stringComplete+0, BitPos(_stringComplete+0) 
;rc522.h,339 :: 		}
L_interrupt7:
;rc522.h,340 :: 		if (receive[2] == 78)  // 78 = "N" - (#ON1# ???)
	MOVF        _receive+2, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;rc522.h,342 :: 		receive[2] = 0;
	CLRF        _receive+2 
;rc522.h,343 :: 		Output1 = 1;
	MOVLW       1
	MOVWF       _Output1+0 
;rc522.h,344 :: 		stringComplete = 1;
	BSF         _stringComplete+0, BitPos(_stringComplete+0) 
;rc522.h,345 :: 		}
L_interrupt8:
;rc522.h,346 :: 		}
L_interrupt4:
;rc522.h,347 :: 		}
L_end_interrupt:
L__interrupt105:
	RETFIE      1
; end of _interrupt

_Separate_hexP10:

;rc522.h,354 :: 		uchar Separate_hexP10(uchar val)
;rc522.h,356 :: 		val = val & 0xF0;
	MOVLW       240
	ANDWF       FARG_Separate_hexP10_val+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
;rc522.h,357 :: 		val = val >> 4;
	MOVF        R2, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       FARG_Separate_hexP10_val+0 
;rc522.h,358 :: 		if (val < 10)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Separate_hexP109
;rc522.h,360 :: 		return val + 48;
	MOVLW       48
	ADDWF       FARG_Separate_hexP10_val+0, 0 
	MOVWF       R0 
	GOTO        L_end_Separate_hexP10
;rc522.h,361 :: 		}
L_Separate_hexP109:
;rc522.h,364 :: 		return val + 55;
	MOVLW       55
	ADDWF       FARG_Separate_hexP10_val+0, 0 
	MOVWF       R0 
;rc522.h,366 :: 		}
L_end_Separate_hexP10:
	RETURN      0
; end of _Separate_hexP10

_Separate_hexP1:

;rc522.h,374 :: 		uchar Separate_hexP1(uchar val)
;rc522.h,376 :: 		val = val & 0x0F;
	MOVLW       15
	ANDWF       FARG_Separate_hexP1_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_Separate_hexP1_val+0 
;rc522.h,377 :: 		if (val < 10)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Separate_hexP111
;rc522.h,379 :: 		return val + 48;
	MOVLW       48
	ADDWF       FARG_Separate_hexP1_val+0, 0 
	MOVWF       R0 
	GOTO        L_end_Separate_hexP1
;rc522.h,380 :: 		}
L_Separate_hexP111:
;rc522.h,383 :: 		return val + 55;
	MOVLW       55
	ADDWF       FARG_Separate_hexP1_val+0, 0 
	MOVWF       R0 
;rc522.h,385 :: 		}
L_end_Separate_hexP1:
	RETURN      0
; end of _Separate_hexP1

_Write_MFRC522:

;rc522.h,393 :: 		void Write_MFRC522(uchar addr, uchar val)
;rc522.h,395 :: 		chipSelectPin = 0;
	BCF         RA0_bit+0, BitPos(RA0_bit+0) 
;rc522.h,398 :: 		Soft_SPI_Write((addr<<1)&0x7E);
	MOVF        FARG_Write_MFRC522_addr+0, 0 
	MOVWF       FARG_Soft_SPI_Write_sdata+0 
	RLCF        FARG_Soft_SPI_Write_sdata+0, 1 
	BCF         FARG_Soft_SPI_Write_sdata+0, 0 
	MOVLW       126
	ANDWF       FARG_Soft_SPI_Write_sdata+0, 1 
	CALL        _Soft_SPI_Write+0, 0
;rc522.h,399 :: 		Soft_SPI_Write(val);
	MOVF        FARG_Write_MFRC522_val+0, 0 
	MOVWF       FARG_Soft_SPI_Write_sdata+0 
	CALL        _Soft_SPI_Write+0, 0
;rc522.h,401 :: 		chipSelectPin = 1;
	BSF         RA0_bit+0, BitPos(RA0_bit+0) 
;rc522.h,402 :: 		}
L_end_Write_MFRC522:
	RETURN      0
; end of _Write_MFRC522

_Read_MFRC522:

;rc522.h,411 :: 		uchar Read_MFRC522(uchar addr)
;rc522.h,415 :: 		chipSelectPin = 0;
	BCF         RA0_bit+0, BitPos(RA0_bit+0) 
;rc522.h,418 :: 		Soft_SPI_Write(((addr<<1)&0x7E) | 0x80);
	MOVF        FARG_Read_MFRC522_addr+0, 0 
	MOVWF       FARG_Soft_SPI_Write_sdata+0 
	RLCF        FARG_Soft_SPI_Write_sdata+0, 1 
	BCF         FARG_Soft_SPI_Write_sdata+0, 0 
	MOVLW       126
	ANDWF       FARG_Soft_SPI_Write_sdata+0, 1 
	BSF         FARG_Soft_SPI_Write_sdata+0, 7 
	CALL        _Soft_SPI_Write+0, 0
;rc522.h,419 :: 		val = Soft_SPI_Read(0x00);
	CLRF        FARG_Soft_SPI_Read_sdata+0 
	CALL        _Soft_SPI_Read+0, 0
;rc522.h,421 :: 		chipSelectPin = 1;
	BSF         RA0_bit+0, BitPos(RA0_bit+0) 
;rc522.h,423 :: 		return val;
;rc522.h,424 :: 		}
L_end_Read_MFRC522:
	RETURN      0
; end of _Read_MFRC522

_SetBitMask:

;rc522.h,432 :: 		void SetBitMask(uchar reg, uchar mask)
;rc522.h,435 :: 		tmp = Read_MFRC522(reg);
	MOVF        FARG_SetBitMask_reg+0, 0 
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
;rc522.h,436 :: 		Write_MFRC522(reg, tmp | mask);  // set bit mask
	MOVF        FARG_SetBitMask_reg+0, 0 
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVF        FARG_SetBitMask_mask+0, 0 
	IORWF       R0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,437 :: 		}
L_end_SetBitMask:
	RETURN      0
; end of _SetBitMask

_ClearBitMask:

;rc522.h,446 :: 		void ClearBitMask(uchar reg, uchar mask)
;rc522.h,449 :: 		tmp = Read_MFRC522(reg);
	MOVF        FARG_ClearBitMask_reg+0, 0 
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
;rc522.h,450 :: 		Write_MFRC522(reg, tmp & (~mask));  // clear bit mask
	MOVF        FARG_ClearBitMask_reg+0, 0 
	MOVWF       FARG_Write_MFRC522_addr+0 
	COMF        FARG_ClearBitMask_mask+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	ANDWF       R0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,451 :: 		}
L_end_ClearBitMask:
	RETURN      0
; end of _ClearBitMask

_AntennaOn:

;rc522.h,460 :: 		void AntennaOn(void)
;rc522.h,464 :: 		temp = Read_MFRC522(TxControlReg);
	MOVLW       20
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
;rc522.h,465 :: 		if (!(temp & 0x03))
	MOVLW       3
	ANDWF       R0, 1 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_AntennaOn13
;rc522.h,467 :: 		SetBitMask(TxControlReg, 0x03);
	MOVLW       20
	MOVWF       FARG_SetBitMask_reg+0 
	MOVLW       3
	MOVWF       FARG_SetBitMask_mask+0 
	CALL        _SetBitMask+0, 0
;rc522.h,468 :: 		}
L_AntennaOn13:
;rc522.h,469 :: 		}
L_end_AntennaOn:
	RETURN      0
; end of _AntennaOn

_AntennaOff:

;rc522.h,478 :: 		void AntennaOff(void)
;rc522.h,480 :: 		ClearBitMask(TxControlReg, 0x03);
	MOVLW       20
	MOVWF       FARG_ClearBitMask_reg+0 
	MOVLW       3
	MOVWF       FARG_ClearBitMask_mask+0 
	CALL        _ClearBitMask+0, 0
;rc522.h,481 :: 		}
L_end_AntennaOff:
	RETURN      0
; end of _AntennaOff

_MFRC522_Reset:

;rc522.h,490 :: 		void MFRC522_Reset(void)
;rc522.h,492 :: 		Write_MFRC522(CommandReg, PCD_RESETPHASE);
	MOVLW       1
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       15
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,493 :: 		}
L_end_MFRC522_Reset:
	RETURN      0
; end of _MFRC522_Reset

_MFRC522_Init:

;rc522.h,502 :: 		void MFRC522_Init(void)
;rc522.h,504 :: 		NRSTPD = 1;
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
;rc522.h,506 :: 		MFRC522_Reset();
	CALL        _MFRC522_Reset+0, 0
;rc522.h,509 :: 		Write_MFRC522(TModeReg, 0x8D);                //Tauto=1; f(Timer) = 6.78MHz/TPreScaler
	MOVLW       42
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       141
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,510 :: 		Write_MFRC522(TPrescalerReg, 0x3E);        //TModeReg[3..0] + TPrescalerReg
	MOVLW       43
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       62
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,511 :: 		Write_MFRC522(TReloadRegL, 30);
	MOVLW       45
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       30
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,512 :: 		Write_MFRC522(TReloadRegH, 0);
	MOVLW       44
	MOVWF       FARG_Write_MFRC522_addr+0 
	CLRF        FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,514 :: 		Write_MFRC522(TxAutoReg, 0x40);                //100%ASK
	MOVLW       21
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       64
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,515 :: 		Write_MFRC522(ModeReg, 0x3D);                //CRC Initial value 0x6363        ???
	MOVLW       17
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       61
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,521 :: 		AntennaOn();                //Open the antenna
	CALL        _AntennaOn+0, 0
;rc522.h,522 :: 		}
L_end_MFRC522_Init:
	RETURN      0
; end of _MFRC522_Init

_MFRC522_Request:

;rc522.h,537 :: 		uchar MFRC522_Request(uchar reqMode, uchar *TagType)
;rc522.h,542 :: 		Write_MFRC522(BitFramingReg, 0x07);                //TxLastBists = BitFramingReg[2..0]        ???
	MOVLW       13
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       7
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,544 :: 		TagType[0] = reqMode;
	MOVFF       FARG_MFRC522_Request_TagType+0, FSR1L+0
	MOVFF       FARG_MFRC522_Request_TagType+1, FSR1H+0
	MOVF        FARG_MFRC522_Request_reqMode+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,545 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, TagType, 1, TagType, &backBits);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVF        FARG_MFRC522_Request_TagType+0, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVF        FARG_MFRC522_Request_TagType+1, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       1
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVF        FARG_MFRC522_Request_TagType+0, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVF        FARG_MFRC522_Request_TagType+1, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Request_backBits_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Request_backBits_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Request_status_L0+0 
;rc522.h,547 :: 		if ((status != MI_OK) || (backBits != 0x10))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Request93
	MOVLW       0
	XORWF       MFRC522_Request_backBits_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Request117
	MOVLW       16
	XORWF       MFRC522_Request_backBits_L0+0, 0 
L__MFRC522_Request117:
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Request93
	GOTO        L_MFRC522_Request16
L__MFRC522_Request93:
;rc522.h,549 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Request_status_L0+0 
;rc522.h,550 :: 		}
L_MFRC522_Request16:
;rc522.h,552 :: 		return status;
	MOVF        MFRC522_Request_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,553 :: 		}
L_end_MFRC522_Request:
	RETURN      0
; end of _MFRC522_Request

_MFRC522_ToCard:

;rc522.h,566 :: 		uchar MFRC522_ToCard(uchar command, uchar *sendData, uchar sendLen, uchar *backData, uint *backLen)
;rc522.h,568 :: 		uchar status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_ToCard_status_L0+0 
	CLRF        MFRC522_ToCard_irqEn_L0+0 
	CLRF        MFRC522_ToCard_waitIRq_L0+0 
;rc522.h,575 :: 		switch (command)
	GOTO        L_MFRC522_ToCard17
;rc522.h,577 :: 		case PCD_AUTHENT:                //Certification cards close
L_MFRC522_ToCard19:
;rc522.h,579 :: 		irqEn = 0x12;
	MOVLW       18
	MOVWF       MFRC522_ToCard_irqEn_L0+0 
;rc522.h,580 :: 		waitIRq = 0x10;
	MOVLW       16
	MOVWF       MFRC522_ToCard_waitIRq_L0+0 
;rc522.h,581 :: 		break;
	GOTO        L_MFRC522_ToCard18
;rc522.h,583 :: 		case PCD_TRANSCEIVE:        //Transmit FIFO data
L_MFRC522_ToCard20:
;rc522.h,585 :: 		irqEn = 0x77;
	MOVLW       119
	MOVWF       MFRC522_ToCard_irqEn_L0+0 
;rc522.h,586 :: 		waitIRq = 0x30;
	MOVLW       48
	MOVWF       MFRC522_ToCard_waitIRq_L0+0 
;rc522.h,587 :: 		break;
	GOTO        L_MFRC522_ToCard18
;rc522.h,589 :: 		default:
L_MFRC522_ToCard21:
;rc522.h,590 :: 		break;
	GOTO        L_MFRC522_ToCard18
;rc522.h,591 :: 		}
L_MFRC522_ToCard17:
	MOVF        FARG_MFRC522_ToCard_command+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard19
	MOVF        FARG_MFRC522_ToCard_command+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard20
	GOTO        L_MFRC522_ToCard21
L_MFRC522_ToCard18:
;rc522.h,593 :: 		Write_MFRC522(CommIEnReg, irqEn|0x80);        //Interrupt request
	MOVLW       2
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       128
	IORWF       MFRC522_ToCard_irqEn_L0+0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,594 :: 		ClearBitMask(CommIrqReg, 0x80);                        //Clear all interrupt request bit
	MOVLW       4
	MOVWF       FARG_ClearBitMask_reg+0 
	MOVLW       128
	MOVWF       FARG_ClearBitMask_mask+0 
	CALL        _ClearBitMask+0, 0
;rc522.h,595 :: 		SetBitMask(FIFOLevelReg, 0x80);                        //FlushBuffer=1, FIFO Initialization
	MOVLW       10
	MOVWF       FARG_SetBitMask_reg+0 
	MOVLW       128
	MOVWF       FARG_SetBitMask_mask+0 
	CALL        _SetBitMask+0, 0
;rc522.h,597 :: 		Write_MFRC522(CommandReg, PCD_IDLE);        //NO action; Cancel the current command???
	MOVLW       1
	MOVWF       FARG_Write_MFRC522_addr+0 
	CLRF        FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,600 :: 		for (i=0; i<sendLen; i++)
	CLRF        MFRC522_ToCard_i_L0+0 
	CLRF        MFRC522_ToCard_i_L0+1 
L_MFRC522_ToCard22:
	MOVLW       0
	SUBWF       MFRC522_ToCard_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard119
	MOVF        FARG_MFRC522_ToCard_sendLen+0, 0 
	SUBWF       MFRC522_ToCard_i_L0+0, 0 
L__MFRC522_ToCard119:
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_ToCard23
;rc522.h,602 :: 		Write_MFRC522(FIFODataReg, sendData[i]);
	MOVLW       9
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVF        MFRC522_ToCard_i_L0+0, 0 
	ADDWF       FARG_MFRC522_ToCard_sendData+0, 0 
	MOVWF       FSR0L+0 
	MOVF        MFRC522_ToCard_i_L0+1, 0 
	ADDWFC      FARG_MFRC522_ToCard_sendData+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,600 :: 		for (i=0; i<sendLen; i++)
	INFSNZ      MFRC522_ToCard_i_L0+0, 1 
	INCF        MFRC522_ToCard_i_L0+1, 1 
;rc522.h,603 :: 		}
	GOTO        L_MFRC522_ToCard22
L_MFRC522_ToCard23:
;rc522.h,606 :: 		Write_MFRC522(CommandReg, command);
	MOVLW       1
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVF        FARG_MFRC522_ToCard_command+0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,607 :: 		if (command == PCD_TRANSCEIVE)
	MOVF        FARG_MFRC522_ToCard_command+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard25
;rc522.h,609 :: 		SetBitMask(BitFramingReg, 0x80);                //StartSend=1,transmission of data starts
	MOVLW       13
	MOVWF       FARG_SetBitMask_reg+0 
	MOVLW       128
	MOVWF       FARG_SetBitMask_mask+0 
	CALL        _SetBitMask+0, 0
;rc522.h,610 :: 		}
L_MFRC522_ToCard25:
;rc522.h,613 :: 		i = 2000;        //i according to the clock frequency adjustment, the operator M1 card maximum waiting time 25ms???
	MOVLW       208
	MOVWF       MFRC522_ToCard_i_L0+0 
	MOVLW       7
	MOVWF       MFRC522_ToCard_i_L0+1 
;rc522.h,614 :: 		do
L_MFRC522_ToCard26:
;rc522.h,618 :: 		n = Read_MFRC522(CommIrqReg);
	MOVLW       4
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_ToCard_n_L0+0 
;rc522.h,619 :: 		i--;
	MOVLW       1
	SUBWF       MFRC522_ToCard_i_L0+0, 1 
	MOVLW       0
	SUBWFB      MFRC522_ToCard_i_L0+1, 1 
;rc522.h,621 :: 		while ((i!=0) && !(n&0x01) && !(n&waitIRq));
	MOVLW       0
	XORWF       MFRC522_ToCard_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard120
	MOVLW       0
	XORWF       MFRC522_ToCard_i_L0+0, 0 
L__MFRC522_ToCard120:
	BTFSC       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard94
	BTFSC       MFRC522_ToCard_n_L0+0, 0 
	GOTO        L__MFRC522_ToCard94
	MOVF        MFRC522_ToCard_waitIRq_L0+0, 0 
	ANDWF       MFRC522_ToCard_n_L0+0, 0 
	MOVWF       R0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard94
	GOTO        L_MFRC522_ToCard26
L__MFRC522_ToCard94:
;rc522.h,623 :: 		ClearBitMask(BitFramingReg, 0x80);                        //StartSend=0
	MOVLW       13
	MOVWF       FARG_ClearBitMask_reg+0 
	MOVLW       128
	MOVWF       FARG_ClearBitMask_mask+0 
	CALL        _ClearBitMask+0, 0
;rc522.h,625 :: 		if (i != 0)
	MOVLW       0
	XORWF       MFRC522_ToCard_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard121
	MOVLW       0
	XORWF       MFRC522_ToCard_i_L0+0, 0 
L__MFRC522_ToCard121:
	BTFSC       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard31
;rc522.h,627 :: 		if(!(Read_MFRC522(ErrorReg) & 0x1B))        //BufferOvfl Collerr CRCErr ProtecolErr
	MOVLW       6
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVLW       27
	ANDWF       R0, 1 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard32
;rc522.h,629 :: 		status = MI_OK;
	CLRF        MFRC522_ToCard_status_L0+0 
;rc522.h,630 :: 		if (n & irqEn & 0x01)
	MOVF        MFRC522_ToCard_irqEn_L0+0, 0 
	ANDWF       MFRC522_ToCard_n_L0+0, 0 
	MOVWF       R1 
	BTFSS       R1, 0 
	GOTO        L_MFRC522_ToCard33
;rc522.h,632 :: 		status = MI_NOTAGERR;                        //??
	MOVLW       1
	MOVWF       MFRC522_ToCard_status_L0+0 
;rc522.h,633 :: 		}
L_MFRC522_ToCard33:
;rc522.h,635 :: 		if (command == PCD_TRANSCEIVE)
	MOVF        FARG_MFRC522_ToCard_command+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard34
;rc522.h,637 :: 		n = Read_MFRC522(FIFOLevelReg);
	MOVLW       10
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_ToCard_n_L0+0 
;rc522.h,638 :: 		lastBits = Read_MFRC522(ControlReg) & 0x07;
	MOVLW       12
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       MFRC522_ToCard_lastBits_L0+0 
;rc522.h,639 :: 		if (lastBits)
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard35
;rc522.h,641 :: 		*backLen = (n-1)*8 + lastBits;
	DECF        MFRC522_ToCard_n_L0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__MFRC522_ToCard122:
	BZ          L__MFRC522_ToCard123
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__MFRC522_ToCard122
L__MFRC522_ToCard123:
	MOVF        MFRC522_ToCard_lastBits_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVFF       FARG_MFRC522_ToCard_backLen+0, FSR1L+0
	MOVFF       FARG_MFRC522_ToCard_backLen+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;rc522.h,642 :: 		}
	GOTO        L_MFRC522_ToCard36
L_MFRC522_ToCard35:
;rc522.h,645 :: 		*backLen = n*8;
	MOVLW       3
	MOVWF       R2 
	MOVF        MFRC522_ToCard_n_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__MFRC522_ToCard124:
	BZ          L__MFRC522_ToCard125
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__MFRC522_ToCard124
L__MFRC522_ToCard125:
	MOVFF       FARG_MFRC522_ToCard_backLen+0, FSR1L+0
	MOVFF       FARG_MFRC522_ToCard_backLen+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;rc522.h,646 :: 		}
L_MFRC522_ToCard36:
;rc522.h,648 :: 		if (n == 0)
	MOVF        MFRC522_ToCard_n_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_ToCard37
;rc522.h,650 :: 		n = 1;
	MOVLW       1
	MOVWF       MFRC522_ToCard_n_L0+0 
;rc522.h,651 :: 		}
L_MFRC522_ToCard37:
;rc522.h,652 :: 		if (n > MAX_LEN)
	MOVF        MFRC522_ToCard_n_L0+0, 0 
	SUBLW       16
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_ToCard38
;rc522.h,654 :: 		n = MAX_LEN;
	MOVLW       16
	MOVWF       MFRC522_ToCard_n_L0+0 
;rc522.h,655 :: 		}
L_MFRC522_ToCard38:
;rc522.h,658 :: 		for (i=0; i<n; i++)
	CLRF        MFRC522_ToCard_i_L0+0 
	CLRF        MFRC522_ToCard_i_L0+1 
L_MFRC522_ToCard39:
	MOVLW       0
	SUBWF       MFRC522_ToCard_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_ToCard126
	MOVF        MFRC522_ToCard_n_L0+0, 0 
	SUBWF       MFRC522_ToCard_i_L0+0, 0 
L__MFRC522_ToCard126:
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_ToCard40
;rc522.h,660 :: 		backData[i] = Read_MFRC522(FIFODataReg);
	MOVF        MFRC522_ToCard_i_L0+0, 0 
	ADDWF       FARG_MFRC522_ToCard_backData+0, 0 
	MOVWF       FLOC__MFRC522_ToCard+0 
	MOVF        MFRC522_ToCard_i_L0+1, 0 
	ADDWFC      FARG_MFRC522_ToCard_backData+1, 0 
	MOVWF       FLOC__MFRC522_ToCard+1 
	MOVLW       9
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVFF       FLOC__MFRC522_ToCard+0, FSR1L+0
	MOVFF       FLOC__MFRC522_ToCard+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,658 :: 		for (i=0; i<n; i++)
	INFSNZ      MFRC522_ToCard_i_L0+0, 1 
	INCF        MFRC522_ToCard_i_L0+1, 1 
;rc522.h,661 :: 		}
	GOTO        L_MFRC522_ToCard39
L_MFRC522_ToCard40:
;rc522.h,662 :: 		}
L_MFRC522_ToCard34:
;rc522.h,663 :: 		}
	GOTO        L_MFRC522_ToCard42
L_MFRC522_ToCard32:
;rc522.h,666 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_ToCard_status_L0+0 
;rc522.h,667 :: 		}
L_MFRC522_ToCard42:
;rc522.h,669 :: 		}
L_MFRC522_ToCard31:
;rc522.h,674 :: 		return status;
	MOVF        MFRC522_ToCard_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,675 :: 		}
L_end_MFRC522_ToCard:
	RETURN      0
; end of _MFRC522_ToCard

_MFRC522_Anticoll:

;rc522.h,684 :: 		uchar MFRC522_Anticoll(uchar *serNum)
;rc522.h,688 :: 		uchar serNumCheck=0;
	CLRF        MFRC522_Anticoll_serNumCheck_L0+0 
;rc522.h,694 :: 		Write_MFRC522(BitFramingReg, 0x00);                //TxLastBists = BitFramingReg[2..0]
	MOVLW       13
	MOVWF       FARG_Write_MFRC522_addr+0 
	CLRF        FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,696 :: 		serNum[0] = PICC_ANTICOLL;
	MOVFF       FARG_MFRC522_Anticoll_serNum+0, FSR1L+0
	MOVFF       FARG_MFRC522_Anticoll_serNum+1, FSR1H+0
	MOVLW       147
	MOVWF       POSTINC1+0 
;rc522.h,697 :: 		serNum[1] = 0x20;
	MOVLW       1
	ADDWF       FARG_MFRC522_Anticoll_serNum+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Anticoll_serNum+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;rc522.h,698 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, serNum, 2, serNum, &unLen);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVF        FARG_MFRC522_Anticoll_serNum+0, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVF        FARG_MFRC522_Anticoll_serNum+1, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       2
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVF        FARG_MFRC522_Anticoll_serNum+0, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVF        FARG_MFRC522_Anticoll_serNum+1, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Anticoll_unLen_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Anticoll_unLen_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Anticoll_status_L0+0 
;rc522.h,700 :: 		if (status == MI_OK)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_Anticoll43
;rc522.h,703 :: 		for (i=0; i<4; i++)
	CLRF        MFRC522_Anticoll_i_L0+0 
L_MFRC522_Anticoll44:
	MOVLW       4
	SUBWF       MFRC522_Anticoll_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_Anticoll45
;rc522.h,705 :: 		serNumCheck ^= serNum[i];
	MOVF        MFRC522_Anticoll_i_L0+0, 0 
	ADDWF       FARG_MFRC522_Anticoll_serNum+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Anticoll_serNum+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	XORWF       MFRC522_Anticoll_serNumCheck_L0+0, 1 
;rc522.h,703 :: 		for (i=0; i<4; i++)
	INCF        MFRC522_Anticoll_i_L0+0, 1 
;rc522.h,706 :: 		}
	GOTO        L_MFRC522_Anticoll44
L_MFRC522_Anticoll45:
;rc522.h,707 :: 		if (serNumCheck != serNum[i])
	MOVF        MFRC522_Anticoll_i_L0+0, 0 
	ADDWF       FARG_MFRC522_Anticoll_serNum+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Anticoll_serNum+1, 0 
	MOVWF       FSR2L+1 
	MOVF        MFRC522_Anticoll_serNumCheck_L0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_MFRC522_Anticoll47
;rc522.h,709 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Anticoll_status_L0+0 
;rc522.h,710 :: 		}
L_MFRC522_Anticoll47:
;rc522.h,711 :: 		}
L_MFRC522_Anticoll43:
;rc522.h,715 :: 		return status;
	MOVF        MFRC522_Anticoll_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,716 :: 		}
L_end_MFRC522_Anticoll:
	RETURN      0
; end of _MFRC522_Anticoll

_CalulateCRC:

;rc522.h,723 :: 		void CalulateCRC(uchar *pIndata, uchar len, uchar *pOutData)
;rc522.h,727 :: 		ClearBitMask(DivIrqReg, 0x04);                        //CRCIrq = 0
	MOVLW       5
	MOVWF       FARG_ClearBitMask_reg+0 
	MOVLW       4
	MOVWF       FARG_ClearBitMask_mask+0 
	CALL        _ClearBitMask+0, 0
;rc522.h,728 :: 		SetBitMask(FIFOLevelReg, 0x80);                        //Clear the FIFO pointer
	MOVLW       10
	MOVWF       FARG_SetBitMask_reg+0 
	MOVLW       128
	MOVWF       FARG_SetBitMask_mask+0 
	CALL        _SetBitMask+0, 0
;rc522.h,732 :: 		for (i=0; i<len; i++)
	CLRF        CalulateCRC_i_L0+0 
L_CalulateCRC48:
	MOVF        FARG_CalulateCRC_len+0, 0 
	SUBWF       CalulateCRC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CalulateCRC49
;rc522.h,734 :: 		Write_MFRC522(FIFODataReg, *(pIndata+i));
	MOVLW       9
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVF        CalulateCRC_i_L0+0, 0 
	ADDWF       FARG_CalulateCRC_pIndata+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_CalulateCRC_pIndata+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,732 :: 		for (i=0; i<len; i++)
	INCF        CalulateCRC_i_L0+0, 1 
;rc522.h,735 :: 		}
	GOTO        L_CalulateCRC48
L_CalulateCRC49:
;rc522.h,736 :: 		Write_MFRC522(CommandReg, PCD_CALCCRC);
	MOVLW       1
	MOVWF       FARG_Write_MFRC522_addr+0 
	MOVLW       3
	MOVWF       FARG_Write_MFRC522_val+0 
	CALL        _Write_MFRC522+0, 0
;rc522.h,739 :: 		i = 0xFF;
	MOVLW       255
	MOVWF       CalulateCRC_i_L0+0 
;rc522.h,740 :: 		do
L_CalulateCRC51:
;rc522.h,742 :: 		n = Read_MFRC522(DivIrqReg);
	MOVLW       5
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVF        R0, 0 
	MOVWF       CalulateCRC_n_L0+0 
;rc522.h,743 :: 		i--;
	DECF        CalulateCRC_i_L0+0, 1 
;rc522.h,745 :: 		while ((i!=0) && !(n&0x04));                        //CRCIrq = 1
	MOVF        CalulateCRC_i_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__CalulateCRC95
	BTFSC       CalulateCRC_n_L0+0, 2 
	GOTO        L__CalulateCRC95
	GOTO        L_CalulateCRC51
L__CalulateCRC95:
;rc522.h,748 :: 		pOutData[0] = Read_MFRC522(CRCResultRegL);
	MOVF        FARG_CalulateCRC_pOutData+0, 0 
	MOVWF       FLOC__CalulateCRC+0 
	MOVF        FARG_CalulateCRC_pOutData+1, 0 
	MOVWF       FLOC__CalulateCRC+1 
	MOVLW       34
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVFF       FLOC__CalulateCRC+0, FSR1L+0
	MOVFF       FLOC__CalulateCRC+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,749 :: 		pOutData[1] = Read_MFRC522(CRCResultRegM);
	MOVLW       1
	ADDWF       FARG_CalulateCRC_pOutData+0, 0 
	MOVWF       FLOC__CalulateCRC+0 
	MOVLW       0
	ADDWFC      FARG_CalulateCRC_pOutData+1, 0 
	MOVWF       FLOC__CalulateCRC+1 
	MOVLW       33
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	MOVFF       FLOC__CalulateCRC+0, FSR1L+0
	MOVFF       FLOC__CalulateCRC+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,750 :: 		}
L_end_CalulateCRC:
	RETURN      0
; end of _CalulateCRC

_MFRC522_SelectTag:

;rc522.h,757 :: 		uchar MFRC522_SelectTag(uchar *serNum)
;rc522.h,767 :: 		buffer[0] = PICC_SElECTTAG;
	MOVLW       147
	MOVWF       MFRC522_SelectTag_buffer_L0+0 
;rc522.h,768 :: 		buffer[1] = 0x70;
	MOVLW       112
	MOVWF       MFRC522_SelectTag_buffer_L0+1 
;rc522.h,769 :: 		for (i=0; i<5; i++)
	CLRF        MFRC522_SelectTag_i_L0+0 
L_MFRC522_SelectTag56:
	MOVLW       5
	SUBWF       MFRC522_SelectTag_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_SelectTag57
;rc522.h,771 :: 		buffer[i+2] = *(serNum+i);
	MOVLW       2
	ADDWF       MFRC522_SelectTag_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       MFRC522_SelectTag_buffer_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(MFRC522_SelectTag_buffer_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        MFRC522_SelectTag_i_L0+0, 0 
	ADDWF       FARG_MFRC522_SelectTag_serNum+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_SelectTag_serNum+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,769 :: 		for (i=0; i<5; i++)
	INCF        MFRC522_SelectTag_i_L0+0, 1 
;rc522.h,772 :: 		}
	GOTO        L_MFRC522_SelectTag56
L_MFRC522_SelectTag57:
;rc522.h,773 :: 		CalulateCRC(buffer, 7, &buffer[7]);                //??
	MOVLW       MFRC522_SelectTag_buffer_L0+0
	MOVWF       FARG_CalulateCRC_pIndata+0 
	MOVLW       hi_addr(MFRC522_SelectTag_buffer_L0+0)
	MOVWF       FARG_CalulateCRC_pIndata+1 
	MOVLW       7
	MOVWF       FARG_CalulateCRC_len+0 
	MOVLW       MFRC522_SelectTag_buffer_L0+7
	MOVWF       FARG_CalulateCRC_pOutData+0 
	MOVLW       hi_addr(MFRC522_SelectTag_buffer_L0+7)
	MOVWF       FARG_CalulateCRC_pOutData+1 
	CALL        _CalulateCRC+0, 0
;rc522.h,774 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, buffer, 9, buffer, &recvBits);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVLW       MFRC522_SelectTag_buffer_L0+0
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVLW       hi_addr(MFRC522_SelectTag_buffer_L0+0)
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       9
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVLW       MFRC522_SelectTag_buffer_L0+0
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVLW       hi_addr(MFRC522_SelectTag_buffer_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_SelectTag_recvBits_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_SelectTag_recvBits_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
;rc522.h,776 :: 		if ((status == MI_OK) && (recvBits == 0x18))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_SelectTag61
	MOVLW       0
	XORWF       MFRC522_SelectTag_recvBits_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_SelectTag130
	MOVLW       24
	XORWF       MFRC522_SelectTag_recvBits_L0+0, 0 
L__MFRC522_SelectTag130:
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_SelectTag61
L__MFRC522_SelectTag96:
;rc522.h,778 :: 		size = buffer[0];
	MOVF        MFRC522_SelectTag_buffer_L0+0, 0 
	MOVWF       MFRC522_SelectTag_size_L0+0 
;rc522.h,779 :: 		}
	GOTO        L_MFRC522_SelectTag62
L_MFRC522_SelectTag61:
;rc522.h,782 :: 		size = 0;
	CLRF        MFRC522_SelectTag_size_L0+0 
;rc522.h,783 :: 		}
L_MFRC522_SelectTag62:
;rc522.h,785 :: 		return size;
	MOVF        MFRC522_SelectTag_size_L0+0, 0 
	MOVWF       R0 
;rc522.h,786 :: 		}
L_end_MFRC522_SelectTag:
	RETURN      0
; end of _MFRC522_SelectTag

_MFRC522_Auth:

;rc522.h,798 :: 		uchar MFRC522_Auth(uchar authMode, uchar BlockAddr, uchar *Sectorkey, uchar *serNum)
;rc522.h,806 :: 		buff[0] = authMode;
	MOVF        FARG_MFRC522_Auth_authMode+0, 0 
	MOVWF       MFRC522_Auth_buff_L0+0 
;rc522.h,807 :: 		buff[1] = BlockAddr;
	MOVF        FARG_MFRC522_Auth_BlockAddr+0, 0 
	MOVWF       MFRC522_Auth_buff_L0+1 
;rc522.h,808 :: 		for (i=0; i<6; i++)
	CLRF        MFRC522_Auth_i_L0+0 
L_MFRC522_Auth63:
	MOVLW       6
	SUBWF       MFRC522_Auth_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_Auth64
;rc522.h,810 :: 		buff[i+2] = *(Sectorkey+i);
	MOVLW       2
	ADDWF       MFRC522_Auth_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       MFRC522_Auth_buff_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(MFRC522_Auth_buff_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        MFRC522_Auth_i_L0+0, 0 
	ADDWF       FARG_MFRC522_Auth_Sectorkey+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Auth_Sectorkey+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,808 :: 		for (i=0; i<6; i++)
	INCF        MFRC522_Auth_i_L0+0, 1 
;rc522.h,811 :: 		}
	GOTO        L_MFRC522_Auth63
L_MFRC522_Auth64:
;rc522.h,812 :: 		for (i=0; i<4; i++)
	CLRF        MFRC522_Auth_i_L0+0 
L_MFRC522_Auth66:
	MOVLW       4
	SUBWF       MFRC522_Auth_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_Auth67
;rc522.h,814 :: 		buff[i+8] = *(serNum+i);
	MOVLW       8
	ADDWF       MFRC522_Auth_i_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       MFRC522_Auth_buff_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(MFRC522_Auth_buff_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        MFRC522_Auth_i_L0+0, 0 
	ADDWF       FARG_MFRC522_Auth_serNum+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Auth_serNum+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,812 :: 		for (i=0; i<4; i++)
	INCF        MFRC522_Auth_i_L0+0, 1 
;rc522.h,815 :: 		}
	GOTO        L_MFRC522_Auth66
L_MFRC522_Auth67:
;rc522.h,816 :: 		status = MFRC522_ToCard(PCD_AUTHENT, buff, 12, buff, &recvBits);
	MOVLW       14
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVLW       MFRC522_Auth_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVLW       hi_addr(MFRC522_Auth_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVLW       MFRC522_Auth_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVLW       hi_addr(MFRC522_Auth_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Auth_recvBits_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Auth_recvBits_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Auth_status_L0+0 
;rc522.h,818 :: 		if ((status != MI_OK) || (!(Read_MFRC522(Status2Reg) & 0x08)))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Auth97
	MOVLW       8
	MOVWF       FARG_Read_MFRC522_addr+0 
	CALL        _Read_MFRC522+0, 0
	BTFSS       R0, 3 
	GOTO        L__MFRC522_Auth97
	GOTO        L_MFRC522_Auth71
L__MFRC522_Auth97:
;rc522.h,820 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Auth_status_L0+0 
;rc522.h,821 :: 		}
L_MFRC522_Auth71:
;rc522.h,823 :: 		return status;
	MOVF        MFRC522_Auth_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,824 :: 		}
L_end_MFRC522_Auth:
	RETURN      0
; end of _MFRC522_Auth

_MFRC522_Read:

;rc522.h,831 :: 		uchar MFRC522_Read(uchar blockAddr, uchar *recvData)
;rc522.h,836 :: 		recvData[0] = PICC_READ;
	MOVFF       FARG_MFRC522_Read_recvData+0, FSR1L+0
	MOVFF       FARG_MFRC522_Read_recvData+1, FSR1H+0
	MOVLW       48
	MOVWF       POSTINC1+0 
;rc522.h,837 :: 		recvData[1] = blockAddr;
	MOVLW       1
	ADDWF       FARG_MFRC522_Read_recvData+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Read_recvData+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_MFRC522_Read_blockAddr+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,838 :: 		CalulateCRC(recvData,2, &recvData[2]);
	MOVF        FARG_MFRC522_Read_recvData+0, 0 
	MOVWF       FARG_CalulateCRC_pIndata+0 
	MOVF        FARG_MFRC522_Read_recvData+1, 0 
	MOVWF       FARG_CalulateCRC_pIndata+1 
	MOVLW       2
	MOVWF       FARG_CalulateCRC_len+0 
	MOVLW       2
	ADDWF       FARG_MFRC522_Read_recvData+0, 0 
	MOVWF       FARG_CalulateCRC_pOutData+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Read_recvData+1, 0 
	MOVWF       FARG_CalulateCRC_pOutData+1 
	CALL        _CalulateCRC+0, 0
;rc522.h,839 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, recvData, 4, recvData, &unLen);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVF        FARG_MFRC522_Read_recvData+0, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVF        FARG_MFRC522_Read_recvData+1, 0 
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       4
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVF        FARG_MFRC522_Read_recvData+0, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVF        FARG_MFRC522_Read_recvData+1, 0 
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Read_unLen_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Read_unLen_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Read_status_L0+0 
;rc522.h,841 :: 		if ((status != MI_OK) || (unLen != 0x90))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Read98
	MOVLW       0
	XORWF       MFRC522_Read_unLen_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Read133
	MOVLW       144
	XORWF       MFRC522_Read_unLen_L0+0, 0 
L__MFRC522_Read133:
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Read98
	GOTO        L_MFRC522_Read74
L__MFRC522_Read98:
;rc522.h,843 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Read_status_L0+0 
;rc522.h,844 :: 		}
L_MFRC522_Read74:
;rc522.h,846 :: 		return status;
	MOVF        MFRC522_Read_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,847 :: 		}
L_end_MFRC522_Read:
	RETURN      0
; end of _MFRC522_Read

_MFRC522_Write:

;rc522.h,854 :: 		uchar MFRC522_Write(uchar blockAddr, uchar *writeData)
;rc522.h,861 :: 		buff[0] = PICC_WRITE;
	MOVLW       160
	MOVWF       MFRC522_Write_buff_L0+0 
;rc522.h,862 :: 		buff[1] = blockAddr;
	MOVF        FARG_MFRC522_Write_blockAddr+0, 0 
	MOVWF       MFRC522_Write_buff_L0+1 
;rc522.h,863 :: 		CalulateCRC(buff, 2, &buff[2]);
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_CalulateCRC_pIndata+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_CalulateCRC_pIndata+1 
	MOVLW       2
	MOVWF       FARG_CalulateCRC_len+0 
	MOVLW       MFRC522_Write_buff_L0+2
	MOVWF       FARG_CalulateCRC_pOutData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+2)
	MOVWF       FARG_CalulateCRC_pOutData+1 
	CALL        _CalulateCRC+0, 0
;rc522.h,864 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, buff, 4, buff, &recvBits);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       4
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Write_recvBits_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Write_recvBits_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Write_status_L0+0 
;rc522.h,866 :: 		if ((status != MI_OK) || (recvBits != 4) || ((buff[0] & 0x0F) != 0x0A))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write100
	MOVLW       0
	XORWF       MFRC522_Write_recvBits_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write135
	MOVLW       4
	XORWF       MFRC522_Write_recvBits_L0+0, 0 
L__MFRC522_Write135:
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write100
	MOVLW       15
	ANDWF       MFRC522_Write_buff_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write100
	GOTO        L_MFRC522_Write77
L__MFRC522_Write100:
;rc522.h,868 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Write_status_L0+0 
;rc522.h,869 :: 		}
L_MFRC522_Write77:
;rc522.h,871 :: 		if (status == MI_OK)
	MOVF        MFRC522_Write_status_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MFRC522_Write78
;rc522.h,873 :: 		for (i=0; i<16; i++)                //Data to the FIFO write 16Byte
	CLRF        MFRC522_Write_i_L0+0 
L_MFRC522_Write79:
	MOVLW       16
	SUBWF       MFRC522_Write_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MFRC522_Write80
;rc522.h,875 :: 		buff[i] = *(writeData+i);
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FSR1L+1 
	MOVF        MFRC522_Write_i_L0+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        MFRC522_Write_i_L0+0, 0 
	ADDWF       FARG_MFRC522_Write_writeData+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_MFRC522_Write_writeData+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;rc522.h,873 :: 		for (i=0; i<16; i++)                //Data to the FIFO write 16Byte
	INCF        MFRC522_Write_i_L0+0, 1 
;rc522.h,876 :: 		}
	GOTO        L_MFRC522_Write79
L_MFRC522_Write80:
;rc522.h,877 :: 		CalulateCRC(buff, 16, &buff[16]);
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_CalulateCRC_pIndata+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_CalulateCRC_pIndata+1 
	MOVLW       16
	MOVWF       FARG_CalulateCRC_len+0 
	MOVLW       MFRC522_Write_buff_L0+16
	MOVWF       FARG_CalulateCRC_pOutData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+16)
	MOVWF       FARG_CalulateCRC_pOutData+1 
	CALL        _CalulateCRC+0, 0
;rc522.h,878 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, buff, 18, buff, &recvBits);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       18
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVLW       MFRC522_Write_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVLW       hi_addr(MFRC522_Write_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Write_recvBits_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Write_recvBits_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
	MOVF        R0, 0 
	MOVWF       MFRC522_Write_status_L0+0 
;rc522.h,880 :: 		if ((status != MI_OK) || (recvBits != 4) || ((buff[0] & 0x0F) != 0x0A))
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write99
	MOVLW       0
	XORWF       MFRC522_Write_recvBits_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write136
	MOVLW       4
	XORWF       MFRC522_Write_recvBits_L0+0, 0 
L__MFRC522_Write136:
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write99
	MOVLW       15
	ANDWF       MFRC522_Write_buff_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L__MFRC522_Write99
	GOTO        L_MFRC522_Write84
L__MFRC522_Write99:
;rc522.h,882 :: 		status = MI_ERR;
	MOVLW       2
	MOVWF       MFRC522_Write_status_L0+0 
;rc522.h,883 :: 		}
L_MFRC522_Write84:
;rc522.h,884 :: 		}
L_MFRC522_Write78:
;rc522.h,886 :: 		return status;
	MOVF        MFRC522_Write_status_L0+0, 0 
	MOVWF       R0 
;rc522.h,887 :: 		}
L_end_MFRC522_Write:
	RETURN      0
; end of _MFRC522_Write

_MFRC522_Halt:

;rc522.h,894 :: 		void MFRC522_Halt(void)
;rc522.h,900 :: 		buff[0] = PICC_HALT;
	MOVLW       80
	MOVWF       MFRC522_Halt_buff_L0+0 
;rc522.h,901 :: 		buff[1] = 0;
	CLRF        MFRC522_Halt_buff_L0+1 
;rc522.h,902 :: 		CalulateCRC(buff, 2, &buff[2]);
	MOVLW       MFRC522_Halt_buff_L0+0
	MOVWF       FARG_CalulateCRC_pIndata+0 
	MOVLW       hi_addr(MFRC522_Halt_buff_L0+0)
	MOVWF       FARG_CalulateCRC_pIndata+1 
	MOVLW       2
	MOVWF       FARG_CalulateCRC_len+0 
	MOVLW       MFRC522_Halt_buff_L0+2
	MOVWF       FARG_CalulateCRC_pOutData+0 
	MOVLW       hi_addr(MFRC522_Halt_buff_L0+2)
	MOVWF       FARG_CalulateCRC_pOutData+1 
	CALL        _CalulateCRC+0, 0
;rc522.h,904 :: 		status = MFRC522_ToCard(PCD_TRANSCEIVE, buff, 4, buff,&unLen);
	MOVLW       12
	MOVWF       FARG_MFRC522_ToCard_command+0 
	MOVLW       MFRC522_Halt_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_sendData+0 
	MOVLW       hi_addr(MFRC522_Halt_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_sendData+1 
	MOVLW       4
	MOVWF       FARG_MFRC522_ToCard_sendLen+0 
	MOVLW       MFRC522_Halt_buff_L0+0
	MOVWF       FARG_MFRC522_ToCard_backData+0 
	MOVLW       hi_addr(MFRC522_Halt_buff_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backData+1 
	MOVLW       MFRC522_Halt_unLen_L0+0
	MOVWF       FARG_MFRC522_ToCard_backLen+0 
	MOVLW       hi_addr(MFRC522_Halt_unLen_L0+0)
	MOVWF       FARG_MFRC522_ToCard_backLen+1 
	CALL        _MFRC522_ToCard+0, 0
;rc522.h,905 :: 		}
L_end_MFRC522_Halt:
	RETURN      0
; end of _MFRC522_Halt

_Serial_println:

;RFID_MODULE.c,3 :: 		void Serial_println(char *s){
;RFID_MODULE.c,4 :: 		while(*s){
L_Serial_println85:
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_println86
;RFID_MODULE.c,5 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_println_s+0, FSR0L+0
	MOVFF       FARG_Serial_println_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_println_s+0, 1 
	INCF        FARG_Serial_println_s+1, 1 
;RFID_MODULE.c,6 :: 		}
	GOTO        L_Serial_println85
L_Serial_println86:
;RFID_MODULE.c,7 :: 		UART1_WRITE(0X0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;RFID_MODULE.c,8 :: 		}
L_end_Serial_println:
	RETURN      0
; end of _Serial_println

_Serial_print:

;RFID_MODULE.c,9 :: 		void Serial_print(char *s){
;RFID_MODULE.c,10 :: 		while(*s){
L_Serial_print87:
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Serial_print88
;RFID_MODULE.c,11 :: 		UART1_WRITE(*s++);
	MOVFF       FARG_Serial_print_s+0, FSR0L+0
	MOVFF       FARG_Serial_print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_Serial_print_s+0, 1 
	INCF        FARG_Serial_print_s+1, 1 
;RFID_MODULE.c,12 :: 		}
	GOTO        L_Serial_print87
L_Serial_print88:
;RFID_MODULE.c,13 :: 		}
L_end_Serial_print:
	RETURN      0
; end of _Serial_print

_main:

;RFID_MODULE.c,14 :: 		void main()
;RFID_MODULE.c,18 :: 		TRISB = 0B11111111;   // protection for ICSP TIME - W/ OUT MCLR - DON'T REMOVE THIS!
	MOVLW       255
	MOVWF       TRISB+0 
;RFID_MODULE.c,19 :: 		delay1ms(500);        // protection for ICSP TIME - W/ OUT MCLR - DON'T REMOVE THIS!
	MOVLW       244
	MOVWF       FARG_delay1ms_delayTime+0 
	MOVLW       1
	MOVWF       FARG_delay1ms_delayTime+1 
	CALL        _delay1ms+0, 0
;RFID_MODULE.c,20 :: 		TRISA = 0B00000000;
	CLRF        TRISA+0 
;RFID_MODULE.c,21 :: 		TRISB = 0B00000010;
	MOVLW       2
	MOVWF       TRISB+0 
;RFID_MODULE.c,22 :: 		ADCON1=15;
	MOVLW       15
	MOVWF       ADCON1+0 
;RFID_MODULE.c,23 :: 		INTCON = 0B11000000;
	MOVLW       192
	MOVWF       INTCON+0 
;RFID_MODULE.c,24 :: 		TRISC.F6=0;         //lcd back light
	BCF         TRISC+0, 6 
;RFID_MODULE.c,25 :: 		PORTC.F6=0;
	BCF         PORTC+0, 6 
;RFID_MODULE.c,26 :: 		Soft_SPI_Init();  // start the SPI library:
	CALL        _Soft_SPI_Init+0, 0
;RFID_MODULE.c,27 :: 		Chip_Select = 1;  // SlaveSelect (SS) RFID reader
	BSF         RA0_bit+0, BitPos(RA0_bit+0) 
;RFID_MODULE.c,28 :: 		MFRC522_Init();
	CALL        _MFRC522_Init+0, 0
;RFID_MODULE.c,29 :: 		while (1)  // loop forever
L_main89:
;RFID_MODULE.c,32 :: 		status = MFRC522_Request(PICC_REQIDL, str);
	MOVLW       38
	MOVWF       FARG_MFRC522_Request_reqMode+0 
	MOVLW       main_str_L0+0
	MOVWF       FARG_MFRC522_Request_TagType+0 
	MOVLW       hi_addr(main_str_L0+0)
	MOVWF       FARG_MFRC522_Request_TagType+1 
	CALL        _MFRC522_Request+0, 0
	MOVF        R0, 0 
	MOVWF       main_status_L0+0 
;RFID_MODULE.c,34 :: 		status = MFRC522_Anticoll(str);
	MOVLW       main_str_L0+0
	MOVWF       FARG_MFRC522_Anticoll_serNum+0 
	MOVLW       hi_addr(main_str_L0+0)
	MOVWF       FARG_MFRC522_Anticoll_serNum+1 
	CALL        _MFRC522_Anticoll+0, 0
	MOVF        R0, 0 
	MOVWF       main_status_L0+0 
;RFID_MODULE.c,35 :: 		memcpy(serNum, str, 5);
	MOVLW       _serNum+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_serNum+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       main_str_L0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(main_str_L0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       5
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;RFID_MODULE.c,37 :: 		if (status == MI_OK)   //if ther is a new card detected
	MOVF        main_status_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main91
;RFID_MODULE.c,39 :: 		SetFormatRDM630(void); // take serNum and format it and retern read
	CALL        _SetFormatRDM630+0, 0
;RFID_MODULE.c,40 :: 		Serial_print("ID: ");
	MOVLW       ?lstr1_RFID_MODULE+0
	MOVWF       FARG_Serial_print_s+0 
	MOVLW       hi_addr(?lstr1_RFID_MODULE+0)
	MOVWF       FARG_Serial_print_s+1 
	CALL        _Serial_print+0, 0
;RFID_MODULE.c,41 :: 		Serial_println(read);
	MOVLW       _read+0
	MOVWF       FARG_Serial_println_s+0 
	MOVLW       hi_addr(_read+0)
	MOVWF       FARG_Serial_println_s+1 
	CALL        _Serial_println+0, 0
;RFID_MODULE.c,42 :: 		}
	GOTO        L_main92
L_main91:
;RFID_MODULE.c,45 :: 		MFRC522_Halt();                       // Command card into hibernation
	CALL        _MFRC522_Halt+0, 0
;RFID_MODULE.c,46 :: 		delay1ms(50);                       // wait for low consuption
	MOVLW       50
	MOVWF       FARG_delay1ms_delayTime+0 
	MOVLW       0
	MOVWF       FARG_delay1ms_delayTime+1 
	CALL        _delay1ms+0, 0
;RFID_MODULE.c,47 :: 		}
L_main92:
;RFID_MODULE.c,49 :: 		}
	GOTO        L_main89
;RFID_MODULE.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
