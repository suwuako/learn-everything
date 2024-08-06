section .data
	exp_no		dq	5
section .text
global _start
_start:
	mov rcx, [exp_no]
	mov rbx, 2
	mov rax, rbx
	call exp

	mov rdi, rax
	mov rax, 60
	syscall

; uses exp_no stored in rcx and uses value in rbx
; spits out return in rax
exp:
	dec rcx
	mov rdx, 0
	mul rbx

	cmp rcx, 1
	jne exp
	ret
