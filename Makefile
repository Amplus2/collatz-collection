CXX ?= c++
WASMC ?= clang++
WASMRUNNER ?= wasmer
CXXFLAGS ?= -Wall -Wextra -pedantic -O3 -flto -std=c++17

CXXFLAGS += -Isrc
WASMFLAGS ?= $(CXXFLAGS) --target=wasm32 -nostdlib -s -Wl,--lto-O3 -Wl,--no-entry -Wl,--export-all

all: collatz.wasm logo.ico kurs_logo.ico

test:
	@mkdir -p tmp
	$(CXX) $(CXXFLAGS) -o tmp/testexe test/steps_test.cc
	tmp/testexe

benchmark:
	@mkdir -p tmp
	$(WASMC) $(WASMFLAGS) -o tmp/bench.wasm test/benchmark.cc
	$(CXX) $(CXXFLAGS) -o tmp/benchmarkexe test/benchmark.cc
	time sh -c '$(WASMRUNNER) tmp/bench.wasm -i main 0 0 >/dev/null'
	time tmp/benchmarkexe

collatz.wasm: src/collatz.cc
	$(WASMC) $(WASMFLAGS) -o collatz.wasm src/collatz.cc

clean:
	rm -rf collatz.wasm *.ico tmp/

.PHONY: test clean all

logo.ico: logo.svg
	@mkdir -p tmp
	inkscape -w 32 -h 32 logo.svg -o tmp/logo-32.png
	inkscape -w 64 -h 64 logo.svg -o tmp/logo-64.png
	inkscape -w 96 -h 96 logo.svg -o tmp/logo-96.png
	inkscape -w 128 -h 128 logo.svg -o tmp/logo-128.png
	inkscape -w 160 -h 160 logo.svg -o tmp/logo-160.png
	inkscape -w 192 -h 192 logo.svg -o tmp/logo-192.png
	inkscape -w 224 -h 224 logo.svg -o tmp/logo-224.png
	inkscape -w 256 -h 256 logo.svg -o tmp/logo-256.png
	inkscape -w 288 -h 288 logo.svg -o tmp/logo-288.png
	inkscape -w 320 -h 320 logo.svg -o tmp/logo-320.png
	inkscape -w 352 -h 352 logo.svg -o tmp/logo-352.png
	inkscape -w 384 -h 384 logo.svg -o tmp/logo-384.png
	inkscape -w 416 -h 416 logo.svg -o tmp/logo-416.png
	inkscape -w 448 -h 448 logo.svg -o tmp/logo-448.png
	inkscape -w 480 -h 480 logo.svg -o tmp/logo-480.png
	inkscape -w 512 -h 512 logo.svg -o tmp/logo-512.png
	convert tmp/logo-*.png logo.ico

kurs_logo.ico: kurs_logo.svg
	@mkdir -p tmp
	inkscape -w 32 -h 32 kurs_logo.svg -o tmp/kurs_logo-32.png
	inkscape -w 64 -h 64 kurs_logo.svg -o tmp/kurs_logo-64.png
	inkscape -w 96 -h 96 kurs_logo.svg -o tmp/kurs_logo-96.png
	inkscape -w 128 -h 128 kurs_logo.svg -o tmp/kurs_logo-128.png
	inkscape -w 160 -h 160 kurs_logo.svg -o tmp/kurs_logo-160.png
	inkscape -w 192 -h 192 kurs_logo.svg -o tmp/kurs_logo-192.png
	inkscape -w 224 -h 224 kurs_logo.svg -o tmp/kurs_logo-224.png
	inkscape -w 256 -h 256 kurs_logo.svg -o tmp/kurs_logo-256.png
	inkscape -w 288 -h 288 kurs_logo.svg -o tmp/kurs_logo-288.png
	inkscape -w 320 -h 320 kurs_logo.svg -o tmp/kurs_logo-320.png
	inkscape -w 352 -h 352 kurs_logo.svg -o tmp/kurs_logo-352.png
	inkscape -w 384 -h 384 kurs_logo.svg -o tmp/kurs_logo-384.png
	inkscape -w 416 -h 416 kurs_logo.svg -o tmp/kurs_logo-416.png
	inkscape -w 448 -h 448 kurs_logo.svg -o tmp/kurs_logo-448.png
	inkscape -w 480 -h 480 kurs_logo.svg -o tmp/kurs_logo-480.png
	inkscape -w 512 -h 512 kurs_logo.svg -o tmp/kurs_logo-512.png
	convert tmp/kurs_logo-*.png kurs_logo.ico
