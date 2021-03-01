#pragma once

#ifdef EMSCRIPTEN_KEEPALIVE
# define CCAPI EMSCRIPTEN_KEEPALIVE extern "C"
#else
# define CCAPI extern "C"
#endif

CCAPI int  collatz_steps(double);
CCAPI void collatz_count(int start, int end, int *counts, int count_len);
CCAPI void collatz_batch_steps(int start, int end, int *steps);
