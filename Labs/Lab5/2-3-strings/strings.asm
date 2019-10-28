%include "io.inc"

section .data
    string db "Lorem ipsum dolor sit amet.i", 0
    print_strlen db "strlen: ", 10, 0
    print_occ db "occurences of `i`:", 10, 0

    occurences dd 0
    length dd 0    
    char db 'i'

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    ; TODO1: compute the length of a string
    mov al, 0  ; \0
    mov edi, string
    cld
    
    repne scasb
    
    ; TODO1: save the result in at address length
    sub edi, string
    dec edi
    mov [length], edi

    ; print the result of strlen
    PRINT_STRING print_strlen
    PRINT_UDEC 4, [length]
    NEWLINE

    ; TODO2: compute the number of occurences
    xor eax, eax
    mov al, [char]  ; 'i'
    mov ecx, edi
    lea edx, [string + edi]
    mov edi, string
    xor ebx, ebx

    ; TODO2: save the result in at address occurences
find_i:
    repne scasb
    
    cmp al, byte [edi - 1]
    jnz loop_back
    inc ebx

loop_back:
    cmp edi, edx
    je print

    jmp find_i

print:
    ; print the number of occurences of the char
    mov [occurences], ebx
    
    PRINT_STRING print_occ
    PRINT_UDEC 4, [occurences]
    NEWLINE

    xor eax, eax
    leave
    ret
