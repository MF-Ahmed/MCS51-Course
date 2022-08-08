;************THIS PROGRAM IS MADE FOR THE TESTING OF LCD MODULE**************
RS_LCD          BIT P3.3
E_LCD           BIT P3.4
RW_LCD          BIT P3.5
ERR_LED         BIT P1.1
LCD             EQU P0
LCD_CHR         EQU 44H
COM_STR_PTR     EQU 45H

ORG 000h
            CLR     E_LCD
            CLR     RS_LCD
            CLR     RW_LCD
            CALL    INIT_LCD
            CALL    DELAY_15ms
AGAIN:
            MOV     DPTR,#STRT_MES
            CALL    SHOW_COMM
            CALL    DELAY_1s
            CPL     P1.0    
            JMP     AGAIN
;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
SHOW_COMM:
                        MOV     COM_STR_PTR,#0FFH
COMM_AGN:
        		INC  	COM_STR_PTR
        		MOV  	A,COM_STR_PTR
        		MOVC 	A,@A+DPTR
        		CJNE 	A,#'$',COMM_AGN1
                        JMP  	EXIT_SHOW_COM
COMM_AGN1:
        		MOV  	LCD,A
                        CALL    WR_LCD_DATA     ;WRite_LCD
        		JMP  	COMM_AGN
EXIT_SHOW_COM:
RET
;****************************************************************************

;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
INIT_LCD:
        MOV  R0,#03H
        MOV  LCD,#38H
INIT_LCD1:
        CALL DELAY_15ms
        CALL WR_LCD_COMMAND
        DJNZ R0,INIT_LCD1
        
        MOV  LCD,#38H
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  LCD,#0EH
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  LCD,#01H
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  LCD,#06H
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY
RET
;****************************************************************************

;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
WR_LCD_COMMAND:
        CLR  RS_LCD
        CLR  RW_LCD
        SETB E_LCD
        CLR  E_LCD
RET
;****************************************************************************

;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
WR_LCD_DATA:
        SETB RS_LCD
        CLR  RW_LCD
        SETB E_LCD
        CLR  E_LCD
        CALL CHK_LCD_BUSY
RET
;****************************************************************************
        
;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
RD_LCD_DATA:
        MOV  LCD,#0FFH
        SETB RS_LCD
        SETB RW_LCD
        SETB E_LCD
        MOV  LCD_CHR,LCD
        CLR  E_LCD
        CALL CHK_LCD_BUSY
RET
;****************************************************************************

;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
CHK_LCD_BUSY:
        MOV  LCD,#0FFH
        CLR  RS_LCD
        SETB RW_LCD
        MOV  R0,#0FH
CHK_AGN:
        SETB E_LCD
        MOV  A,LCD
        CLR  E_LCD
        JNB  ACC.7,EXIT_CHK_LCD
        DJNZ R0,CHK_AGN
        CPL  ERR_LED
EXIT_CHK_LCD:
RET
;****************************************************************************

;****************************************************************************
DELAY_1s:
                MOV     R0,#10
X2:
                MOV     R1,#200
Y3:
        		MOV  	R2,#250
        		DJNZ 	R2,$
        		DJNZ 	R1,Y3
        		DJNZ 	R0,X2
RET
;****************************************************************************

;****************************************************************************
DELAY_15ms:
        		MOV  	R1,#30
Y2:
        		MOV  	R2,#250
        		DJNZ 	R2,$
        		DJNZ 	R1,Y2
RET
;****************************************************************************

STRT_MES: DB 'TESTING MESSAGE ABC$'
end
