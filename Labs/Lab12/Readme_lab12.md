
# Lab0xC - ARM Assembly

- a few basic programs are implemented, for initiation into * ARM Assembly *

## 1-install-toolchain

- the directory contains the script `install_toolchain.sh` installs the utilities necessary to compile * ARM Assembly *;

- the resulting binaries will be run using the virtual machine * qemu *;

- `hello-world.asm` is a test program to check the functioning of the toolchain.

## 2-mul-sum

- it is calculated and displayed using `printf` the sum of the squares of the first 10 natural numbers.

## 3-self-addr

- the program displays the elements of a vector of numbers up to 127 (`byte ') in reverse order.

## 4-flags

- the operation of * break * (`b`) together with` ZF` (`beq`) is observed.

## 5-strings

- the length of a string is calculated by boosting the `strlen` function;

- a subset is searched in a string, by the `strstr` function;

- this function, in turn, checks for each position in the string, if the subset that starts at this starts with the desired subset, calling `starts_with`.