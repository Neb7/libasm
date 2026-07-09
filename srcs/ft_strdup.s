global ft_strdup

extern malloc
extern __errno_location
extern ft_strlen
extern ft_strcpy

section .text

ft_strdup:
	push rbx
	mov rbx, rdi
	
	call ft_strlen
	
	mov rdi, rax
	inc rdi
	call malloc
	
	test rax, rax
	je .err

	push rax
	mov rdi, rax; dst
    mov rsi, rbx; src
	call ft_strcpy
	pop rax
	pop rbx
	ret

.err:
	xor rax, rax; NULL
    pop rbx
    ret
	
