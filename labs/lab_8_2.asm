; To create executable:
; ..\nasm -f win32 lab_8_2.asm
; gcc -o lab_8_2 lab_8_2.obj ../driver.c ../asm_io.obj

%include "../asm_io.inc"

 segment .data

 segment .bss

 segment .text
 global _asm_main
 _asm_main:
 enter 0,0
 pusha

 mov ecx, 0                 ; set the ecx's value to 0

 loopstart:
    cmp ecx, 5
    jge end                 ; stop loop if ecx >= 5
    inc ecx                 ; increase ecx by one
    cmp ecx, 3
    jle printblock          ; jump to printblock if ecx <= 3
    jmp loopstart           ; jump to start

 printblock:
    mov eax, ecx            ; print the int
    call print_int
    mov eax, 0Ah            ; print new line
    call print_char
    jmp loopstart           ; jump to start


 end:

 popa
 mov eax, 0
 leave
 ret