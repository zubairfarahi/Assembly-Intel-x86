BITS 32

global mystery1:function
global mystery2:function
global mystery3:function
global mystery4:function
global mystery7:function
global mystery9:function


section .bss
output_string: resb 0x6D70000

section .text

; Descriere: calculeaza lungimea unui sir
; @arg: char *string - sirul
; Returneaza: int
; Nume: length
mystery1:
                push ebp
                mov ebp, esp

                mov eax, [ebp + 8]      ; sirul

; se parcurge sirul pana la '\0'
strlen:
                mov dh, [eax]
                test dh, dh
                jz return_len
                inc eax
                jmp strlen

; lungime = adresa_sfarsit - adresa_inceput
return_len:
                sub eax, [ebp + 8]

                leave
                ret


; Descriere: calculeaza pozitia unui caracter intr-un sir
; @arg1: char *string - sirul
; @arg2: char c - caracterul
; Returneaza: int
; Nume: find_char
mystery2:
                push ebp
                mov ebp, esp

                mov dh, byte [ebp + 12]     ; caracterul
                mov eax, [ebp + 8]          ; sirul

; se itereaza sirul pana la '\0' sau pana se gaseste c
find_char:
                mov ch, [eax]
                cmp dh, ch
                je found_char
                test ch, ch
                jz not_found_char

                inc eax
                jmp find_char

; pozitie_caracter = adresa_caracter - adresa_inceput
found_char:
                sub eax, [ebp + 8]
                jmp return_mystery2

not_found_char:
                mov eax, 0xffffffff         ; return 0xffffffff

return_mystery2:
                leave
                ret


; Descriere: compara primele n pozitii din 2 siruri
; @arg1: char *string1 - sirul 1
; @arg2: char *string2 - sirul 2
; @arg3: int n - numarul de pozitii
; Returneaza: int
; Nume: compare_strings
mystery3:
                push ebp
                mov ebp, esp

                mov esi, [ebp + 8]          ; sirul 1
                mov edi, [ebp + 12]         ; sirul 2
                mov ecx, [ebp + 16]         ; numarul de octeti

; se parcurg sirurile de la final la inceput si se compara octet cu octet
compare_strings:
                mov dh, [esi + ecx - 1]
                cmp dh, [edi + ecx - 1]
                jne different_strings

                dec ecx
                jnz compare_strings

                xor eax, eax
                jmp return_mystery3

different_strings:
                mov al, 1                  ; return 1      

return_mystery3:
                leave
                ret


; Descriere: copiaza primii n octeti dintr-un sir in altul
; @arg1: char *string1 - sirul in care se copiaza
; @arg2: char *string2 - sirul din care se copiaza
; @arg3: int n - numarul de octeti care se copiaza
; Returneaza: void
; Nume: copy_string
mystery4:
                push ebp
                mov ebp, esp

                mov edi, [ebp + 8]          ; sirul in care se copiaza
                mov esi, [ebp + 12]         ; sirul din care se copiaza
                mov ecx, [ebp + 16]         ; numarul de octeti copiati

; se parcurg cei n octeti si se copiaza unul cate unul din primul
; sir in al doilea
copy_strings:
                mov dh, [esi + ecx - 1]
                mov [edi + ecx - 1], dh

                dec ecx
                jnz copy_strings

                leave
                ret


; Descriere: creeaza un intreg dintr-un sir ce contine doar cifre
; @arg: char *string1 - sirul in care se copiaza
; Returneaza: int
; Nume: make_number
mystery7:
                push ebp
                mov ebp, esp

                mov esi, [ebp + 8]
                xor eax, eax            ; rezultatul
                mov ecx, 10

; se parcurg octetii pana la '\0' si se adauga la numarul format pana la momentul
; respectiv * 10
make_number:
                mov dh, [esi]
                test dh, dh
                jz return_mystery7
                sub dh, 0x30            ; ASCII '0' = 0x30
                js wrong_input          ; caracter < '0'
                cmp dh, 9
                jg wrong_input          ; caracter > '9'

                imul eax, ecx
                add al, dh              ; eax = eax * 10 + dh

                inc esi
                jmp make_number

wrong_input:
                mov eax, 0xffffffff     ; sirul nu contie doar cifre

return_mystery7:
                leave
                ret

; Descriere: afiseaza liniile complete ce contin un anume subsir
; @arg1: char *string - sir care contine toate liniile una dupa alta
; @arg2: int start_pos - pozitia de start din acest sir
; @arg3: int end_pos - pozitia de sfarsit din acest sir
; @arg4: char *substring - subsirul cautat
; Returneaza: void
; Nume: find_substring_on_lines
mystery9:
                push ebp
                mov ebp, esp
                sub esp, 8                  ; se declara 2 variabile locale de tip char*

                mov edi, [ebp + 8]          ; sirul
                mov ebx, [ebp + 16]
                mov ecx, [ebp + 20]
                mov esi, ecx                ; subsirul
                add ebx, edi                ; pozitia de sfarsit
                add edi, [ebp + 12]         ; adresa pozitiei initiale
                mov [ebp - 4], edi

; se parcurge sirul octet cu octet pana la '\0' si se cauta subsirul
iterate_string:
                cmp edi, ebx
                je return_mystery9
                mov dh, [edi]
                cmp dh, 10
                jne begin_substring_iteration
                test dh, dh
                jz return_mystery9

; cand se gaseste un '\n' se retine adresa acestuia pentru o eventuala afisare
                inc edi
                mov [ebp - 4], edi
                mov esi, ecx
                jmp iterate_string

begin_substring_iteration:
                mov ah, [esi]

; se compara un octet din sir cu unul din subsir
iterate_substring:
                cmp dh, ah
                jne keep_searching

                inc esi
                mov ah, [esi]
                test ah, ah             ; daca s-a ajuns la '\0', s-a gasit subsirul
                jz find_newline

                inc edi
                jmp iterate_string

; se determina adresa primului newline din sir
; daca aceasta este in afara portiunii din sir in care se face cautarea, functia se termina
find_newline:
                cmp edi, ebx
                jge return_mystery9

                inc edi
                cmp [edi], byte 10
                jne find_newline

; se afiseaza linia pe care s-a gasit subsirul de la inceput pana la '\n'-ul gasit anterior
found_newline:
                mov [ebp - 8], ecx
                mov esi, [ebp - 4]
                sub edi, esi
                lea edx, [edi + 1]      ; adresa de inceput a liniei
                mov ecx, esi            ; lungimea liniei
                mov esi, ebx
                mov ebx, 1              ; file descriptor = 1(stdout)
                mov eax, 4              ; sys_write
                int 0x80                ; apelul de sistem se face direct in functie

; se trece pe randul urmator si se reia cautarea subsirului
                add edi, ecx
                inc edi
                mov [ebp - 4], edi
                mov ecx, [ebp - 8]
                mov ebx, esi
                jmp check_next_char

keep_searching:
                inc edi

check_next_char:
                mov esi, ecx
                jmp iterate_string

return_mystery9:
                leave
                ret