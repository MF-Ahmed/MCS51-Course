;*******************************PROGRAM OBJECTIVE******************************
;GENERATE THE CLOCK PULSES OF 30 Hz AT P1.0 BY USING TIMER 0.

ORG 000H
JMP MAIN
org 00BH
JMP CLOCK
org 030H
MAIN:
      MOV TMOD,#01H
      MOV TH0,HIGH(-15000)
      MOV TL0,LOW(-15000)
      SETB EA
      SETB ET0
      SETB TR0
      JMP $
CLOCK:
      CPL P1.0 
      MOV TH0,HIGH(-15000)
      MOV TL0,LOW(-15000)
      RETI
END
