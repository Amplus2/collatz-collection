#include "collatz.h"

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
void collatz_batch_steps(int start, int end, int *steps) {
        for(int i = start; i < end; i++) {
                steps[i] = collatz_steps(i);
        }
}
