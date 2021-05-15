CXX ?= c++
WASMC ?= $(CXX)
WASMRUNNER ?= wasmer
CXXFLAGS ?= -Wall -Wextra -pedantic -O3 -flto -std=c++17

CXXFLAGS += -Isrc
WASMFLAGS ?= $(CXXFLAGS) --target=wasm32 -nostdlib -s -Wl,--lto-O3 -Wl,--no-entry -Wl,--export-all

all: collatz.wasm logo.ico kurs_logo.ico

test:
	$(CXX) $(CXXFLAGS) -o .testexe src/collatz.cc test/steps_test.cc
	./.testexe

benchmark:
	$(WASMC) $(WASMFLAGS) -o .bench.wasm test/benchmark.cc src/collatz.cc
	$(CXX) $(CXXFLAGS) -o .benchmarkexe test/benchmark.cc src/collatz.cc
	time sh -c '$(WASMRUNNER) .bench.wasm -i main 0 0 >/dev/null'
	time ./.benchmarkexe

collatz.wasm: src/collatz.cc
	$(WASMC) $(WASMFLAGS) -o collatz.wasm src/collatz.cc

clean:
	rm -f collatz.wasm *.ico

.PHONY: test

logo.ico: logo.svg
	@mkdir -p tmp
	inkscape -w 32 -h 32 logo.svg -o tmp/logo.svg-32.png
	inkscape -w 64 -h 64 logo.svg -o tmp/logo.svg-64.png
	inkscape -w 96 -h 96 logo.svg -o tmp/logo.svg-96.png
	inkscape -w 128 -h 128 logo.svg -o tmp/logo.svg-128.png
	inkscape -w 160 -h 160 logo.svg -o tmp/logo.svg-160.png
	inkscape -w 192 -h 192 logo.svg -o tmp/logo.svg-192.png
	inkscape -w 224 -h 224 logo.svg -o tmp/logo.svg-224.png
	inkscape -w 256 -h 256 logo.svg -o tmp/logo.svg-256.png
	inkscape -w 288 -h 288 logo.svg -o tmp/logo.svg-288.png
	inkscape -w 320 -h 320 logo.svg -o tmp/logo.svg-320.png
	inkscape -w 352 -h 352 logo.svg -o tmp/logo.svg-352.png
	inkscape -w 384 -h 384 logo.svg -o tmp/logo.svg-384.png
	inkscape -w 416 -h 416 logo.svg -o tmp/logo.svg-416.png
	inkscape -w 448 -h 448 logo.svg -o tmp/logo.svg-448.png
	inkscape -w 480 -h 480 logo.svg -o tmp/logo.svg-480.png
	inkscape -w 512 -h 512 logo.svg -o tmp/logo.svg-512.png
	convert tmp/logo.svg-*.png logo.ico

kurs_logo.ico: kurs_logo.png
	@mkdir -p tmp
	convert kurs_logo.png -resize 32x32 tmp/kurs_logo.png-32.png
	convert kurs_logo.png -resize 64x64 tmp/kurs_logo.png-64.png
	convert kurs_logo.png -resize 96x96 tmp/kurs_logo.png-96.png
	convert kurs_logo.png -resize 128x128 tmp/kurs_logo.png-128.png
	convert kurs_logo.png -resize 160x160 tmp/kurs_logo.png-160.png
	convert kurs_logo.png -resize 192x192 tmp/kurs_logo.png-192.png
	convert kurs_logo.png -resize 224x224 tmp/kurs_logo.png-224.png
	convert kurs_logo.png -resize 256x256 tmp/kurs_logo.png-256.png
	convert kurs_logo.png -resize 288x288 tmp/kurs_logo.png-288.png
	convert kurs_logo.png -resize 320x320 tmp/kurs_logo.png-320.png
	convert kurs_logo.png -resize 352x352 tmp/kurs_logo.png-352.png
	convert kurs_logo.png -resize 384x384 tmp/kurs_logo.png-384.png
	convert kurs_logo.png -resize 416x416 tmp/kurs_logo.png-416.png
	convert kurs_logo.png -resize 448x448 tmp/kurs_logo.png-448.png
	convert kurs_logo.png -resize 480x480 tmp/kurs_logo.png-480.png
	convert kurs_logo.png -resize 512x512 tmp/kurs_logo.png-512.png
	convert tmp/kurs_logo.png-*.png kurs_logo.ico
