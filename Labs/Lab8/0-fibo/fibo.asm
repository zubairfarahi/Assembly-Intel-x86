%include "io.inc"

%define NUM_FIBO 10

section .text
global CMAIN
CMAIN:
    lea ebp, [esp]

    ; TODO - replace below instruction with the algorithm for the Fibonacci sequence
    push 1
    push 1
    
    mov ecx, 2
generate_fibo:
    cmp ecx, NUM_FIBO
    je print
    
    mov eax, [esp]
    add eax, [esp + 4]
    push eax
    
    inc ecx
    jmp generate_fibo

    mov ecx, NUM_FIBO

print:
    PRINT_UDEC 4, [esp + (ecx - 1) * 4]
    PRINT_STRING " "
    dec ecx
    cmp ecx, 0
    ja print

    xor eax, eax
    lea esp, [ebp]
    ret
