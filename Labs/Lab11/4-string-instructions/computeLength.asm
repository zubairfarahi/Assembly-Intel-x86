global computeLength
global computeLength2

section .text
computeLength:
    push ebp
    mov ebp, esp
    
    mov edi, [ebp + 8]
    jmp return

count_bytes:
    inc edi

return:
    cmp byte [edi], 0
    jne count_bytes

    lea eax, [edi]
    sub eax, [ebp + 8]

    mov esp, ebp
    pop ebp
    ret


computeLength2:
    push ebp
    mov ebp, esp
    
    mov edi, [ebp + 8]

    xor eax, eax

    repne scasb

    lea eax, [edi - 1]
    sub eax, [ebp + 8]

    mov esp, ebp
    pop ebp
    ret
