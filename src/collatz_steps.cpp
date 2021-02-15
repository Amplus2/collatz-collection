#include "collatz.h"

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
int collatz_steps(double i) {
        int n;
        for(n = 0; i > 1; n++) {
                if(((uint_least64_t)i) % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
