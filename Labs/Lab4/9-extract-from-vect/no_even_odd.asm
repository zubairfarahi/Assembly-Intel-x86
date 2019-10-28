%include "io.inc"

section .data

v db 1, 100, 0, -25, -7, 128, 220, -110
len db 8

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    xor edx, edx
    mov ecx, [len]
    
count_even_odd:
    test byte [v + ecx - 1], 1
    jz even
    
    inc eax  ; odd
    jmp end_loop
    
even:
    inc edx
end_loop:
    loop count_even_odd
    
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, edx
    
    ret