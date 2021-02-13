#pragma once
#include <map>
#include <stdint.h>

int collatz_steps(uint_least64_t);
std::map<int, int> collatz_count(int start, int end);
std::map<int, int> collatz_batch_steps(int start, int end);
