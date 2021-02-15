#include "collatz.h"

EMSCRIPTEN_KEEPALIVE
extern "C" int collatz_steps(int ibadbecauseonly32bits) {
        int n;
        uint_least64_t i = ibadbecauseonly32bits;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
