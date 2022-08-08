org 000h
jmp main
org 003h
jmp EX0_ISR
org 0600h
db ' PLEASE ~'
org 0615h
db 'CARD INSERTED ~'
;org 0730h
;db 'PLEASE ENTER PIN ~'
;org 0750h
;db 'INVALID CARD ~'
;org 0750h
;db 'PIN IS NOT CORRECT ~'
;- - - - - - - - - - - - - - -- - -- - - - - - - - - - - - - - - - - -
main:
;- - - - - - - - - - - - - - -- - -- - - - - - - - - - - - - - - - - -
setb EA
setb EX0
call _inilcd
mov  dptr,#0600h
next:
clr a
movc a,@a+dptr
cjne a,#'~',do
jmp $
do:
call _disp
inc dptr
jmp next


_inilcd:
mov a,#3ch
call _command
mov a,#0eh
call _command
mov a,#06h
call _command
mov a,#01h
call _command
mov a,#80h
call _command
ret


_command:
call _ready
mov p0,a
clr p3.3
clr p3.5
setb p3.4
clr p3.4
ret


_disp:
call _ready
mov p0,a
setb p3.3
clr p3.5
setb p3.4
clr p3.4
ret


_ready:
clr p3.4
mov p0,#0ffh
clr p3.3
setb p3.5
wait:
clr p3.4
setb p3.4
jb p0.7,wait
clr p3.4
ret

;- - - - - - - - - - - - - - - - - - - - - - - -  - - - - -  - - - - - 
EX0_ISR:
;- - - - - - - - - - - - - - - - - - - - - - - -  - - - - -  - - - - - 
call _inilcd1
mov dptr,#0615h
next_1:
clr a
movc a,@a+dptr
cjne a, #'~',do_1
jb p3.2 ,main
;mov r0,#50
;djnz r0,$
;jnb p1.0, _cardvalid
;mov dptr,#0750h
;jmp next_2
do_1:
call _disp
inc dptr
jmp next_1

_inilcd1:
mov a,#3ch
call _command
mov a,#0eh
call _command
mov a,#06h
call _command
mov a,#01h
call _command
mov a,#80h
call _command
ret

next_2:
clr a
movc a,@a+dptr
cjne a,#'~',do_2
again:
jb p3.2,exit
jmp again
do_2:
call _disp
inc dptr
jmp next_2



;_cardvalid:
;mov dptr,#0730h
next_3:
clr a
movc a,@a+dptr
cjne a, #'~',do_3
reti            ; type ur code of kp

do_3:
call _disp
inc dptr
jmp next_3
exit:
jmp main


end
