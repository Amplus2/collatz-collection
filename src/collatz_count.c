#include "collatz_count.h"
#include "collatz_steps.h"
#include <stdlib.h>
#include <string.h>

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
double *collatz_count(double start, double end, double countLen) {
        double *count = malloc(countLen * sizeof(double));
        bzero(count, countLen * sizeof(double));
        for(double i = start; i < end; i++) {
                count[(int)collatz_steps(i)]++;
        }
        return count;
}

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
void collatz_free_count(double *a) {
        free(a);
}
