CPPC ?= c++
CPPFLAGS ?= -Wall -Wextra -pedantic -O3 -flto -std=c++14

CPPFLAGS += -Isrc
WASMFLAGS = $(CPPFLAGS) --target=wasm32 -nostdlib -s
WASMFLAGS += -Wl,--lto-O3 -Wl,--no-entry -Wl,--export-all

all: test benchmark wasm

test:
	$(CPPC) $(CPPFLAGS) -o testexe src/collatz.cc test/steps_test.cc
	./testexe

benchmark:
	@$(CPPC) $(WASMFLAGS) -o c.wasm test/benchmark.cc src/collatz.cc
	@time sh -c 'wasmer c.wasm -i main 0 0 >/dev/null'
	@rm -f c.wasm

wasm:
	$(CPPC) $(WASMFLAGS) -o collatz.wasm src/collatz.cc

.PHONY: all test benchmark wasm
