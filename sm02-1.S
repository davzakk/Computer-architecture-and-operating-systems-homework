.data
    .global A
    .global B
    .global R
A: .int 0
B: .int 0
R: .int 0
.text
.global process
process:
    push %ebp
    mov %esp, %ebp
    mov $0, %ecx

    mov A, %eax
    mov $0, %edx
    cmp $0, %eax
    je l3
    mov B, %ecx
    cmp $0, %ecx
    je l3

    cmp %eax, %ecx
    jb l4
l5:
    cmp $0, %eax
    ja l1
    l2:
        sub %ecx, %edx
        inc %eax
        je l3
        jmp l2
    l1:
        add %ecx, %edx
        dec %eax
        je l3
        jmp l1
    
    l3:
	mov %edx, R

        mov %ebp, %esp
        pop %ebp
        ret
l4:
    xchg %eax, %ecx
    jmp l5
