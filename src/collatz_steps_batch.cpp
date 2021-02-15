#include "collatz.h"

std::map<int, int> collatz_batch_steps(int start, int end) {
        std::map<int, int> steps;
        for(int i = start; i < end; i++) {
                steps[i] = collatz_steps(i);
        }
        return steps;
}
