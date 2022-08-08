clk bit p3.7
dat bit p3.6

org 000h
start:
mov r0, #8
jb clk, $
jnb clk,$
again:
jb clk,$
mov c,dat
rrc a
jnb clk,$
djnz r0,again
jb clk,$
jnb clk,$
jb clk,$
jnb clk,$
cpl a
mov p1,a
jmp start
end 
