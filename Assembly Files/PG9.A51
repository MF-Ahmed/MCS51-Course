;*******************************PROGRAM OBJECTIVE******************************
;ENTER THE 7 SEGMENT CODE ON 4 DIGIT 7 SEGMENT DISPLAY WHEN A KEY IS PRESSED
;ON THE HEX KEYPAD. THE CODE OF A NEW KEY SHOULD BE ENTERED FROM RIGHT SIDE OF
;THE DISPLAY AND THE PREVIOUS DATA WILL ALSO BE SHIFTED.

org 000h
    jmp main
org 00Bh
    jmp ref_display
org 030h
main:
    mov dptr,#200h
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
again:
    call delay_400ms
    jnc again
    mov 33h,32h
    mov 32h,31h
    mov 31h,30h
key0:
    cjne a,#87h,key1
    mov 30h,#3fh
    jmp again
key1:
    cjne a,#47h,key2
    mov 30h,#06h
    jmp again
key2:
    cjne a,#27h,key3
    mov 30h,#5Bh
    jmp again
key3:
    cjne a,#17h,key4
    mov 30h,#4fh
    jmp again
key4:
    cjne a,#8bh,key5
    mov 30h,#66h
    jmp again
key5:
    cjne a,#4bh,key6
    mov 30h,#6Dh
    jmp again
key6:
    cjne a,#2bh,key7
    mov 30h,#7Dh
    jmp again
key7:
    cjne a,#1bh,key8
    mov 30h,#07h
    jmp again
key8:
    cjne a,#8dh,key9
    mov 30h,#7Fh
    jmp again
key9:
    cjne a,#4dh,keyA
    mov 30h,#6Fh
    jmp again
keyA:
    cjne a,#2dh,keyB
    mov 30h,#77h
    jmp again
keyB:
    cjne a,#1dh,keyC
    mov 30h,#7Ch
    jmp again
keyC:
    cjne a,#8eh,keyD
    mov 30h,#39h
    jmp again
keyD:
    cjne a,#4eh,keyE
    mov 30h,#5Eh
    jmp again
keyE:
    cjne a,#2eh,keyF
    mov 30h,#79h
    jmp again
keyF:
    mov 30h,#71h
    jmp again

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
    mov r7,#50
    djnz r7,$
    mov a,p2
    anl a,#0fh
    cjne a,#0fh,key_press
    clr c
    reti
key_press:
    setb c
    mov a,p2
reti

delay_400ms:
    mov r2,#4
y:
    mov r1,#200
x:
    mov r0,#250
    djnz r0,$
    djnz r1,x
    djnz r2,y
ret
end
