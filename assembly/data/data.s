section .data
    ; needs name of data, type and initial value
    num     dd      5   ; gets put in stack
    num2    db      1
section .text
global _start

_start:
    mov eax, 1
    mov bh, [num2]
    mov cl, [num]
    int 80h
