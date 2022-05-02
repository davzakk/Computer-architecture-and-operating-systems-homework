#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <inttypes.h>
#include <math.h>

int main() {
    uint32_t family = 0, ex_family = 0, model = 0, ex_model = 0, ecx, edx, num, counter = 0;
    asm volatile(
        "mov $1, %%eax\n\t"
        "cpuid\n\t"
        "mov %%ecx, %[ecx]\n\t"
        "mov %%edx, %[edx]\n\t"
        "mov %%eax, %[num]\n\t"

        : [num] "=g" (num), [ecx] "=g" (ecx), [edx] "=g" (edx)
        : //[a] "g" (a) , [b] "g" (b)
        : "eax", "ebx", "ecx", "edx"
    );
    family = (num >> 8) & 0x0000000f;
    model = (num >> 4) & 0x0000000f;
    ex_model = (num >> 12) & 0x000000f0;
    ex_family = (num >> 20) & 0x000000ff;
    if (family == 15) {
        family += ex_family;
        model += ex_model;
    } else if (family == 6) {
        model += ex_model;
    }
    printf("family=%u ", family);
    printf("model=%u ", model);
    printf("ecx=0x%x ", ecx);
    printf("edx=0x%x\n", edx);
}
