.data
        .text
        .global dot_product

dot_product:
        push    %ebp
        mov     %esp, %ebp

        push    %esi
        push    %ebx

        mov     8(%ebp), %eax   //int
        mov     12(%ebp), %ebx  // double pointer
        mov     16(%ebp), %edx  // double pointer
        mov     20(%ebp), %ecx  // double pointer

        // esi - counter
        mov     $0, %esi
        // xmm2 - result
        xorps   %xmm2, %xmm2

for:
        cmpl    %eax, %esi
        je      fin

        // 1st double array
        movss   (%ebx), %xmm0
        // 2st double array
        movss   (%edx), %xmm1
        mulps   %xmm1, %xmm0
        addps   %xmm0, %xmm2

        addl    $4, %ebx
        addl    $4, %edx
        decl    %eax
        jmp     for
fin:
        movss   %xmm2, (%ecx)
 
        pop     %ebx
        pop     %esi
        mov     %ebp, %esp
        pop     %ebp
        ret
