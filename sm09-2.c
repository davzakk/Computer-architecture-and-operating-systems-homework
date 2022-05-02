#include <sys/syscall.h>
#include <string.h>

void _start() {
    char* s = "hello world\n";
    int sz = strlen(s);
    asm volatile (
        "mov $1, %%ebx\n\t"
        "mov %[sz], %%edx\n\t"
        "mov %[s], %%ecx\n\t"
        "mov %[sw], %%eax\n\t"
        "int $0x80\n\t"

        "mov %[se], %%eax\n\t"
	    "mov $0, %%ebx\n\t"
	    "int $0x80\n\t"

        : //[num] "=g" (num), [ecx] "=g" (ecx), [edx] "=g" (edx)
        : [s] "g" (s), [sz] "g" (sz), [sw] "g" (SYS_write), [se] "g" (SYS_exit)
        : "eax", "ebx", "ecx", "edx"
    );
}
