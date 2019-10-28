# expression evaluation in postfixed Polish form

# Algoritm:

- the string containing the expression is read from `stdin`, and its address is stored in` ecx`;

- browse the character string with character and perform the operations found or dial numbers, through the function `make_number`;


- it does not receive parameters, operating with the same register `ecx` as the main and returns the number created without a sign in` eax`;

- no additional variables are required, except for the input string and stack, all operations being performed with the registers.

# Implementation:

- to hold the numbers read and the results of the calculations the system stack was used;

- to reduce the number of instructions and the memory used, so for efficiency reasons, the last number obtained will be retained either from calculations or by leaving the input (because this number is the most used), in ax and only the rest of the results on the stack;

- directly retaining the byte addresses of the input, ecx will increase until the value from its address will be `0`, corresponding to the string terminator` \ 0`.
