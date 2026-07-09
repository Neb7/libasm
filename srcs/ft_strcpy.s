global ft_strcpy
;char *ft_strcpy(char *dest, const char *src);
;rdi = dest, rsi = src

section .text

ft_strcpy:
	xor rax, rax

.loop:
	mov cl, [rsi + rax]
	mov [rdi + rax], cl
	
	cmp cl, 0
	je .done
	
	inc rax
	jmp .loop

.done:
	mov rax, rdi
	ret; return rax