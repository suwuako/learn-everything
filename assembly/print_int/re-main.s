section .data
	num_len_msg dq "num_len: "	; len = 9
	num	dq	1234567890
section .text
global _start
_start:
	mov rax, [num]
	push rax
	mov rbx, 0
	call get_num_len
	call print_len_msg

	mov rax, [num]
	push rax
	push rbx
	call print_nums


	mov rax, 60
	mov rdi, rbx
	syscall

;	prints the numbers
;	rsp + 8 ccontains length
;	rsp + 16 contains nums
;	we need [rsp + 8] to decrease by 1 every loop and rsp to lose the most sig digit
print_nums:
	mov rbp, rsp

	mov rdx, 0	; flush remainder

	; setup for exp so that rax stores 10 ^ [len - 1]
	mov rcx, [rsp + 8]
	mov rbx, 10
	mov rax, 1

	cmp rcx, 1
	jg exp

	
	; store divisor in rbx, store data in rax
	mov rbx, rax
	mov rax, [rsp + 16]
	div rbx

	; dec len, store rem
	mov rbx, [rsp + 8]
	dec rbx
	mov [rsp + 8], rbx
	mov [rsp + 16], rdx

	; store rax as string onto stack
	add rax, 48
	push rax
	; print
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1
	syscall
	sub rsp, 8

	mov [rsp + 16], rdx
	mov rsp, rbp
	cmp rdx, 0
	jne print_nums

	ret

; uses exp_no stored in rcx and uses value in rbx
; spits out return in rax
exp:
	dec rcx
	mov rdx, 0
	mul rbx

	cmp rcx, 1
	jne exp
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
