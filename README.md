# collatz-collection
A collection of games and interactive statistics about the Collatz conjecture.

## Our topic: The Collatz conjecture
### 1. Procedure
Start with a number n ∊ ℕ
- If n is even → n becomes n / 2.
- If n is odd → n becomes 3n + 1.
- Repeat

### 2. Examples
8 → 4 → 2 → 1 → 4 → ...

5 → 16 → 8 → 4 → 2 → 1 → 4 → ...

### 3. Conclusion
Any number sequence of a starting number n ∊ ℕ (Collatz sequence)
ends in the following scheme 4 → 2 → 1 → 4 → ...

### 4. Problem
1.3 has not been proven.

### 5. Collatz-Steps
The length of the Collatz sequence is the number of steps required
to get to the value 1.

## Technical information
cc is built using completely static HTML, CSS and JS, as well as some C++ that
is compiled to WebAssembly for performance.

### Dependencies
For a full rebuild of cc you will need the following software packages:
* [`make`](https://www.gnu.org/software/make/)
* [`python3`](https://www.python.org)
* [`inkscape`](https://inkscape.org)
* [`imagemagick`](https://imagemagick.org)
* [`clang++`](https://clang.llvm.org)
* optionally [`wasmer`](https://wasmer.io) for testing

### Building
0. Delete the previous build: `make clean`
1. Build: `make -j$(nproc) all`
2. Optionally test and benchmark: `make test benchmark`
