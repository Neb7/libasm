global ft_atoi_base
;int ft_atoi_base(char *str, char *base);
;rdi = str, rsi = base

extern __errno_location

section .text

ft_atoi_base:


check_base:
	test rdi, rdi
	je .one

	xor r8d, r8d

.one:
	mov eax, 1; return (1);
	ret
