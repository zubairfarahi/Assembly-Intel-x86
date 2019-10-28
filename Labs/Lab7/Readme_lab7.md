# Lab 7 - working with the stack

- operations with a stack of x86 system;

- `esp`,` ebp`;

- `push`,` pop`;

- before the end of the program, the base and the tip of the stack are resynchronized: `lea esp, [ebp] '

## 0-mean

- the arithmetic mean of the elements of a vector is calculated;

- the result is displayed both as an integer and as a rational number with 5 decimal places;

## 1-max

- determine the maximum of a vector using the stack of the system to store the maximum at a certain time;

- the tip of the stack is accessed by `push` /` pop` instructions;

## 2-reverse

- inverting a string of numbers on 1 byte with the help of the stack;

- when browsing the vector, each number found is placed on the stack;

- at the end of the journey, the stack contains the numbers in the vector in reverse order;

## 3-stack-addressing

- the numbers from 1 to 5 are placed on the stack, followed by the string "Ana has apples \ 0";

- then, the contents of the stack from the base (`ebp`) to the top (` esp`) are displayed;

## 4-local-var

- the interlacing of 2 vectors (`array_1` and` array_2`);

- the resulting vector is stored on the stack, without having to be retained in the data area;

## 5-gcd

- the cmmdc of 2 numbers (49 and 28) is calculated, and the intermediate and final results are retained on the stack;

- it takes into account the need to match the stack tip with its base when exiting the program.