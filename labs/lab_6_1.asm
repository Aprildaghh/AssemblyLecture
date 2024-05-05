%include "../asm_io.inc"
 ;
 ; initialized data is put in the .data segment
 ;
 segment .data
 ;
 ; These labels refer to strings used for output
 ;
 prompt1 db "Enter an integer: ", 0
 outmsg1 db "It's some non-extended ASCII code.", 0
 outmsg2 db "It's the ASCII code for a white space.", 0
 outmsg3 db "It's the ASCII code for a digit.", 0
 outmsg4 db "It's some extended ASCII code.", 0
 outmsg5 db "It's not an ASCII code.", 0

 ;
 ; uninitialized data is put in the .bss segment
 ;
 segment .bss
 ;
 ; These labels refer to double words used to store the inputs
 ;

 input1 resd 1

 ;
 ; code is put in the .text segment
 ;
 segment .text
 global _asm_main
 _asm_main:
 enter 0,0 ; setup routine
 pusha
 
 while:
	mov eax, prompt1 ; print out prompt
	call print_string
	call read_int ; read integer
	cmp eax, 0
	jge thenblock
	je endwhile
	jle endwhile
	
 thenblock:
	cmp eax, 48
	jge greaterthan48block
	cmp eax,32
	je equal32block
	cmp eax, 127
	jle lowerthan127block

equal32block:
	mov eax, outmsg2
	call print_string
	call print_nl
	jmp while
	

greaterthan48block:
	cmp eax, 57
	jle between48and57block
	cmp eax, 127
	jle lowerthan127block
	jmp greaterthan128block
	

lowerthan127block:
	mov eax, outmsg1
	call print_string
	call print_nl
	jmp while

between48and57block:
	mov eax, outmsg3
	call print_string
	call print_nl
	jmp while


greaterthan128block:
	cmp eax, 255
	jge greaterthan255block
	mov eax, outmsg4
	call print_string
	call print_nl
	jmp while

greaterthan255block:
	mov eax, outmsg5
	call print_string
	call print_nl
	jmp while

endwhile:
	


 popa
 mov eax, 0 ; return back to C
 leave
 ret