.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    // initialization
    mov r0, #10           // n
    and r1, r1, #0        // sum

    // TODO Compute sum of squares; place result in r1
compute_sum:
    mla r1, r0, r0, r1
    subs r0, #1
    bne compute_sum

    // print result
    ldr r0, =output
    bl printf

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
output:
  .asciz "%d\n"
