global ft_strcmp
;int ft_strcmp(const char *s1, const char *s2)
;rdi = s1, rsi = s2

section .text

ft_strcmp:
    xor rax, rax

.loop:
    mov cl, [rdi + rax]
    cmp cl, [rsi + rax]
    jne .diff

    test cl, cl
    je .equal

    inc rax
    jmp .loop

.diff:
    movzx ecx, byte [rsi + rax]
    movzx eax, byte [rdi + rax]
    sub eax, ecx
    ret; return eax (rax 32 bits)

.equal:
    xor eax, eax
    ret; return eax (rax 32 bits)