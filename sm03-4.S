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
	jng end
	mov (%esp), %al
	jmp exit
error:
	mov $-1, %eax
exit:
	add $4, %esp
	pop %ebx
	mov %ebp, %esp
	pop %ebp
	ret
main:
	push %ebx
	mov %al, last_letter
	call readSymb
	mov $1, %ebx
	mov %ebx, empty
main2:
	test %eax, %eax
	jle end
	mov count_symbols, %ebx
	add $1, %ebx
	mov %ebx, count_symbols
	cmp $'\n', %al
	je plus_line_2
plus_line_1:
	cmp $'\n', %al
	je plus_words_1
	cmp $' ', %al
	je plus_words_1
	jmp main
plus_line_2:
	mov count_lines, %ebx
	add $1, %ebx
	mov %ebx, count_lines
	jmp plus_line_1
plus_words_1:
	mov count_words, %ebx
	add $1, %ebx
	mov %ebx, count_words
	mov count_symbols, %ebx
	add $-1, %ebx
	mov %ebx, count_symbols
loop:
	call readSymb
	mov count_symbols, %ebx
	add $1, %ebx
	mov %ebx, count_symbols
	cmp $'\n', %al
	je plus_line_3
	cmp $' ', %al
	je loop
	jmp main2
plus_line_3:
	mov count_lines, %ebx
	add $1, %ebx
	mov %ebx, count_lines
	jmp loop
end:
	cmp $'\n', last_letter
	je no_enter_end
	cmp $0, empty
	je qqq
no_enter_end_2:
	mov count_lines, %eax
	call writei32
	mov count_words, %eax
	call writei32
	mov count_symbols, %eax
	call writei32
	pop %ebx
	call finish
no_enter_end:
	mov count_lines, %ebx
	add $-1, %ebx
	mov %ebx, count_lines
	jmp no_enter_end_2
qqq:
	mov count_symbols, %ebx
	add $-1, %ebx
	mov %ebx, count_symbols
	jmp no_enter_end_2
.data
empty:
	.int 0
last_letter:
	.byte 0
count_words:
	.int 0
count_symbols:
	.int 1
count_lines:
	.int 0
