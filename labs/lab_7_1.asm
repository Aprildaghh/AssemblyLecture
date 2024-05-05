; To create executable:
; ..\nasm -f win32 lab_7_1.asm
; gcc -o lab_7_1 lab_7_1.obj ../driver.c ../asm_io.obj

%include "../asm_io.inc"

 segment .data
 prompt db "Enter an integer: ", 0
 outmsg db "Binary representation: ", 0

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
    mov eax, outmsg         ; print "Binary representation: "
    call print_string
    mov edx, 32             ; set the counter to 32
    jmp shiftloopblock
    
 shiftloopblock:
    cmp edx, 0
    je while                ; if the counter is 0 then jump to start
    dec edx                 ; decrement counter
    xor ecx, ecx            ; set ecx to 0
    sal ebx, 1              ; arithmetic shift ebx to left by 1
    adc ecx, 0              ; add the carry to ecx
    mov eax, ecx            ; print the carry
    call print_int
    jmp shiftloopblock      ; start this loop again


 end:
    


 popa
 mov eax, 0
 leave
 ret