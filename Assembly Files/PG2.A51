;*******************************PROGRAM OBJECTIVE******************************
;GENERATE THE BINARY PATERN IN INCREASING/ DECREASING ORDER WHEN THE USER PRESSES
;THE BUTTONS AT P2.2/ P2.3. THE LEDs ARE CONNECTED AT PORT1. SET THE COUNTING
;SPEED OF 2 COUNTS PER SECOND.

org 00h
INCREASE:
        JB P2.3,DECREASE
        CPL A
        MOV P1,A
        CPL A
        INC A
        CALL DELAY
        JMP INCREASE
decrease:
        JB P2.2,INCREASE
        CPL A
        MOV P1,A
        CPL A
        DEC A
        CALL DELAY
        JMP DECREASE
DELAY:
        mov R1,#1
Y:
        mov R2,#200
X:
        mov R3,#250
        djnz R3,$
        djnz R2,X
        djnz R1,Y
ret
end
