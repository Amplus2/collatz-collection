#include "collatz.hh"

EMSCRIPTEN_KEEPALIVE
extern "C" int collatz_steps(double doublesarebad) {
        int n;
        uint_least64_t i = doublesarebad;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}

EMSCRIPTEN_KEEPALIVE
extern "C" void collatz_count(int start, int end, int *values) {
        for(int i = start; i < end; i++) {
                values[collatz_steps(i) - 1]++;
        }
}

EMSCRIPTEN_KEEPALIVE
extern "C" void collatz_batch_steps(int start, int end, int *values) {
        for(int i = start; i < end; i++) {
                values[i - start] = collatz_steps(i);
        }
}
