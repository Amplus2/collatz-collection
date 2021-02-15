#pragma once
#include <stdint.h>
#include <map>

int collatz_steps(int);
std::map<int, int> collatz_count(int start, int end);
std::map<int, int> collatz_batch_steps(int start, int end);

#ifndef EMSCRIPTEN
#define EMSCRIPTEN_KEEPALIVE
#endif
