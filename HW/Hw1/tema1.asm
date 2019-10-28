%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
    expr: resb MAX_INPUT_SIZE

section .text
global CMAIN

make_number:  ; se parseaza stringul citit cat timp contine cifre si se creeaza un nou numar
    push ebp
    lea ebp, [esp]

    xor edx, edx  ; dl va contine fiecare caracter
    xor eax, eax  ; eax contine numarul din string, care va fi "returnat"

parse_input:
    mov dl, [ecx]

    cmp dl, ' '  ; daca s-a gasit un spatiu sau un \0
    jbe return

    imul eax, 10
    lea eax, [eax + edx - '0']  ; eax = eax * 10 + [ecx] - '0'

    inc ecx
    jmp parse_input

return:
    leave
    ret

CMAIN:
    push ebp
    lea ebp, [esp]

    GET_STRING expr, MAX_INPUT_SIZE

    lea ecx, [expr]  ; se va lucra direct pe octetii stringului, pana la '\0'

evaluate_expr:
    mov ebx, 1  ; ebx tine initial semnul unui numar gasit

    cmp byte [ecx], 0  ; s-a ajuns la finalul stringului
    je print
    cmp byte [ecx], '*'
    je multiplication
    cmp byte [ecx], '/'
    je division
    cmp byte [ecx], '+'
    je addition
    cmp byte [ecx], '-'  ; '-' poate simboliza o scadere sau un numar negativ
    je minus
    cmp byte [ecx], ' '
    je next_char
    jmp get_number  ; daca nu s-au gasit alte semne, s-a gasit o cifra

minus:
    cmp byte [ecx + 1], ' '  ;  daca urmeaza un spatiu sau '\0'
    jbe subtraction

    mov ebx, -1  ; se schimba semnul numarului
    inc ecx

get_number:
    push eax  ; se salveaza pe stiva fostul numar obtinut sau creat
    call make_number  ; se returneaza in eax noul numar gasit, fara semn
    imul ebx  ; se aplica semnul
    jmp next_char

multiplication:
    imul dword [esp]  ; se retine in eax rezultatul inmultirii
    add esp, 4  ; se scoate inmultitorul de pe stiva
    jmp next_char

division:  ; se impart primele 2 numere gasite in ordine inversa, respectand semnul
    pop ebx  ; deimpartitul este pe stiva si se preia de catre ebx
    xchg eax, ebx  ; se pun operanzii in ordinea corecta
    cdq
    idiv ebx
    jmp next_char

addition:
    add eax, dword [esp]  ; se aduna primele 2 numere disponibile
    add esp, 4  ; se scoate al doilea termen de pe stiva
    jmp next_char

subtraction:  ; se scad primele 2 numere disponibile, in ordine inversa
    pop ebx  ; descazutul se gaseste pe stiva si se extrage
    sub ebx, eax
    lea eax, [ebx]
    jmp next_char

next_char:
    inc ecx
    jmp evaluate_expr

print:
    PRINT_DEC 4, eax  ; la final, rezultatul va fi in eax
    NEWLINE

    xor eax, eax
    leave
    ret