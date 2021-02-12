#include "collatz_steps.h"

//(define (collatz_steps i) (
//    if (< i 2) 0
//    (+ 1 (collatz_steps
//     (if (= (remainder i 2) 0)
//      (/ i 2)
//     (+ (* i 3) 1))
//    ))
//))

unsigned collatz_steps(unsigned i) {
        if(i < 2) return 0;
        int n = (i % 2 == 0) ? i/2 : 1+i*3;
        return 1 + collatz_steps(n);
}
