; To create executable:
; ..\nasm -f win32 lab_7_2.asm
; gcc -o lab_7_2 lab_7_2.obj ../driver.c ../asm_io.obj

%include "../asm_io.inc"

 segment .data
 prompt db "Enter an integer: ", 0
 outmsg db "Hex representation: ", 0

 segment .bss
 input1 resd 1

 segment .text
 global _asm_main
 _asm_main:
 enter 0,0
 pusha

 setc cl
 movzx ecx, cl

 while:
    mov eax, 0Ah            ; print new line
    call print_char
    mov eax, prompt         ; print "Enter an integer: "
    call print_string
    call read_int
    mov ebx, eax            ; store the input to ebx
    cmp ebx, 0
    je end                  ; if the input is 0 then end
    jmp printblock          ; else move to printblock


 printblock:
    mov eax, outmsg         ; print "Hex representation: "
    call print_string
    mov edx, 8              ; set the counter to 8
    cmp ebx, 0
    jl signedblock
    jg signedblock
    

 signedblock:

 shiftloopblock:


 end:
    


 popa
 mov eax, 0
 leave
 ret