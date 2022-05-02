    .global main
main:
    call readi64
    mov %edx, %ecx
    mov %eax, %ebx
    shl $1, %ebx
    rcl $1, %ecx 
    call readi64
    shr $1, %edx
    rcr $1, %eax
    sub %eax, %ebx
    sbb %edx, %ecx
    mov %ecx, %edx
    mov %ebx, %eax
    call writei64
    call finish
