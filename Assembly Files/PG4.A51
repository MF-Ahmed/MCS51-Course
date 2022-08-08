;*******************************PROGRAM OBJECTIVE******************************
;GENERATE THE 7 SEGMENT CODES OF HEXADECIMAL NOMBERS IN INCREASING ORDER ON THE
;LEAST SIGNIFICANT DIGIT OF 7 SEGMENT DISPLAY. SET THE INCREASING SPEED OF 1
;COUNT PER SECOND. USE CODE MEMORY FOR SEGMENT CODES.
org 000h
    clr p2.5
    clr p2.6
    clr p2.7
    mov dptr,#400h
    mov r7,#00h
again:
    mov a,r7
    anl A,#0Fh
    movc A,@A+DPTR
    mov P0,A
    inc r7
    call delay
    jmp again

DELAY:
        mov R1,#10
Y:
        mov R2,#200
X:
        mov R3,#250
        djnz R3,$
        djnz R2,X
        djnz R1,Y
ret
org 400h
seg_data: db 3Fh,06h,5Bh,4Fh,66h,6Dh,7Dh,07h,7Fh,6Fh,77h,7Ch,39h,5Eh,79h,71h
end
