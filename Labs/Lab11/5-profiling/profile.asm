extern printf
global main

section .data
    str: db "Clock ticks: %d", 10, 13

section .text
main:
    push ebp
    mov ebp, esp

    mov ecx, 1000
    xor eax, eax

    rdtsc
    lea ebx, [eax]

first_loop:
    loop first_loop

    rdtsc
    sub eax, ebx

    push eax
    push str
    call printf
    add esp, 8

    mov ecx, 1000
    rdtsc
    lea ebx, [eax]

second_loop:
    dec ecx
    jnz second_loop

    rdtsc
    sub eax, ebx

    push eax
    push str
    call printf
    add esp, 8

    mov esp, ebp
    pop ebp
    ret
