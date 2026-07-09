bits 64
global ft_strlen
;size_t ft_strlen(const char *s)
;rdi = s

section .text

ft_strlen:
    xor rax, rax;

.loop:
    cmp byte [rdi + rax], 0
    je .done

    inc rax
    jmp .loop

.done:
    ret; return rax
