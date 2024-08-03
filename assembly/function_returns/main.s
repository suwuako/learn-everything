section .data

section .text
global _start
    push "\n"
    push "5"
    push "4"
    push "3"
    push "2"
    push "1"

    mov rax, 4
    mov rbx, 1
    mov rcx, rsp
    mov rdx, 6

    int 0x80

    mov rax, 1
    mov rbx, 0
    int 0x80
_start:
