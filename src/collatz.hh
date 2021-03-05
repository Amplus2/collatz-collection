#pragma once

#ifdef EMSCRIPTEN_KEEPALIVE
# define CCAPI EMSCRIPTEN_KEEPALIVE extern "C"
#else
# define CCAPI extern "C"
#endif

CCAPI int collatz_steps(double);
