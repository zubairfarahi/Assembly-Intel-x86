%include "io.inc"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

substr_length: dd 4
print_format: db "Substring found at index: ", 0

section .bss
source_length: resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    ; TODO: Fill source_length with the length of the source_text string.
    ; Find the length of the string using scasb.
    mov al, 0  ; \0
    lea edi, [source_text]
    cld
    
    repne scasb
    
    sub edi, source_text + 1
    sub edi, [substr_length]
    mov [source_length], edi
   
    xor eax, eax
    
find_pattern:
    cmp eax, [source_length]
    jg return
    
    mov ecx, [substr_length]
    lea esi, [source_text + eax]
    lea edi, [substring]
    
    repe cmpsb
    jne no_match
    
    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE
    
no_match:
    inc eax    
    jmp find_pattern
        
return:
    leave
    ret
