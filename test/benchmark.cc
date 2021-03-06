#include <collatz.hh>
#include <stdint.h>

int main() {
        int i;
        volatile int *j = &i;
        for(uint_fast64_t i = 0; i < 10000000; i++) {
                *j = collatz_steps(i);
        }
}
