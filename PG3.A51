;*******************************PROGRAM OBJECTIVE******************************
;MOVE A SINGLE LED FROM LEFT TO RIGHT AND RIGHT TO LEFT ON THE P1. SET THE
;MOVING SPEED OF 4 COUNTS PER SECOND.

org 00h
START:
        MOV A,#0FEH
        MOV R7,#8
LEFT:
        MOV P1,A
        RL A
        CALL DELAY
        DJNZ R7,LEFT
        MOV A,#7FH
        MOV R7,#8
RIGHT:
        MOV P1,A
        RR A
        CALL DELAY
        DJNZ R7,RIGHT
        JMP START
DELAY:
        mov R1,#2
Y:
        mov R2,#100
X:
        mov R3,#250
        djnz R3,$
        djnz R2,X
        djnz R1,Y
ret
end
