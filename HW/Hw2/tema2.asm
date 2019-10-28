; Copyright 2018: Teodor-Stefan Dutu

extern puts
extern printf
extern strlen

%define BAD_ARG_EXIT_CODE -1

section .data
filename: db "./input0.dat", 0
inputlen: dd 2263

fmtstr:            db "Key: %d",0xa, 0
usage:             db "Usage: %s <task-no> (task-no can be 1,2,3,4,5,6)", 10, 0
error_no_file:     db "Error: No input file %s", 10, 0
error_cannot_read: db "Error: Cannot read input file %s", 10, 0

section .text
global main


; functia xoreaza string-ul criptat cu cheia pentru a obtine string-ul initial
; @param [ebp + 8]: adresa string-ului criptat
; @param [ebp + 12]: adresa cheii
xor_strings:
                enter 0, 0

                mov edi, [ebp + 8]
                mov esi, [ebp + 12]

; se vor parcurge octetii stringului pana la \0 si se vor xora cu corespondentii
; lor din cheie
decode_bytes_xor:
                cmp byte [edi], 0
                jz return_xor_strings

                mov bl, [edi]
                xor bl, [esi]
                mov byte [edi], bl

                inc edi
                inc esi
                jmp decode_bytes_xor

return_xor_strings:
                leave
                ret


; se parcurge sirul de caractere de la sfarsit la inceput si se xoreaza cate 2
; caractere adiacente
; @param: [ebp + 8]: adresa input-ului
rolling_xor:
                enter 0, 0

                push dword [ebp + 8]
                call strlen

                ; eax retine adresa ultimului element din string care inca e criptat
                add eax, [ebp + 8]
                dec eax 

; pana cand eax contine adresa de inceput a stringului (parametrul dat functiei)
; se va xora caracterul de la pozitia din eax cu cel precedent
decode_bytes_rolling_xor:
                cmp eax, [ebp + 8]
                je return_rolling_xor

                mov bl, [eax]
                xor bl, [eax - 1]
                mov byte [eax], bl

                dec eax
                jmp decode_bytes_rolling_xor

return_rolling_xor:
                leave
                ret


; se proceseaza 2 caractere consecutive din string considerate cifre hexa,
; iar numarul format din acestea este stocat in al
; se presupune ca in string nu vor fi alte caractere decat cifre hexa
; inital prima cifra hexa se tine in ah, si a doua in al
; foloseste ebx-ul creat de apelantul xor_hex_strings
; @param [ebp + 8]: adresa primei cifre hexa
get_char_from_hex:
                enter 0, 0

                mov esi, [ebp + 8]
                mov ah, [esi + ebx * 2]
                test ah, ah
                jz return_get_char
                mov al, [esi + ebx * 2 + 1]

                sub al, 87          ; a = 97 in ASCII si 0xa = 10
                jns check_ah
                add al, 87 - '0'    ; daca a este in [0, 9]

check_ah:
                sub ah, 87          ; si ah este tratat ca o cifra hexa, ca al
                js digit_ah
                jmp make_char

digit_ah:
                add ah, 87 - '0'

; 0xnm = (n << 4) + m
; n, m cifre hexa oarecare
make_char:
                shl ah, 4
                add al, ah

return_get_char:
                leave
                ret


; functia relizeaza decriptarea unui string format din caractere ce sunt interpretate
; ca fiind cifre hexa
; @param [ebp + 8]: adresa string-ului
; @param [ebp + 12]: adresa cheii
xor_hex_strings:
                enter 4, 0

                xor ebx, ebx                ; ebx reprezinta pozitia curenta modificata din string
    
                mov edi, [ebp + 8]
                mov esi, [ebp + 12]

decode_bytes_xor_hex:
                mov [esp], edi
                call get_char_from_hex      ; se formeaza un nou caracter din string
    
                test al, al
                jz return_xor_hex

                mov dl, al
                mov esi, [ebp + 12]
                mov [esp], esi
                call get_char_from_hex      ; se formeaza un nou caracter din cheie

                xor al, dl
                mov [edi + ebx], al         ; se xoreaza cele 2 caractere si se scrie rezultatul
    
                inc ebx
                jmp decode_bytes_xor_hex
    
return_xor_hex:
                mov [edi + ebx], byte 0     ; se include \0 la finalul string-ului decriptat
                add esp, 4

                leave
                ret


; functia proceseaza un caracter base32 si plaseaza in dl codul acestuia
; @param dl: caracterul procesat
get_code_from_char:
                enter 0, 0

                cmp dl, '='                   ; '=' are valoare de 0
                je found_eq

                cmp dl, '9'
                jbe found_digit

                sub dl, 'A'
                jmp return_check_char

found_digit:
                sub dl, '2'
                add dl, 26
                jmp return_check_char

found_eq:
                xor dl, dl

return_check_char:
                leave
                ret


; functia proceseaza cate 8 caractere din stringul dat si seteaza biti corespunzatori in edi:esi
; se completeaza invers bitii lui esi, apoi tot invers bitii lui edi
; @return esi: primii 32 de biti ai criptarii base32 (in ordine inversa)
; @return edi: ultimii 8 biti din criptarea base32 (in ordine inversa)
get_8_chars:
                enter 0, 0

                xor edi, edi             ; edi:esi
                xor esi, esi

                mov ebx, 5               ; pozitii in string
                mov ecx, 2               ; contine numarul de biti cu care trebuie deplasat un nou cod gasit

first_6_bytes:               ; primele 6 caractere (30 de biti) incap integral in esi 
                xor edx, edx
                mov dl, byte [eax + ebx]
                call get_code_from_char
                shl edx, cl
                lea esi, [esi + edx]

                lea ecx, [ecx + 5]
                cmp ecx, 27               ; offset-ul maxim este 27 = 32 - 5 
                ja next_2_bytes

                dec ebx
                jmp first_6_bytes

; se proceseaza urmatoarele 2 caractere
next_2_bytes:
                xor edx, edx
                mov dl, byte [eax + 6]
                call get_code_from_char
                shr edx, 3                ; cei mai semnificativi 2 biti incap in esi
                lea esi, [esi + edx]

                xor edx, edx
                mov dl, byte [eax + 6]
                call get_code_from_char
                shl edx, 29               ; cei mai nesemnificativi 3 biti raman de pus in edi
                lea edi, [edi + edx]

                xor edx, edx
                mov dl, byte [eax + 7]
                call get_code_from_char
                shl edx, 24               ; al 8-lea caracter din string-ul criptat
                lea edi, [edi + edx]

return_get_8_chars:
                leave
                ret


; se creeaza in string octetii de la pozitiile 3, 2, 1, 0, relativ la o adresa eax,
; ce reprezinta adresa grupulu curent de 8 octeti ce vor fi modificati
make_original_bytes:
                enter 0, 0

                mov ecx, 4

put_bytes: 
                lea edx, [esi]              ; esi contine primii 4 octeti din string-ul orginal
                mov [eax + ecx - 1], dl
                shr esi, 8
                loop put_bytes

                shr edi, 24                 ; se adauga si al 5-lea octet, continut in edi
                lea edx, [edi]
                mov [eax + 4], dl

                leave
                ret


; se vor prelucra cate 8 octeti din input si pe baza bitilor obtinuti din valorile
; corespunzatoare acestor octeti, se va obtine string-ul original
base32decode:
                enter 4, 0

                xor ecx, ecx

; se parcurge inputul in grupuri de cate 8 caractere si se pun inapoi in string cei
; 5 octeti corespunzatori acestor 8 caractere in urma decriptarii
decode_8_bytes_base32decode:
                mov eax, [ebp + 8]
                lea eax, [eax + ecx * 8]

                cmp byte [eax], 0
                je return_base32decode

                mov [esp], ecx
                call get_8_chars                    ; se "populeaza" edi:esi cu bitii celor 8 octeti decriptati la pasul curent
                mov ecx, [esp]                      ; indicele se salveaza indicele grupului curent de octeti

                imul ecx, 5                         ; ecx devine indicele de la care va incepe scrierea caracterelor decriptate
                mov eax, [ebp + 8]
                lea eax, [eax + ecx]                ; se scrie in eax adresa de inceput a string-ului
                call make_original_bytes            ; se scriu in string urmatorii 5 octeti originali 
                mov ecx, [esp]                      ; se reface ecx

                inc ecx
                jmp decode_8_bytes_base32decode

return_base32decode:
                leave
                ret


; intreg string-ul din input se xoreaza cu cheia aflata in bl
; @param ecx: string-ul codat
; @param bl: cheia verificata
xor_current_key:
                enter 0, 0

                xor eax, eax

decode_byte_with_bytekey:
                mov dl, [ecx + eax]
                test dl, dl
                jz return_current_key

                xor dl, bl
                mov [ecx + eax], dl

                inc eax
                jmp decode_byte_with_bytekey

return_current_key:
                leave
                ret


; functia verifica prezenta string-ului "force" in inputul decriptat
; @param edi: adresa lui "force"
; @param ecx: adresa string-ului decriptat
; @param eax: strlen(input)
; @return: 1 daca s-a gasit "force", 0 altfel 
check_force:
                enter 8, 0

                mov [esp + 4], edi        ; se salveaza pe stiva registrele folosite
                mov [esp], ecx
                xor ebx, ebx

find_force:
                cmp ebx, eax
                je return_check_force

                ; se creeaza registrele necesare pentru cmpsb
                mov ecx, 5                      ; strlen("force") = 5
                mov esi, [esp]
                lea esi, [esi + ebx]
                mov edi, [esp + 4]

                repe cmpsb
                jne no_match               ; daca nu s-a gasit "force"

                mov eax, 1                 ; s-a gasit "force", deci se returneaza 1
                jmp return_check_force

no_match:
                inc ebx    
                jmp find_force

return_check_force:
                mov ecx, [esp]             ; se refac registrele initiale
                mov edi, [esp + 4]
                leave
                ret


; se cauta cheile una cate una de la 0 l 255, xorandu-se inputul cu fiecare dintre acestea
; daca dupa o xorare s-a gasit un string ce contine substring-ul "force", cheia este corecta
; @param [ebp + 8]: adresa inputului
; @return: cheia de criptare  
bruteforce_singlebyte_xor:
                enter 7, 0
    
                ; pentru economie de memorie, se va retine "force" in aceasta functie si
                ; memoria se va accesa in check_force prin registrul edi
                mov dword [esp + 1], "forc"
                mov byte [esp + 5], 'e'
                mov byte [esp + 6], 0
                lea edi, [esp + 1]

                xor bl, bl

iterate_keys:
                call xor_current_key

                mov [esp], bl           ; check_force va modifica ebx
                call check_force
                mov bl, byte [esp]      ; se recupereaza bl

                cmp eax, 1              ; daca s-a gasit cheia
                je found_key

                call xor_current_key    ; se reface string-ul de input
                inc bl                  ; se trece la urmatoarea cheie
                jmp iterate_keys

found_key:
                movzx eax, bl           ; se copiaza in eax cheia obtinuta

                leave
                ret


; functia aplica decriptarea in sensul descris de algoritmul Vigenere
; @param [ebp + 8]: adresa string-ul criptat
; @param: [ebp + 12]: adresa cheii
decode_vigenere:
                enter 0, 0

                mov edi, [ebp + 8]
                mov esi, [ebp + 12]

decode_bytes_vigenere:
                mov al, [edi]           ; octetul curent din string

                test al, al             ; s-a terminat string-ul
                jz return_vigenere
                cmp al, 'a'             ; se cauta doar carctere alfabetice
                jb next_char
                cmp al, 'z'
                ja next_char

                sub al, [esi]           ; se presupune initial ca [edi] >= [esi]
                js wrong_shift          ; daca [esi] < [edi]

                add al, 'a'             ; se creeaza un caracter printabil din diferenta anterioara
                jmp put_char

wrong_shift:
                add al, 'z' + 1

put_char:
                mov [edi], al           ; se pune octetul decriptat in string
                inc esi
    
                cmp byte [esi], 0       ; se verifica terminarea cheii
                jne next_char
    
                mov esi, [ebp + 12]
 
next_char:
                inc edi
                jmp decode_bytes_vigenere

return_vigenere:
                leave
                ret


main:
                push ebp
                mov ebp, esp
                sub esp, 2300

                ; test argc
                mov eax, [ebp + 8]
                cmp eax, 2
                jne exit_bad_arg

                ; get task no
                mov ebx, [ebp + 12]
                mov eax, [ebx + 4]
                xor ebx, ebx
                mov bl, [eax]
                sub ebx, '0'
                push ebx

                ; verify if task no is in range
                cmp ebx, 1
                jb exit_bad_arg
                cmp ebx, 6
                ja exit_bad_arg

                ; create the filename
                lea ecx, [filename + 7]
                add bl, '0'
                mov byte [ecx], bl

                ; fd = open("./input{i}.dat", O_RDONLY):
                mov eax, 5
                mov ebx, filename
                xor ecx, ecx
                xor edx, edx
                int 0x80
                cmp eax, 0
                jl exit_no_input

                ; read(fd, ebp - 2300, inputlen):
                mov ebx, eax
                mov eax, 3
                lea ecx, [ebp - 2300]
                mov edx, [inputlen]
                int 0x80
                cmp eax, 0
                jl exit_cannot_read

                ; close(fd):
                mov eax, 6
                int 0x80

                ; all input{i}.dat contents are now in ecx (address on stack)
                pop eax
                cmp eax, 1
                je task1
                cmp eax, 2
                je task2
                cmp eax, 3
                je task3
                cmp eax, 4
                je task4
                cmp eax, 5
                je task5
                cmp eax, 6
                je task6
                jmp task_done

task1:
                push ecx
                call strlen                     ; eax = strlen(ecx)
                mov ecx, [esp]
                lea edx, [ecx + eax + 1]        ; key
                push edx
                push ecx
                call xor_strings

                call puts                       ;print resulting string

                jmp task_done

task2:
                push ecx
                call rolling_xor

                call puts
                add esp, 4

                jmp task_done

task3:
                push ecx
                call strlen                     ; eax = strlen(ecx)
                mov ecx, [esp]
                lea edx, [ecx + eax + 1]        ; key
                push edx
                push ecx
                call xor_hex_strings

                call puts                       ; print resulting string

                jmp task_done

task4:
                push ecx
                call base32decode
    
                call puts                       ; print resulting string

                jmp task_done

task5:
                push ecx
                call bruteforce_singlebyte_xor
                mov [esp], eax                   ; eax = key value

                push ecx                         ; print resulting string
                call puts
                add esp, 4

                push fmtstr
                call printf                      ;print key value

                jmp task_done

task6:
                push ecx
                call strlen
                pop ecx

                lea eax, [eax + ecx + 1]

                push eax
                push ecx                         ;ecx = address of input string 
                call decode_vigenere

                call puts

task_done:
                xor eax, eax
                jmp exit

exit_bad_arg:
                mov ebx, [ebp + 12]
                mov ecx , [ebx]
                push ecx
                push usage
                call printf
                add esp, 8
                jmp exit

exit_no_input:
                push filename
                push error_no_file
                call printf
                add esp, 8
                jmp exit

exit_cannot_read:
                push filename
                push error_cannot_read
                call printf
                add esp, 8
                jmp exit

exit:
                mov esp, ebp
                pop ebp
                ret
