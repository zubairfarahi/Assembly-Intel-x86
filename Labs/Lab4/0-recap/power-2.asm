%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1    ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
    
pow2:
    test al, bl
    jz check_zero 

    PRINT_UDEC 1, bl
    NEWLINE
    
    sub al, bl

check_zero:    
    test al, al
    jz return

    shl bl, 1
    jmp pow2

return:
    leave
    ret
