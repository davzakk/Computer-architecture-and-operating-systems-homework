.text
.global process 
process:
    push %ebp
    mov %esp, %ebp
    mov $0, %ecx
    read:
        call readi32
        jc print
        push %eax
        add $1, %ecx
        jmp read
    print:
        cmp $0, %ecx
        je end
        pop %eax
        call writei32
        sub $1, %ecx
        jmp print
    end:
        mov %ebp, %esp
        pop %ebp
        ret
