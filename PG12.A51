;*******************************PROGRAM OBJECTIVE******************************
;TRANSMIT THE ASCII CODES OF KES IN THE PROGRAM PG9.A51 ON SERIAL PORT USING
;THE BAUD RATE OF 9600 BPS. (SUPPOSE THE CRYSTAL FREQUENCY IS 11.0592 MHz.)

org 000h
    jmp main
org 00Bh
    jmp ref_display
org 030h
main:
    mov scon,#40h
    mov tmod,#21h
    mov th1,#-3
    setb tr1
    mov dptr,#200h
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
    call delay_300ms
    jnc again
    mov 33h,32h
    mov 32h,31h
    mov 31h,30h
key0:
    cjne a,#87h,key1
    mov 30h,#3fh
    mov sbuf,#'0'
    jmp again
key1:
    cjne a,#47h,key2
    mov 30h,#06h
    mov sbuf,#'1'
    jmp again
key2:
    cjne a,#27h,key3
    mov 30h,#5Bh
    mov sbuf,#'2'
    jmp again
key3:
    cjne a,#17h,key4
    mov 30h,#4fh
    mov sbuf,#'3'
    jmp again
key4:
    cjne a,#8bh,key5
    mov 30h,#66h
    mov sbuf,#'4'
    jmp again
key5:
    cjne a,#4bh,key6
    mov 30h,#6Dh
    mov sbuf,#'5'
    jmp again
key6:
    cjne a,#2bh,key7
    mov 30h,#7Dh
    mov sbuf,#'6'
    jmp again
key7:
    cjne a,#1bh,key8
    mov 30h,#07h
    mov sbuf,#'7'
    jmp again
key8:
    cjne a,#8dh,key9
    mov 30h,#7Fh
    mov sbuf,#'8'
    jmp again
key9:
    cjne a,#4dh,keyA
    mov 30h,#6Fh
    mov sbuf,#'9'
    jmp again
keyA:
    cjne a,#2dh,keyB
    mov 30h,#77h
    mov sbuf,#'A'
    jmp again
keyB:
    cjne a,#1dh,keyC
    mov 30h,#7Ch
    mov sbuf,#'B'
    jmp again
keyC:
    cjne a,#8eh,keyD
    mov 30h,#39h
    mov sbuf,#'C'
    jmp again
keyD:
    cjne a,#4eh,keyE
    mov 30h,#5Eh
    mov sbuf,#'D'
    jmp again
keyE:
    cjne a,#2eh,keyF
    mov 30h,#79h
    mov sbuf,#'E'
    jmp again
keyF:
    mov 30h,#71h
    mov sbuf,#'F'
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

delay_300ms:
    mov r2,#3
y:
    mov r0,#200
x:
    mov r1,#250
    djnz r1,$
    djnz r0,x
    djnz r2,y
ret
end
