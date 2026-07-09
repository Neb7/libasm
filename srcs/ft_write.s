global ft_write

extern __errno_location

section .text

ft_write:
    mov rax, 1
    syscall
    cmp rax, 0
    jl  .err
    ret

.err:
    neg rax
    push rax
    call __errno_location
    pop rdi
    mov [rax], edi; update errno
    mov rax, -1
    ret