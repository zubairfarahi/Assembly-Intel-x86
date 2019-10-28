%include "io.inc"

section .data
    string db "ana", 0, "are", 0, "mere", 0
    format db "%s %s %s", 10, 0

section .text
global CMAIN

rot13:
    push ebp
    lea ebp, [esp]
    
    xor ebx, ebx
    mov ecx, [ebp + 8]
rot13_on_a_char:   
    cmp ecx, format
    je return
    cmp [ecx], byte 0
    je next_char
    cmp [ecx], byte ' '
    je next_char
    cmp [ecx], byte 'm'
    ja above_13

    add [ecx], byte 13
    jmp next_char
above_13:
    sub [ecx], byte 13

next_char:
    inc ecx
    jmp rot13_on_a_char
 
return:
    leave
    ret

CMAIN:
    push ebp
    lea ebp, [esp]
    
    push string
    call rot13
    
    lea eax, [string + 8]
    push eax
    lea eax, [string + 4]
    push eax
    push string
    push format
    call printf
    
    xor eax, eax
    leave
    ret