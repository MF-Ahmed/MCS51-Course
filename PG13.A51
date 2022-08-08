;*******************************PROGRAM OBJECTIVE******************************
;TRANSMIT THE ASCII CODES OF KES IN THE PROGRAM PG9.A51 ON SERIAL PORT USING
;THE BAUD RATE OF 9600 BPS. (SUPPOSE THE CRYSTAL FREQUENCY IS 11.0592 MHz.)



RS_LCD  BIT P3.3
E_LCD   BIT P3.4
RW_LCD  BIT P3.5
KEY     BIT 00H
KEY_UP  BIT 01H
LCD_CHR EQU 30H
KEY_COD EQU 31H
ORG 000H
    CLR  P2.4
    CLR  P2.5
    CLR  P2.6
    CLR  P2.7
    CLR  E_LCD
    CLR  RS_LCD
    CLR  RW_LCD
    CALL INIT_LCD
    MOV  DPTR,#0400H
begin:
    jb   P3.6,$
    jnb  P3.6,$

    mov  R7,#8
start:
    jb   P3.6,$
    mov  c,P3.7
    rrc  A
    jnb  P3.6,$
    djnz R7,start
    jb   P3.6,$
    jnb  P3.6,$
    jb   P3.6,$
    jnb  P3.6,$

    cpl  A
    mov  P1,A
    CPL  A
    MOVC A,@A+DPTR

    JNB  KEY_UP,CHK_KEY
    CLR  KEY_UP
    JMP  BEGIN
CHK_KEY:
    JNB  KEY,CHK_COD
    CJNE A,#0F0H,KEY_PRESS
    SETB KEY_UP
    CLR  KEY
    JMP  BEGIN
KEY_PRESS:
    MOV  P0,A
    CALL WR_LCD_DATA
    JMP  BEGIN
CHK_COD:
    CJNE A,#00H,CHK_INV_KEY
    JMP  BEGIN
CHK_INV_KEY:
    CJNE A,#0F0H,VALID_KEY
    JMP  BEGIN
VALID_KEY:
    SETB KEY
    MOV  P0,A
    CALL WR_LCD_DATA
    JMP  BEGIN
;**********************INITIALLIZATION OF LCD DISPLAY************************
;PURPOSE:                       A SUBROUTINE TO INITIALLIZE 20X4 LCD DISPLAY
;REQUIRE EXECUTION TIME:        15ms
;USES (VARIABLES):              NON
;USES (SUBROUTINES):            DELAY_15ms, DELAY_50us
;DISTROYS:                      NON
;****************************************************************************
INIT_LCD:
        CALL DELAY_15ms
        MOV  P0,#30H
        CALL WR_LCD_COMMAND
        CALL DELAY_15ms
        
        CALL WR_LCD_COMMAND
        CALL DELAY_15ms

        CALL WR_LCD_COMMAND
        CALL DELAY_15ms

        MOV  P0,#30H
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  P0,#0FH
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  P0,#01H
        CALL WR_LCD_COMMAND
        CALL CHK_LCD_BUSY

        MOV  P0,#06H
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
        MOV  P0,#0FFH
        SETB RS_LCD
        SETB RW_LCD
        SETB E_LCD
        MOV  LCD_CHR,P0
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
        MOV  P0,#0FFH
        CLR  RS_LCD
        SETB RW_LCD
CHK_AGN:
        SETB E_LCD
        MOV  A,P0
        CLR  E_LCD
        JB   ACC.7,CHK_AGN
RET
;****************************************************************************

DELAY_1s:
        MOV  R0,#5
X:
        MOV  R1,#200
Y:
        MOV  R2,#250
        DJNZ R2,$
        DJNZ R1,Y
        DJNZ R0,X
RET

DELAY_15ms:
        MOV  R1,#30
Y1:
        MOV  R2,#250
        DJNZ R2,$
        DJNZ R1,Y1
RET
ORG 0400H
SC2SCI00H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI10H: DB 00H,00H,12H,00H,00H,00H,'1',00H,00H,00H,00H,00H,00H,00H,'2',00H
SC2SCI20H: DB 00H,00H,00H,00H,00H,'4','3',00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI30H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI40H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI50H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,59H,00H,00H,00H,00H,00H,00H
SC2SCI60H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI70H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI80H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCI90H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCIA0H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCIB0H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCIC0H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCID0H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCIE0H: DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
SC2SCIF0H: DB 0F0H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
END
