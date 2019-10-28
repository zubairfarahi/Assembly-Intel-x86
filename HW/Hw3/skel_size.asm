BITS 32
extern print_line

global mystery1:function
global mystery2:function
global mystery3:function
global mystery4:function
global mystery7:function
global mystery9:function


section .text

; Descriere: calculeaza lungimea unui sir
; @arg: char *string - sirul
; Returneaza: int
; Nume: length
mystery1:
                mov edi, [esp + 4]
                xor al, al
                xor ecx, ecx
                not ecx                 ; ecx = 0xffffffff

                repne scasb             ; se cauta '\0' in sir de maximum 0xffffffff ori

                sub edi, [esp + 4]
                lea eax, [edi - 1]      ; lungime = adresa_sfarsit - adresa_inceput

                ret


; Descriere: calculeaza pozitia unui caracter intr-un sir
; @arg1: char *string - sirul
; @arg2: char c - caracterul
; Returneaza: int
; Nume: find_char
mystery2:
                mov eax, [esp + 4]      ; sirul

; se cauta caracterul dat ca parametru fie pana se gaseste, fie pana se gaseste '\0'
find:
                mov ch, [eax]
                cmp ch, byte [esp + 8]  ; se compara octetul curent cu caracterul cautat
                je found
                test ch, ch
                jz not_found
                inc eax
                jmp find

found:
                sub eax, [esp + 4]      ; pozitie = adresa_caracter - adresa_inceput
                jmp ret_m2

not_found:
                xor eax, eax
                not eax                 ; eax = 0xffffffff

ret_m2:
                ret


; Descriere: compara primele n pozitii din 2 siruri
; @arg1: char *string1 - sirul 1
; @arg2: char *string2 - sirul 2
; @arg3: int n - numarul de pozitii
; Returneaza: int
; Nume: compare_strings
mystery3:
                mov esi, [esp + 4]          ; sirul 1
                mov edi, [esp + 8]          ; sirul 2
                mov ecx, [esp + 12]         ; numarul de octeti comparati
                inc ecx                     ; se trateaza cazul in care sirurile difera pe ultima pozitie
                xor eax, eax

                repe cmpsb                  ; se compara primii n octeti ai sirurilor

                test ecx, ecx
                jnz diff_str

                jmp ret_m3

diff_str:
                mov al, 1                   ; return 1

ret_m3:
                ret


; Descriere: copiaza primii n octeti dintr-un sir in altul
; @arg1: char *string1 - sirul in care se copiaza
; @arg2: char *string2 - sirul din care se copiaza
; @arg3: int n - numarul de octeti care se copiaza
; Returneaza: void
; Nume: copy_string
mystery4:
                mov edi, [esp + 4]      ; sirul destinatie
                mov esi, [esp + 8]      ; sirul sursa
                mov ecx, [esp + 12]     ; numarul de octeti comparati

                rep movsb               ; se copiaza primii n octeti din sirul sursa, in cel destinatie

                ret


; Descriere: creeaza un intreg dintr-un sir ce contine doar cifre
; @arg: char *string1 - sirul in care se copiaza
; Returneaza: int
; Nume: make_number
mystery7:
                mov esi, [esp + 4]      ; sirul ce contine numarul
                xor eax, eax
                mov dl, 10              ; la fiecare pas, numarul anterior se inmulteste cu 10

; se parcurg octetii pana la '\0' si se adauga la numarul format pana la momentul
; respectiv * 10
make_num:
                mov bh, [esi]
                test bh, bh
                jz ret_m7

                sub bh, 0x30            ; ASCII '0'
                js bad_str          ; caracter < '0'
                cmp bh, 9
                jg bad_str          ; caracter > '9'

                mul dl
                add al, bh              ; eax = eax * 10 + dh

                inc esi
                jmp make_num
                jmp ret_m7

; sirul nu contie doar cifre
bad_str:
                xor eax, eax
                not eax                ; return 0xffffffff

ret_m7:
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
                sub esp, 4

                push dword [ebp + 20]
                call mystery1
                mov [ebp - 4], eax          ; lungimea subsirului

                mov edi, [ebp + 8]          ; sirul
                add edi, [ebp + 16]
                mov ebx, edi                ; ultima adresa din string
                sub edi, [ebp + 16]
                add edi, [ebp + 12]         ; pozitia in sir
                mov edx, edi                ; adresa de inceput

; se parcurge sirul octet cu octet pana la '\0' si se cauta subsirul
str:
                cmp edi, ebx
                jz ret_m9

                push 10
                push edi
                call mystery2               ; se calculeaza pozitia urmatorului '\n'

                add eax, edi
                cmp eax, ebx                ; se verifica daca s-a depasit finalul sirului
                jge ret_m9

; se compara un octet din sir cu unul din subsir
substr:
                cmp edi, eax
                jge next_line

                mov esi, [ebp + 20]         ; subsir
                mov ecx, [ebp - 4]          ; lungimea subsirului

                repe cmpsb
                jz match                    ; daca s-a terminat subsirul, inseamna ca acesta a fost gasit
                jmp substr

; se afiseaza linia curenta
match:
                push eax
                push edx
                call print_line
                pop edx
                pop eax

; se trece pe linia urmatoare si se reia algoritmul
next_line:
                lea edi, [eax + 1]
                mov edx, edi
                jmp str

ret_m9:
                leave
                ret