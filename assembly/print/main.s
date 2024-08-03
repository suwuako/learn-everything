section .data 
    num dq 42
section .text

global _start
_start:
    mov rax, [num]
    push rax        ; move num to stack

    call print_num

    mov rax, 1
    mov rbx, 0
    int 0x80

print_num:
    ; currently: rsp -> address after call
    ; rsp + 8 -> [num]
    mov rbp, rsp ; stores current stack pointer on the base pointer

    mov rax, [rsp + 8]
    mov rbx, 10
    mov rdx, 0

    div rbx
    mov [rsp + 8], rax

    mov rax, 4
    mov rbx, 1
    mov rcx, 48
    mov rdx, 1
    int 0x80
    
    mov rax, [rsp + 8]
    cmp rax, 0    ; jumps if rsp doesn't hit 0
    jg print_num

    mov rsp, rbp
    ret
