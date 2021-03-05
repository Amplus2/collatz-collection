#include "collatz.hh"
#include <stdint.h>

CCAPI int collatz_steps(double doublesarebad) {
        uint_fast64_t i = doublesarebad;
        int n;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
