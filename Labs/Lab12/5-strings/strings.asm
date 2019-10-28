.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    // pretty print
    ldr r0, =printlen
    bl printf

    // TODO 1: call strlen
    ldr r0, =str
    bl strlen

    // TODO 1: call printf to print result of strlen
    // pretty print
    mov r1, r0
    ldr r0, =output
    bl printf

    // print occurences pretty string
    ldr r0, =printocr
    bl printf

    // TODO 3: call substr
    ldr r0, =str
    ldr r1, =subs
    bl substr

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}


// TODO 1: implement strlen
strlen:
    push {r11}
    add r11, sp, #0

    mov r2, r0

find_length:
    ldrb r1, [r0]
    cmp r1, #0
    beq return_strlen

    add r0, #1
    b find_length

return_strlen:
    sub r0, r2

    sub sp, r11, #0
    pop {r11}
    bx lr


// TODO 2: implement starts_with
starts_with:
    push {r11}
    add r11, sp, #0

compare_strings:
    ldrb r3, [r1]
    ldrb r2, [r0]

    cmp r3, #0
    beq does_not_start
    cmp r2, #0
    beq does_start

    cmp r3, r2
    bne does_not_start

    add r1, #1
    add r0, #1
    b compare_strings

does_start:
    mov r0, #1
    b return_starts_with

does_not_start:
    mov r0, #0

return_starts_with:
    sub sp, r11, #0
    pop {r11}
    bx lr


// TODO 3: implement substr
substr:
    push {r4, r5, r6, r11, lr}
    add r11, sp, #0

iterate_str:
    ldrb r2, [r0]
    cmp r2, #0
    beq return_substr

    mov r4, r0
    ldr r5, =output
    sub r4, r5

    push {r0, r1}
    bl starts_with

    cmp r0, #0
    beq next_char

    ldr r0, =output
    mov r1, r4
    bl printf

next_char:
    pop {r0, r1}
    add r0, #1
    b iterate_str

return_substr:
    sub sp, r11, #0
    pop {r4, r5, r6, r11, pc}


.data
str:
  .asciz "This string is the bomb"
subs:
  .asciz "is"
output:
  .asciz "%d\n"
chr:
  .asciz "%c\n"
printlen:
  .asciz "String length is:\n"
printocr:
  .asciz "Substring appears at positions:\n"
