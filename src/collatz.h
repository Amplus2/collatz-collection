#pragma once
#include <stdint.h>

int collatz_steps(uint_least64_t);
void collatz_count(int start, int end, int *counts, int count_len);
void collatz_batch_steps(int start, int end, int *steps);
