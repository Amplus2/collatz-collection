#include "collatz.hh"

CCAPI i32 collatz_steps(i32 ahjs) {
        i64 i = ahjs;
        i32 n;
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}
