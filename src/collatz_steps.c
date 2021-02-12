#include "collatz_steps.h"
#include <stdio.h>

uint_least64_t collatz_steps(uint_least64_t i) {
        uint_least64_t n;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
