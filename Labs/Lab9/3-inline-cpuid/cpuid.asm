%include "io.inc"

section .bss
    cpuid_info resb 13

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    cpuid
    mov [cpuid_info], ebx
    mov [cpuid_info ], edx
    mov [cpuid_info + 8], ecx
    
    PRINT_STRING cpuid_info
    
    ret