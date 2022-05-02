    .global myexp
myexp:
    push %ebp
    mov %esp, %ebp

    movsd 8(%ebp), %xmm0
    mov	16(%ebp), %eax
    /*x r %xmm2 ans %xmm3 prev*/

    movsd one, %xmm1
    movsd one, %xmm2
    movsd one, %xmm3
    movsd one, %xmm4

    loop:
        movsd %xmm2, %xmm3
        divsd %xmm4, %xmm1
        addsd one, %xmm4
        mulsd %xmm0, %xmm1
        addsd %xmm1, %xmm2
        comisd %xmm3, %xmm2
        jne loop
    movsd %xmm2, (%eax)

    mov %ebp, %esp
    pop %ebp
    ret

one:
    .double 1.0
