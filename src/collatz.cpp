#include "collatz.h"
#include <iostream>

EMSCRIPTEN_KEEPALIVE
extern "C" int collatz_steps(int ibadbecauseonly32bits) {
        int n;
        uint_least64_t i = ibadbecauseonly32bits;
#ifdef DEBUG
        std::cout << "running collatz_steps for " << i << std::endl;
#endif
        for(n = 0; i > 1; n++) {
                if(i % 2 == 0) i /= 2;
                else           i *= 3, i += 1;
        }
        return n;
}

std::map<int, int> collatz_count(int start, int end) {
#ifdef DEBUG
        std::cout << "running collatz_count from "
                  << start << " to " << end << std::endl;
#endif
        std::map<int, int> counts;
        for(int i = start; i < end; i++) {
                counts[collatz_steps(i)]++;
        }
        return counts;
}

std::map<int, int> collatz_batch_steps(int start, int end) {
#ifdef DEBUG
        std::cout << "running collatz_batch_steps from "
                  << start << " to " << end << std::endl;
#endif
        std::map<int, int> steps;
        for(int i = start; i < end; i++) {
                steps[i] = collatz_steps(i);
        }
        return steps;
}
