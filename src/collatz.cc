#include "collatz.hh"

namespace {
        static constexpr inline void collatz_step(i64 &i) {
                i = i%2 == 0 ? i/2 : i*3+1;
        }
        static constexpr inline void sputs(str &bfr, cstr s) {
                while(*s) *bfr++ = *s++;
        }
        static constexpr inline void sprintd(str &bfr, i64 i) {
                i32 n = 0;
                char tmp[32] = {0};
                char *ptr = &tmp[30];
                do {
                        *ptr-- = '0' + (i % 10);
                        i /= 10;
                        n++;
                } while(i);
                sputs(bfr, ++ptr);
        }
}

CCAPI i32 collatz_steps(i32 ahjs) {
        i64 i = ahjs;
        i32 n;
        for(n = 0; i > 1; n++) {
                collatz_step(i);
        }
        return n;
}

CCAPI i32 collatz_seq(i32 wasmjsbad, str out) {
        str start = out;
        i64 i = wasmjsbad;
        sprintd(out, i);
        while(i > 1) {
                collatz_step(i);
                sputs(out, " → ");
                sprintd(out, i);
        }
        return out - start;
}
