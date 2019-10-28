%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139 
    mov ebx, 169
    
    PRINT_DEC 4, eax ; afiseaza prima multime
    NEWLINE
    PRINT_DEC 4, ebx ; afiseaza cea de-a doua multime
    NEWLINE

    ; TODO1: reuniunea a doua multimi
    or eax, ebx
    
    PRINT_DEC 4, eax
    NEWLINE

    ; TODO2: adaugarea unui element in multime
    mov ebx, 1
    shl ebx, 4
    or eax, ebx
    
    PRINT_DEC 4, eax
    NEWLINE

    ; TODO3: intersectia a doua multimi
    and eax, ebx
    
    PRINT_DEC 4, eax
    NEWLINE

    ; TODO4: complementul unei multimi
    not eax
    
    PRINT_DEC 4, eax
    NEWLINE

    ; TODO5: eliminarea unui element
    not eax
    xor eax, ebx
    
    PRINT_UDEC 4, eax
    NEWLINE

    ; TODO6: diferenta de multimi EAX-EBX
    mov eax, 139 
    mov ebx, 169
    
    xor ebx, eax
    and eax, ebx
    
    PRINT_UDEC 4, eax
    NEWLINE

    xor eax, eax
    ret
