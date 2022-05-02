#include <sys/syscall.h>
	.global main
readSymb: // read from seminar 201
	push %ebp
	mov %esp, %ebp
	push %ebx
	.equ READ_FILENO, 0
	sub $4, %esp
	mov $SYS_read, %eax
	mov $READ_FILENO, %ebx
	mov %esp, %ecx
	mov $1, %edx
	int $0x80
	test %eax, %eax
	jng error
	movzb (%esp), %eax
	jmp exit
error:
	mov $-1, %eax
exit:
	add $4, %esp
	pop %ebx
	pop %ebp
	ret
writeSymb: // write from seminar 201 peredelal pod sebya
	push %ebx
	push %ebp
	mov %esp, %ebp
	mov $SYS_write, %eax
	mov $1, %ebx
	sub $4, %esp
	mov %esp, %ecx
	add $4, %esp
	mov $1, %edx
	int $0x80
	pop %ebp
	pop %ebx
	ret
perenos:
	push %ebp
	push %ebx
	movb $'\n', (%esp)
	mov $SYS_write, %eax
	mov $1, %ebx
	mov %esp, %ecx
	mov $1, %edx
	int $0x80
	pop %ebx
	pop %ebp
	movl $0, count_words
	jmp main
main:
	call readSymb
	test %eax, %eax
	jle end
	add $1, count_words
	cmp $'\n', %eax
	je perenos
	cmp $11, count_words
	je ten
writeee: // 10-11 words
	call writeSymb
	jmp main
ten:
	push %ebp
	push %ebx
	movb $'\n', (%esp)
	mov $SYS_write, %eax
	mov $1, %ebx
	mov %esp, %ecx
	mov $1, %edx
	int $0x80
	pop %ebx
	pop %ebp
	movl $1, count_words
	jmp writeee
end:
	cmp $0, count_words
	je final_end
	movb $'\n', (%esp)
	mov $SYS_write, %eax
	mov $1, %ebx
	mov %esp, %ecx
	mov $1, %edx
	int $0x80
final_end:
	mov $SYS_exit, %eax
	mov $0, %ebx
	int $0x80
.data
count_words:
	.int 0
