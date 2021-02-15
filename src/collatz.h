#pragma once
#include <stdint.h>

int collatz_steps(double);
void collatz_count(int start, int end, int *counts, int count_len);
void collatz_batch_steps(int start, int end, int *steps);
