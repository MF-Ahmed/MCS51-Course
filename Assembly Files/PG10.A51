;*******************************PROGRAM OBJECTIVE******************************
;RECEIVE THE SCAN CODE COMING FROM THE ATKEYBOARD AT P3.6(CLK) AND P3.7 (DATA)
;DISPLAY THE BINARY PATERN OF THE SCANE CODE ON THE LEDs

clk bit p3.6
dta bit p3.7

org 000H
start:
    jb clk,$
    jnb clk,$
    mov R0,#8
again:
    jb clk,$
    mov c,dta
    rrc A
    jnb clk,$
    djnz R0,again

    jb clk,$
    jnb clk,$
    jb clk,$
    jnb clk,$

    cpl A
    mov P1,A
    jmp start
end
