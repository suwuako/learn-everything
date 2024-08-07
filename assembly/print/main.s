section .data 
    num dq 42
    helloworld dq "hello, world!", 0x0a, 0x00
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
    push rbp
    mov rbp, rsp
    
    push "a"
    push "b"

    mov rax, 2
    mov rdi, 10
    mov rsi, rsp
    mov rdx, 2

    syscall

    mov rsp, rbp
    pop rbp
    ret
