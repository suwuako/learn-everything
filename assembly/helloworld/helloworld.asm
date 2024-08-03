section .data
    output db "Hello, assembly!", 0x0a
    len dd 17
section .text
global _start
_start:    
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, [len]
    int 0x80

    mov eax, 1
    mov ebx, [len]
    int 0x80
