section .data 
    example_num dd 1234567
section .text
global _start:

_start:
    mov eax, [example_num]
    mov ecx, 0

    call get_digit_count ; ecx stores the number of digits

    mov eax, [example_num]
    sub esp, 8           ; decrease stack pointer to allocate 1 byte
    mov dword [esp + 4], eax
    mov [esp], ecx ; store ecx

    mov eax, [example_num]
    call print_digits    ; when we call a function, we push the address of the line we are in into esp, 
                         ; which is then used to return to the next line
    ; exit
    mov eax, 1 
    int 0x80

print_digits:
    mov ebp, esp
    sub [esp+4], dword 1        ; decrements n

    mov edx, 0

    ; stores the value n * 10 in ebx
    mov eax, [esp + 4]
    mov ebx, 10
    mul ebx 
    mov ebx, eax

    ; divides eax by n * 10
    mov eax, [esp + 8]
    div ebx
    mov edx, 0

    ; stores the character into ecx
    mov ecx, eax
    add ecx, 48

    ; gets n * 10 * digit
    mul ebx
    sub [esp + 8], ebx

    ; moves the character into esp
    sub esp, 4
    mov [esp], ecx

    mov eax, 4
    mov ebx, 1 
    mov ecx, esp
    mov edx, 1

    add esp, 4

    int 0x80


    cmp [esp+4], dword 0        ; compares n
    jg print_digits

    sub esp, 4
    mov [esp], dword 10

    ; print /n 
    mov eax, 4 
    mov ebx, 1 
    mov ecx, esp 
    mov edx, 1
    int 0x80
    
    add esp, 4

    mov esp, ebp
    ret

get_digit_count:
    mov ebx, 10
    div ebx
    mov edx, 0
    inc ecx

    cmp eax, 0
    jg get_digit_count
    
    ret

