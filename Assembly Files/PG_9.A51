ORG 00H
JMP MAIN
org 0BH
JMP TIMER_0
org 30H
MAIN:
      SETB EA
      SETB ET0
      SETB TR0
      MOV TMOD,#01H
      MOV TL0,#LOW(-50000)
      MOV TH0,#HIGH(-50000)
      JMP $
TIMER_0:
      MOV TL0,#LOW(-50000)
      MOV TH0,#HIGH(-50000)     
      INC R0
      CJNE R0,#10,SKIP
      MOV R0,#00
      CPL P1.0
    SKIP:
      INC R1
      CJNE R1,#100,SKIP_1
      MOV R1,#00
      CPL P1.1 
    SKIP_1:
      RETI
END
