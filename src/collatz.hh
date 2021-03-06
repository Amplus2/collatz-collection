#pragma once
#include <stdint.h>

#define i64 uint_fast64_t

#ifdef __cplusplus
# define CCAPI extern "C"
#else
# define CCAPI
#endif

CCAPI i64 collatz_steps(i64);
