nasm -f win32 %1.asm
gcc -o %1.exe %1.obj driver.c asm_io.obj