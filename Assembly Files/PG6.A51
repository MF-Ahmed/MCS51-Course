;*******************************PROGRAM OBJECTIVE******************************
;DISPLAY THE CONSTANT NUMBER 1234 ON THE 4 DIGIT 7 SEGMENT DISPLAY BY USING
;TIMER.

org 000h
jmp main
org 0b0h
jmp ref_display
org 030h
main:
mov TMOD,#01h
mov TL0,#low(-2500)
mov TH0,#high(-2500)
    setb EA
    setb ET0
    setb TR0
    mov 30h,#66h
    mov 31h,#4fh
    mov 32h,#5bh
    mov 33h,#06h
    jmp $

ref_display:
    jnb p2.4,chk_dig2
    clr p2.4
    setb p2.5
    mov p0,31h
    jmp exit
chk_dig2:
    jnb p2.5,chk_dig3
    clr p2.5
    setb p2.6
    mov p0,32h
    jmp exit
chk_dig3:
    jnb p2.6,chk_dig4
    clr p2.6
    setb p2.7
    mov p0,33h
    jmp exit
chk_dig4:
    clr p2.7
    setb p2.4
    mov p0,30h
exit:
mov TL0,#low(-2500)
mov TH0,#high(-2500)
    RETI
end
