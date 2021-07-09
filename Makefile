CXX ?= c++
WASMC ?= clang++
WASMRUNNER ?= wasmer
CXXFLAGS ?= -Wall -Wextra -pedantic -O3 -flto -std=c++17
WASMFLAGS ?= $(CXXFLAGS) --target=wasm32 -nostdlib -s -Wl,--lto-O3 -Wl,--no-entry -Wl,--export-all

HTMLS = index.html stats/index.html seq/index.html

all: collatz.wasm logo.ico kurs_logo.ico qr.png graph/graph.svg $(HTMLS)

test:
	@mkdir -p tmp
	$(CXX) $(CXXFLAGS) -o tmp/testexe test.cc
	tmp/testexe

benchmark:
	@mkdir -p tmp
	$(WASMC) $(WASMFLAGS) benchmark.cc -o tmp/bench.wasm
	$(CXX) $(CXXFLAGS) benchmark.cc -o tmp/benchmarkexe
	time sh -c '$(WASMRUNNER) tmp/bench.wasm -i main 0 0 >/dev/null'
	time tmp/benchmarkexe

%.wasm: %.cc
	$(WASMC) $(WASMFLAGS) $< -o $@

clean:
	rm -rf collatz.wasm *.ico tmp/

qr.png:
	qrencode -o qr.png "https://www.gymnasium-pegnitz.de/unterricht/faecher/mathematik/SpielMalMathe/"

graph/pubspec.lock: graph/pubspec.yaml
	cd graph && dart pub get

graph/graph.dot: graph/main.dart graph/pubspec.lock
	dart run graph/main.dart > graph/graph.dot

graph/graph.svg: graph/graph.dot
	dot -Tsvg -o graph/graph.svg graph/graph.dot

index.html: tools/tmplt raw/index.html
	tools/tmplt "" collatz-collection < raw/index.html > index.html

stats/index.html: tools/tmplt raw/stats.html
	tools/tmplt ../ "Statistiken zur Collatz-Folge" < raw/stats.html > stats/index.html

seq/index.html: tools/tmplt raw/seq.html
	tools/tmplt ../ Collatz-Folge < raw/seq.html > seq/index.html

.PHONY: all benchmark clean test

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
