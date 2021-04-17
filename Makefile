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

RESOLUTIONS = 32 64 96 128 160 192 224 256 288 320 352 384 416 448 480 512

logo:
	@mkdir -p tmp
	for i in $(RESOLUTIONS) ; do \
		inkscape -w $$i -h $$i logo.svg -o tmp/$$i.png ; \
		TMP="$$TMP tmp/$$i.png" ; \
	done ; \
	convert $$TMP logo.ico ; \
	printf "\n\nsizes=\"" ; \
	for i in $(RESOLUTIONS) ; do \
		printf "$${i}x$$i " ; \
	done ; \
	echo \"
