section .data 
    num dd 10

section .text 
    global _start:

_start:
    sub esp, 8

    mov eax, [dd]
    mov [esp + 4], eax 

    mov eax, [esp + 4]
    mov ebx, 10
    div ebx 

    mov ecx, eax
    mov edx, 0
    add ecx, 48

    mul ebx

    mov [esp], ecx

    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1

    int 0x80 

    

    mov eax, 1
    mov ebx, 0
    int 0x80
