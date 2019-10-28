%include "io.inc"

%define NUM 5

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands
    mov ecx, NUM
    
    
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    sub esp, 4
    mov byte [esp], 0
    
    sub esp, 4
    mov dword [esp], "mere"
    
    sub esp, 4
    mov dword [esp], "are "
    
    sub esp, 4
    mov dword [esp], "Ana "


    PRINT_STRING [esp]
    NEWLINE
    NEWLINE

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    lea eax, [ebp]
print:
    cmp eax, esp
    jl print_string
    
    PRINT_HEX 4, eax
    PRINT_STRING ": 0x"
    PRINT_HEX 4, [eax]
    NEWLINE
    
    sub eax, 4
    jmp print
    
print_string:
    ; TODO 3: print the string
    lea ecx, [esp]
    NEWLINE
    
print_string_char_by_char:
    cmp byte [ecx], 0
    je return
    
    PRINT_CHAR [ecx]
    inc ecx
    jmp print_string_char_by_char

return:
    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
