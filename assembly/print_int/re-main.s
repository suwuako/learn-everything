section .data
	num_len_msg dq "num_len: "	; len = 9
	num	dq	12345678909876543
section .text
global _start
_start:
	call print


	mov rax, 60
	mov rdi, 0
	syscall

print:
	push rsp	; rsp is now stored in rsp + 24
	mov rax, [num]
	mov rbx, 10
	mul rbx			; LOL THIS IS A HORRIBLE HACK (shift digits left by one)
	push rax
	mov rbx, 0
	call get_num_len

	mov rax, [num]
	mov rcx, 10
	mul rcx
	push rax
	push rbx
	call print_nums
	add rsp, 24
	mov rax, [rsp]
	mov rsp, rax
	ret

; rbx contains the value to be printed
print_digit:
	push rbx
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1
	syscall
	pop rbx

	ret

;	gets the digit of the highest number
;	i.e 123456 -> 1
;	rsp + 24 contains len
;	rsp + 32 contains nums
;	stores the digit in rax
get_digit:
	mov rax, 1
	mov rbx, 10
	mov rcx, [rsp + 24]	; length
	call exp

	mov rbx, rax
	mov rax, [rsp + 32]
	div rbx
	mov [rsp + 32], rdx
	mov rbx, rax
	mov rdx, 0

	add rbx, 48

	ret

;	prints the numbers
;	rsp + 8 ccontains length
;	rsp + 16 contains nums
;	we need [rsp + 8] to decrease by 1 every loop and rsp to lose the most sig digit
print_nums:
	mov rbp, rsp
	push rbp

	call get_digit
	; lets test print
	call print_digit

	mov rcx, [rsp + 16]
	dec rcx
	mov [rsp + 16], rcx
	cmp rcx, 1

	pop rsp
	jne print_nums

	mov rbx, 0x0a	; newline
	call print_digit

	ret


; uses exp_no stored in rcx and uses value in rbx
; spits out return in rax
exp:
	dec rcx
	mov rdx, 0
	mul rbx

	cmp rcx, 1
	jg exp
	ret

;	takes the number stored in rsp + 8 and finds the length of it
;	returns the value in rbx (takes in rbx as value)
get_num_len:
	mov rbp, rsp

	add rbx, qword 1	; increment counter

	mov rax, [rsp + 8]
	mov rcx, 10
	mov rdx, 0	; reset remainder
	div rcx
	mov [rsp + 8], rax ; store result with one decimal trimmed off


	mov rsp, rbp
	cmp rax, 0
	jne get_num_len

	ret


print_len_msg:
	mov rbp, rsp

	mov rax, 1
	mov rdi, 1
	mov rsi, num_len_msg
	mov rdx, 9
	syscall

	mov rcx, rbx
	add rcx, 48
	push rcx
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1
	syscall

	push 0x0a
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1
	syscall

	mov rsp, rbp
	ret
