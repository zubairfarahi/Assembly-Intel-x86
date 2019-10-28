%include "io.inc"
extern printf

section .data
    mystring db "This is my string", 0
    printf_format db "String length is %u", 10, 0
    store_string times 64 db 0

section .text
global CMAIN

reverse_string:
    push ebp
    lea ebp, [esp]

    mov eax, dword [ebp+8]
    mov ecx, dword [ebp+12]
    add eax, ecx
    dec eax
    mov edx, dword [ebp+16]

copy_one_byte:
    mov bl, byte [eax]
    mov byte [edx], bl
    dec eax
    inc edx
    loopnz copy_one_byte

    inc edx
    mov byte [edx], 0

    leave ; lea esp, [ebp], pop ebp
    ret ; pop eip

CMAIN:
    push ebp
    lea ebp, [esp]

    mov eax, mystring
test_one_byte:
    mov bl, byte [eax]
    test bl, bl
    je print

    inc eax
    jmp test_one_byte

print:
    sub eax, mystring
    PRINT_DEC 4, eax
    NEWLINE

    push eax
    push printf_format
    call printf
    
    add esp, 4  ; de ce nu este scos printf_format de pe stiva?
    pop eax
    push store_string
    push eax
    push mystring
    call reverse_string
    
    push store_string
    call puts

    xor eax, eax
    leave
    ret
