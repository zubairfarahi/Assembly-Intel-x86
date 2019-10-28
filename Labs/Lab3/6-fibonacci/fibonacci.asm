%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 1       ; vrem sa aflam al N-lea numar; N = 7
    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    mov eax, 0
    mov ebx, 1
    
generate_fib:
    dec ecx
    test ecx, ecx
    je print

    add eax, ebx
    xchg eax, ebx
    jmp generate_fib

print:
    PRINT_UDEC 4, ebx
    
    xor eax, eax    
    ret