.text
.global list_reverse
list_reverse:
	mov $0, %edx
    	mov head, %eax
    	loop:
		cmp $0, %eax
        		je end
		mov 8(%eax), %ecx 
        		mov %edx, 8(%eax)
        		mov %eax, %edx
        		mov %ecx, %eax
        		jmp loop
    	end:
	 	mov %edx, head
        		ret
