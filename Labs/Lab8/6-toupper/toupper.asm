%include "io.inc"
extern printf

section .data
    before_format db "before %s", 13, 10, 0
    after_format db "after %s", 13, 10, 0
    mystring db "a4bcDefgh2ij", 0

section .text
global CMAIN

toupper:
    push ebp
    lea ebp, [esp]
    
    ; TODO
    xor ebx, ebx
    mov ecx, [ebp + 8]
change_string:
    mov bl, [ecx]
    
    test bl, bl
    jz return
    cmp bl, 'a'
    jb next_char
    cmp bl, 'z'
    ja next_char

    sub bl, 0x20
    
next_char:
    mov [ecx], bl
    inc ecx
    jmp change_string

return:
    leave
    ret

CMAIN:
    push ebp
    lea ebp, [esp]

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    leave
    ret
