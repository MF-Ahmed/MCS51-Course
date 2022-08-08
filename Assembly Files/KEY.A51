org 000H

begin:
jb P3.6,$
jnb P3.6,$

mov R7,#8
start:
jb P3.6,$
mov c,P3.7
rrc A
jnb P3.6,$
djnz R7,start

jb P3.6,$
jnb P3.6,$
jb P3.6,$
jnb P3.6,$

cpl A
mov P1,A
jmp begin
end
