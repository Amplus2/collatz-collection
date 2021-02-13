#include "collatz_count.h"
#include "collatz_steps.h"
#include <stdlib.h>
#include <string.h>

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
double *collatz_count(double *range, double rangeLen, double countLen) {
        double *count = malloc(countLen * sizeof(double));
        bzero(count, countLen * sizeof(double));
        for(int i = 0; i < rangeLen; i++) {
                count[(int)collatz_steps(range[i])] = range[i];
        }
        return count;
}

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
void collatz_free_count(double *a) {
        free(a);
}
