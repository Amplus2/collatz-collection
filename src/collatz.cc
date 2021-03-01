#include "collatz.hh"
#include <stdint.h>

CCAPI int collatz_steps(double doublesarebad) {
        int n;
        uint_fast64_t i = doublesarebad;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}

CCAPI void collatz_count(int start, int end, int *counts, int count_len) {
        for(int i = start; i < end; i++) {
                int steps = collatz_steps(i);
                if(steps < count_len) counts[steps]++;
        }
}

CCAPI void collatz_batch_steps(int start, int end, int *steps) {
        for(int i = start; i < end; i++) {
                steps[i] = collatz_steps(i);
        }
}
