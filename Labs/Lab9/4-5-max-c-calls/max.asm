section .text

global get_max

get_max:
    push ebp
    mov ebp, esp

    ; [ebp + 8] is array pointer
    ; [ebp + 12] is array length
    ; [ebp + 16] is the address of pos
    
    push ebx

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    xor eax, eax

compare:
    cmp eax, [ebx + (ecx - 1) * 4]
    jge check_end

    mov eax, [ebx + (ecx - 1) * 4]
    lea edx, [ecx - 1]

check_end:
    loopnz compare

    mov ebx, [ebp + 16]
    mov [ebx], edx

    pop ebx
    leave
    ret
