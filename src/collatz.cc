#include "collatz.hh"

namespace {
        static inline i64 collatz_step(i64 i) {
                return i%2 == 0 ? i/2 : i*3+1;
        }
        static inline i32 sprintd(str bfr, i64 i) {
                i32 n = 0;
                char tmp[32];
                tmp[31] = '\0';
                char *ptr = &tmp[30];
                do {
                        *ptr-- = '0' + (i % 10);
                        i /= 10;
                        n++;
                } while(i);
                ptr++;
                while(*ptr) *bfr++ = *ptr++;
                return n;
        }
}

CCAPI i32 collatz_steps(i32 ahjs) {
        i64 i = ahjs;
        i32 n;
        for(n = 0; i > 1; n++) {
                i = collatz_step(i);
        }
        return n;
}

CCAPI i32 collatz_seq(i32 wasmjsbad, str out) {
        str start = out;
        i64 i = wasmjsbad;
        out += sprintd(out, i);
        while(i > 1) {
                i = collatz_step(i);
                *out++ = ' ';
                *out++ = '-';
                *out++ = '>';
                *out++ = ' ';
                out += sprintd(out, i);
        }
        return out - start;
}
