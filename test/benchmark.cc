#include <collatz.hh>
#include <stdint.h>

int main() {
        volatile i32 j;
        for(uint_fast64_t i = 0; i < 10000000; i++) {
                j = collatz_steps(i);
        }
}
