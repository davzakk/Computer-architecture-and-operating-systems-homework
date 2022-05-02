.global main
main:
    mov $0, %eax
    mov $0, %ebx
    l1:
        add %eax, %ebx
        jo l2
        call readi32  
  jae l1
    mov %ebx, %eax
    call writei32
    call finish
l2:
    shr $31, %eax
    add $0x7FFFFFFF, %eax
    call writei32
    call finish
