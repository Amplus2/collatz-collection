#include "collatz.h"

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
void collatz_count(int start, int end, int *counts, int count_len) {
        for(int i = start; i < end; i++) {
                int steps = collatz_steps(i);
                if(steps < count_len) counts[steps]++;
        }
}
