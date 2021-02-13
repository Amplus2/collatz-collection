#include "collatz.h"

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
void collatz_count(double start, double end, double *count, double countLen) {
        for(int i = 0; i < countLen; i++) {
                count[i] = 0;
        }
        for(double i = start; i < end; i++) {
                double steps = collatz_steps(i);
                if(steps < countLen) count[(int)steps]++;
        }
}
