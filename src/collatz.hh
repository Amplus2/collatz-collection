#pragma once
#include <stdint.h>

typedef uint_fast32_t i32;
typedef uint_fast64_t i64;
typedef char *str;
typedef const char *cstr;

#ifdef __cplusplus
# define CCAPI extern "C"
#else
# define CCAPI
#endif

CCAPI i32 collatz_steps(i32);
CCAPI i32 collatz_seq(i32, str);
