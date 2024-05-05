; To create executable:
; ..\nasm -f win32 lab_8_1.asm
; gcc -o lab_8_1 lab_8_1.obj ../driver.c ../asm_io.obj

%include "../asm_io.inc"

 segment .data
 prompt db "Enter an integer: ", 0
 outmsg db "Min: ", 0

 segment .bss

 segment .text
 global _asm_main
 _asm_main:
 enter 0,0
 pusha

 mov edx, 0FFFFFFFh         ; set the edx's value to max int

 while:
    mov eax, 0Ah            ; print new line
    call print_char
    mov eax, prompt         ; print "Enter an integer: "
    call print_string
    call read_int           ; read integer
    cmp eax, 0
    je end                  ; if the input is 0 then end
    jmp getmin              ; else move to getmin

 getmin:
    cmp edx, eax
    jg changemin            ; if edx < eax then jump to changemin
    jmp while               ; else jump to start

 changemin:
    mov edx, eax            ; change the value of the minimum
    jmp while               ; jump to start

 end:
    mov eax, outmsg         ; print "Min: "
    call print_string
    mov eax, edx            ; print the minimum number
    call print_int


 popa
 mov eax, 0
 leave
 ret