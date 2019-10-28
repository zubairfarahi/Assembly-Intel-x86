%include "io.inc"

section .text
global CMAIN
CMAIN:
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 4
    mov ebx, 1 

    ; TODO: aflati maximul folosind doar o instructiune de salt si push/pop
    cmp eax, ebx
    jle print
    
    push ebx
    mov ebx, eax
    pop eax
    
print:
    PRINT_DEC 4, eax ; afiseaza minimul
    NEWLINE

    ret
