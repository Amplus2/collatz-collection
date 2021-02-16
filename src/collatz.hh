#pragma once
#include <stdint.h>

extern "C" int  collatz_steps(double);
extern "C" void collatz_count(int start, int end, int *keys, int *values);
extern "C" void collatz_batch_steps(int start, int end, int *keys, int *values);

#ifndef EMSCRIPTEN_KEEPALIVE
#define EMSCRIPTEN_KEEPALIVE
#endif
