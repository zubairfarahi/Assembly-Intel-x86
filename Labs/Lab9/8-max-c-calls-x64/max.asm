section .text

global get_max

get_max:
    push rbp
    mov rbp, rsp

    ; [rdi] is array pointer
    ; [rsi] is array length
    ; [rdx] is the address of pos

    push rbx
    lea rcx, [rsi]
    xor rax, rax

compare:
    cmp eax, [rdi + (rcx - 1) * 4]
    jge check_end

    mov eax, [rdi + (rcx - 1) * 4]
    lea rbx, [rcx - 1]

check_end:
    loopnz compare

    mov dword [rdx], ebx
    pop rbx

    leave
    ret
