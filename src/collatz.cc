#include "collatz.hh"

CCAPI i64 collatz_steps(i64 i) {
        i64 n;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
