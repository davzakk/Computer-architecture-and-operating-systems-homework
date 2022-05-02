#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <inttypes.h>
#include <math.h>


int main() {
    union ufloat {
        uint32_t u;
        float f;
    };
    union ufloat v;
    while (scanf("%f", &v.f) == 1) {
        uint32_t s = 0, exp = 0, frac = 0, v_copy = v.u, counter = 0;
        for (uint32_t i = 1; i != 0; i *= 2) {
            if (0 <= counter && counter <= 22) {
                frac += v_copy & i;
            } else if (23 <= counter && counter <= 30) {
                exp += v_copy & i;
            } else if (counter == 31) {
                s += v_copy & i;
            }
            counter++;
        }
        exp >>= 23;
        s >>= 31;
        printf("%u %u %x\n", s, exp, frac);
        //printf("%u %u %u\n", s, exp, frac);
    }
}
