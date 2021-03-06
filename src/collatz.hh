#pragma once
#include <stdint.h>

#ifdef __cplusplus
# define CCAPI extern "C"
#else
# define CCAPI
#endif

CCAPI int collatz_steps(double);
