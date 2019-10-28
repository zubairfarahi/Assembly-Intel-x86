%include "io.inc"

section .data
v db -2, 3, 4, 11, -100, 4, -1, 0
len db 8

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    xor edx, edx
    mov ecx, [len]
    
count:
    cmp byte [v + ecx - 1], 0
    jl negative
    
    inc eax
    jmp end_loop
negative:
    inc edx
    
end_loop:
    loop count
    
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, edx
    
    ret