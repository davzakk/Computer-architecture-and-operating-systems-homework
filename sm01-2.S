    .global main
main:
    call readi32
    cmp $0, %eax
    l1:
    	jl l3
        call writei32
	add $-1, %eax
        cmp $0, %eax
	jmp l1
l3:
    call finish
