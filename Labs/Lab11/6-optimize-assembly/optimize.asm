global runAssemblyCode

section .text

runAssemblyCode:
    xor eax, eax
    mov ecx, [esp + 8]
    mov edx, [esp + 4]

L:
    mov edi, [edx + (ecx - 1) * 4]
    lea eax, [eax + edi]

    dec ecx
    jnz L

    ret