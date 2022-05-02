.text // источник лекция 4
.global free_mem
.global freelist

free_mem:
push %ebp
    mov %esp, %ebp

	mov 8(%ebp), %ecx
	sub $4, %ecx
	mov freelist, %edx
	mov %edx, 4(%ecx)
	mov %ecx, freelist
mov %ebp, %esp
    pop %ebp
	ret
.data
freelist:
	.int 0
heapstart:
	.int 0
heapend:
	.int 0
