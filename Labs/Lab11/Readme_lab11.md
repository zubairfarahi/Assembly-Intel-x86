
# Lab0xB - optimizations

- optimizations of size and execution time both in * C * and at * Assembly * level

## 1-2-loop-unrolling

- doing * loop unrolling * eliminates `3 * N` operations of type` cmp`, `jmp` and` add`, which leads to a reduction of the execution time;

- the execution times vary because they depend on the way the processor executes the instructions (including the ones in the system) and the data flow;

- `normal_loop_op` no longer performs` force 'because the compiler has decided that since `sum` is not used anywhere, it is redundant;

- when the amount is displayed, it becomes important, and the compiler no longer eliminates the force, but only optimizes it;

- The compiler optimization is based on the exclusive use of registers for the `force 'scan:` eax` is the vector address, `edx` is the end address of the vector, and` esi` is the sum;

- when `N` is small (10), the compiler does * loop unrolling * itself to reduce running time;

- the difference in performance is not large, and now the times are greater than those obtained with * normal_loop_op *, because now the same accesses to memory that were needed and before the optimization with `-O3` are needed, so they cannot be Use only registers to calculate the amount.

## 3-optimization

- Since N is known, all sums can be calculated mathematically, in `O (1) '.

## 4-string-instructions

- it is observed that the hardware loops (`scasb`) are slower in execution than the software ones (` inc`, `cmp`,` jmp`);

- the test input is in `file.txt`.

## 5-profiling

- the use of the profiling mnemonic `rdtsc` is illustrated.

## 6-optimize-assembly

- the code from `optimize.asm` calculates the sum of the first` N` elements in a vector;

- within the optimization, the vector is searched from the end to the beginning, and the sum is calculated using the mnemonic `lea`;

- also, in order not to make a comparison unnecessary, the * jump * is executed only if the instruction `dec` has not set` ZF`;

- Since there is no need for local variables in this function, it does not make sense to create a * stack frame *, which reduces the size of the program.