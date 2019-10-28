%include "io.inc"

section .data
    myString: db "Hello, World!", 0
    goodbye: db "Goodbye, World!", 0 

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 6                 ; N = valoarea registrului ecx
    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    jg print                   ; TODO1: eax > ebx?
    ret
    
print:    
    cmp ecx, 0
    je print_goodbye

    PRINT_STRING myString
    NEWLINE

    dec ecx
    jmp print

print_goodbye:
    PRINT_STRING goodbye

    ret
