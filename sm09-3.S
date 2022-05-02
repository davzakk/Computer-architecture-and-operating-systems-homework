    .global myhypot
myhypot:
    push %ebp
    mov %esp, %ebp
    /*xyr*/
    movsd	8(%ebp), %xmm0
    movsd	16(%ebp), %xmm1
    mov	24(%ebp), %ecx


    mulsd %xmm0, %xmm0
    mulsd %xmm1, %xmm1
    addsd %xmm0, %xmm1
    sqrtsd %xmm1, %xmm1
    movsd %xmm1, (%ecx)

    pop %ebp
    ret
