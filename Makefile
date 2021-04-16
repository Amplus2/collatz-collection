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

logo:
	inkscape -w 16 -h 16 logo.svg -o 16.png
	inkscape -w 32 -h 32 logo.svg -o 32.png
	inkscape -w 48 -h 48 logo.svg -o 48.png
	inkscape -w 64 -h 64 logo.svg -o 64.png
	inkscape -w 86 -h 86 logo.svg -o 86.png
	inkscape -w 128 -h 128 logo.svg -o 128.png
	inkscape -w 192 -h 192 logo.svg -o 192.png
	inkscape -w 256 -h 256 logo.svg -o 256.png
	inkscape -w 384 -h 384 logo.svg -o 384.png
	inkscape -w 512 -h 512 logo.svg -o 512.png
	convert 16.png 32.png 48.png 64.png 86.png 128.png 192.png 256.png 384.png 512.png logo.ico
	rm 16.png 32.png 48.png 64.png 86.png 128.png 192.png 256.png 384.png 512.png
