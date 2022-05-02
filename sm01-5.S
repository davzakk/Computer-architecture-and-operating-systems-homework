.global main
main:
    mov $0, %ebx
    mov $0, %ecx
    l1:
        call readi32
        jc l2
        test $1, %eax
	jnz l4
        jz l3
l3:
    add %eax, %ebx
    jmp l1
l4:
    add %eax, %ecx
    jmp l1
l2:
    mov %ebx, %eax
    call writei32
    mov %ecx, %eax
    call writei32
    call finish
