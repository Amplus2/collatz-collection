#include "collatz.h"
#include <map>

EMSCRIPTEN_KEEPALIVE
std::map<int, int> collatz_count(int start, int end) {
        std::map<int, int> counts;
        for(int i = start; i < end; i++) {
                counts[collatz_steps(i)]++;
        }
        return counts;
}
