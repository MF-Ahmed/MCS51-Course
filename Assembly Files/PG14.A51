ORG 000h
jmp main
org 023h
jmp si_
org 030h
main:
mov scon,#40h
mov tmod,#20h
mov th1,#-3
setb tr1
setb ea
setb es
mov a,#'A'
mov sbuf,a
jmp $

si_:
clr ti
inc a
cjne a,#'Z'+1,skip
mov a,#'A'
skip:
mov sbuf,a
reti

end
