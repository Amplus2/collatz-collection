#pragma once
#include <stdint.h>
#include <map>

int collatz_steps(uint_least64_t);
std::map<int, int> collatz_count(int start, int end);
void collatz_batch_steps(int start, int end, int *steps);
