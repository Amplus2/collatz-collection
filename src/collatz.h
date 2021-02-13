#pragma once
#include <map>
#include <stdint.h>

std::map<int, int> collatz_count(int start, int end);
int collatz_steps(uint_least64_t);
