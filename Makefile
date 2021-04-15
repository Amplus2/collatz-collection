CPPC ?= c++
WASMC ?= $(CPPC)
WASMRUNNER ?= wasmer
CPPFLAGS ?= -Wall -Wextra -pedantic -O3 -flto -std=c++14

CPPFLAGS += -Isrc
WASMFLAGS ?= $(CPPFLAGS) --target=wasm32 -nostdlib -s \
	     -Wl,--lto-O3 -Wl,--no-entry -Wl,--export-all

all: test benchmark wasm

test:
	$(CPPC) $(CPPFLAGS) -o .testexe src/collatz.cc test/steps_test.cc
	@./.testexe

benchmark:
	@$(WASMC) $(WASMFLAGS) -o .bench.wasm test/benchmark.cc src/collatz.cc
	@$(CPPC) $(CPPFLAGS) -o .benchmarkexe test/benchmark.cc src/collatz.cc
	@time sh -c '$(WASMRUNNER) .bench.wasm -i main 0 0 >/dev/null'
	@time ./.benchmarkexe

wasm:
	$(WASMC) $(WASMFLAGS) -o collatz.wasm src/collatz.cc

.PHONY: all test benchmark wasm
