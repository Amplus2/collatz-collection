#include "collatz.h"

#ifdef EMSCRIPTEN_KEEPALIVE
EMSCRIPTEN_KEEPALIVE
#endif
std::map<int, int> collatz_count(int start, int end) {
        std::map<int, int> counts;
        for(int i = start; i < end; i++) {
                counts[collatz_steps(i)]++;
        }
        return counts;
}
