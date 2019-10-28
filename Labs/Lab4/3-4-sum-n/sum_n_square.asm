%include "io.inc"

section .data
    num dd 100

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    mov ecx, [num]
    
add_to_sum:
    ;push ecx
    ;imul ecx, ecx
    ;add eax, ecx
    ;pop ecx
    push ecx
    push eax
    mov eax, ecx
    mul ecx
    pop ecx
    add eax, ecx
    pop ecx
    loop add_to_sum
    
    PRINT_UDEC 4, eax
    
    ret