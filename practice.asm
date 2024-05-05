; To create executable:
; .\nasm -f win32 lab_8_2.asm
; gcc -o lab_8_2 lab_8_2.obj driver.c asm_io.obj

%include "asm_io.inc"

 segment .data

 segment .bss

 segment .text
 global _asm_main
 _asm_main:
 enter 0,0
 pusha

 mov ebx, 0
 
 loop:
    cmp ebx, 5
    jge end
    cmp ebx, 3
    jle print 
    jmp end
 
 print:
    mov eax, ebx
    call print_int
    inc ebx
    cmp ebx, 5
    jle loop


 end:
    

 popa
 mov eax, 0
 leave
 ret