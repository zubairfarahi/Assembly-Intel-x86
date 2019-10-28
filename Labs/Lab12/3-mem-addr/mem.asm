.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    ldr r4, =nums_size
    ldrb r4, [r4]

print_all:
    ldr r5, =nums
    sub r4, #1
    add r5, r4
    ldrsb r1, [r5]

    // print result
    ldr r0, =output
    bl printf

    tst r4, r4
    bne print_all

return:
    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
nums:
  .byte 5, 2, -3, 7, 8

nums_size:
  .byte 5

output:
  .asciz "%d\n"
