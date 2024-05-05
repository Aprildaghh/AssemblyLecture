%include "asm_io.inc"
 ;
 ; initialized data is put in the .data segment
 ;
 segment .data
 ;
 ; These labels refer to strings used for output
 ;
 prompt1 db "Enter an integer: ", 0
 outmsg1 db "The number of integers divisible by 2 is ", 0
 outmsg2 db "The number of integers divisible by 3 is ", 0
 outmsg3 db "The number of integers divisible by 5 is ", 0

 ;
 ; uninitialized data is put in the .bss segment
 ;
 segment .bss
 ;
 ; These labels refer to bytes used to store the inputs
 ;

 divisible2 resd 1
 divisible3 resd 1
 divisible5 resd 1

 ;
 ; code is put in the .text segment
 ;
 segment .text
 global _asm_main
 _asm_main:
 enter 0,0 ; setup routine
 pusha
 
 mov byte [divisible2], 0
 mov byte [divisible3], 0
 mov byte [divisible5], 0
 
 while:
	mov edx, 0
	mov eax, prompt1
	call print_string
	call read_int ; read integer
	cmp eax, 0
	jge thenblock
	je endwhile
	jle endwhile

 thenblock:
	mov ecx, 2
	idiv ecx
	cmp edx, 0
	je divisible2block
	mov edx, 0
	mov ecx, 3
	idiv ecx
	cmp edx, 0
	je divisible3block
	mov edx, 0
	mov ecx, 5
	idiv ecx
	je divisible5block
	jmp while

 divisible2block:
	mov eax, [divisible2]
	add eax, 1
	mov [divisible2], eax
	jmp while
	
 divisible3block:
	mov eax, [divisible3]
	add eax, 1
	mov [divisible3], eax
	jmp while
 
 divisible5block:
	mov eax, [divisible5]
	add eax, 1
	mov [divisible5], eax
	jmp while
 
 
 endwhile:
	mov eax, outmsg1
	call print_string
	mov eax, [divisible2]
	call print_int
	mov eax, outmsg2
	call print_string
	mov eax, [divisible3]
	call print_int
	mov eax, outmsg3
	call print_string
	mov eax, [divisible5]
	call print_int
	


 popa
 mov eax, 0 ; return back to C
 leave
 ret