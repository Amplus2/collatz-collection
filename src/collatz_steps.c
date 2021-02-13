#include "collatz.h"
#include <stdint.h>

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
double collatz_steps(double i) {
        double n;
        for(n = 0; i > 1; n++) {
                if(((uint_least64_t)i) % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
