;*******************************PROGRAM OBJECTIVE******************************
;GENERATE THE BINARY PATERN IN INCREASING ORDER ON THE LEDs CONNECTED AT PORT1
;SET THE INCREASING SPEED OF 2 COUNTS PER SECOND.

org 00h
MAIN:
        cpl A
        mov p1,A
        cpl A
        call DELAY
        inc A
        jmp MAIN
DELAY:
        mov R1,#5
Y:
        mov R2,#200
X:
        mov R3,#250
        djnz R3,$
        djnz R2,X
        djnz R1,Y
ret
end
