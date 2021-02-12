#include "collatz_steps.h"
#include <stdio.h>

//(define (collatz_steps i) (
//    if (< i 2) 0
//    (+ 1 (collatz_steps
//     (if (= (remainder i 2) 0)
//      (/ i 2)
//     (+ (* i 3) 1))
//    ))
//))

uint_least64_t collatz_steps(uint_least64_t i) {
        return i < 2 ? 0 : 1 + collatz_steps(i % 2 == 0 ? i/2 : 1+i*3);
}
