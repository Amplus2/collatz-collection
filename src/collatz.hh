#pragma once
#include <stdint.h>

#define i32 uint_fast32_t
#define i64 uint_fast64_t

#ifdef __cplusplus
# define CCAPI extern "C"
#else
# define CCAPI
#endif

CCAPI i32 collatz_steps(i32);
