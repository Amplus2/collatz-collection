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

%.ico: %.svg
	@mkdir -p tmp
	inkscape -w 32 -h 32 $< -o tmp/$*-32.png 2>/dev/null
	inkscape -w 64 -h 64 $< -o tmp/$*-64.png 2>/dev/null
	inkscape -w 96 -h 96 $< -o tmp/$*-96.png 2>/dev/null
	inkscape -w 128 -h 128 $< -o tmp/$*-128.png 2>/dev/null
	inkscape -w 160 -h 160 $< -o tmp/$*-160.png 2>/dev/null
	inkscape -w 192 -h 192 $< -o tmp/$*-192.png 2>/dev/null
	inkscape -w 224 -h 224 $< -o tmp/$*-224.png 2>/dev/null
	inkscape -w 256 -h 256 $< -o tmp/$*-256.png 2>/dev/null
	inkscape -w 288 -h 288 $< -o tmp/$*-288.png 2>/dev/null
	inkscape -w 320 -h 320 $< -o tmp/$*-320.png 2>/dev/null
	inkscape -w 352 -h 352 $< -o tmp/$*-352.png 2>/dev/null
	inkscape -w 384 -h 384 $< -o tmp/$*-384.png 2>/dev/null
	inkscape -w 416 -h 416 $< -o tmp/$*-416.png 2>/dev/null
	inkscape -w 448 -h 448 $< -o tmp/$*-448.png 2>/dev/null
	inkscape -w 480 -h 480 $< -o tmp/$*-480.png 2>/dev/null
	inkscape -w 512 -h 512 $< -o tmp/$*-512.png 2>/dev/null
	convert tmp/$*-*.png $@

%.ico: %.png
	@mkdir -p tmp
	convert $< -resize 32x32 tmp/$*-32.png
	convert $< -resize 64x64 tmp/$*-64.png
	convert $< -resize 96x96 tmp/$*-96.png
	convert $< -resize 128x128 tmp/$*-128.png
	convert $< -resize 160x160 tmp/$*-160.png
	convert $< -resize 192x192 tmp/$*-192.png
	convert $< -resize 224x224 tmp/$*-224.png
	convert $< -resize 256x256 tmp/$*-256.png
	convert $< -resize 288x288 tmp/$*-288.png
	convert $< -resize 320x320 tmp/$*-320.png
	convert $< -resize 352x352 tmp/$*-352.png
	convert $< -resize 384x384 tmp/$*-384.png
	convert $< -resize 416x416 tmp/$*-416.png
	convert $< -resize 448x448 tmp/$*-448.png
	convert $< -resize 480x480 tmp/$*-480.png
	convert $< -resize 512x512 tmp/$*-512.png
	convert tmp/$*-*.png $@
