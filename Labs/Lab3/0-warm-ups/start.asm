%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov eax, 7          
    mov ebx, 300
    add eax, ebx

    PRINT_UDEC  4, eax
    
    xor eax, eax
    ret