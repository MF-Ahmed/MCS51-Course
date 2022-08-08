;*******************************PROGRAM OBJECTIVE******************************
;DISPLAY 16 BIT HEXADECIMAL NUMBER ON THE 4 DIGIT 7 SEGMENT WITH INCREASING OR
;DECREASING SPEED OF 20 COUNTS PER SECOND USING BUTTONS AT P2.1 OR P2.2

org 000h
    jmp main
org 00Bh
    jmp ref_display
org 030h
main:
    mov dptr,#400h
    mov TMOD,#01h
    mov TL0,#low(-2500)
    mov TH0,#high(-2500)
    setb TR0
    setb EA
    setb ET0
    mov 30h,#3Fh
    mov 31h,#3Fh
    mov 32h,#3Fh
    mov 33h,#3Fh

increase:
    jb p2.1,decrease
    inc r6
    cjne r6,#00h,skip
    inc r7
skip:
    call update_codes
    call delay
    jmp increase

decrease:
    jb p2.2,increase
    dec r6
    cjne r6,#0ffh,skip1
    dec r7
skip1:
    call update_codes
    call delay
    jmp decrease

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

update_codes:
    mov A,r6
    anl A,#0Fh
    movc A,@A+DPTR
    mov 30h,A
    mov A,r6
    anl A,#0F0h
    swap A
    movc A,@A+DPTR
    mov 31h,A
    mov A,r7
    anl A,#0Fh
    movc A,@A+DPTR
    mov 32h,A
    mov A,r7
    anl A,#0F0h
    swap A
    movc A,@A+DPTR
    mov 33h,A
ret

delay:
    mov r0,#100
x:
    mov r1,#250
    djnz r1,$
    djnz r0,x
ret

org 400h
seg_data: db 3Fh,06h,5Bh,4Fh,66h,6Dh,7Dh,07h,7Fh,6Fh,77h,7Ch,39h,5Eh,79h,71h
end
