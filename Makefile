CPPC = clang++

WASM_CPP_FLAGS = --target=wasm32 -flto -nostdlib -O3 -Wl,--no-entry -Wl,--export-all

wasm:
	$(CPPC) $(WASM_CPP_FLAGS) -o collatz.wasm src/collatz.cc

