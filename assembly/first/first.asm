section .data ; stores variables in memory when our program runs

section .text ; our code of the program
global _start ; we need something external to know where start is

_start: ; declares a label 
    mov eax, 1 
    mov ebx, 1
    int 80h ; system interrupt (does thing based off eax:)
            ; 1 in eax indicates we wnat to exit the system 
            ; 1 in ebx indicates we want to output as a status code
