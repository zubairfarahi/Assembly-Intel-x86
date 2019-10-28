
# Lab 8

- Syntax and use of functions in Assembly x86;



## 0-fibo

- calculate and display the first `NUM_FIBO` (in this case, 10) fibonach terms;

- for calculation, the stack of the system is used, where the calculated terms are retained;

## 1-hello-world

- example of an `puts` call, irrelevant

## 2-test

- example of the use of `objdump`, similar to those of [laboratory 6] (https://ocw.cs.pub.ro/courses/iocla/laboratoare/laborator-06);

## 3-print-string

- example of calling the `puts 'function, declared as` external';

## 4-5-reverse-string

- the length of a string is calculated, and the result is retained in `eax`;

- the function `reverse_string` is called;

- the function receives as parameters:
- the original string (`store_string`);
- the length of the string (stored in `eax`) and its address;
- the destination string (`mystring`);

## 6-toupper

- simplified implementation of the `toupper` function in` ctype.h`

- will be transformed into uppercase ** only the lowercase ** in the string received as a parameter;

## bonus-rot13

- `rot13.asm` applies [rot13] (https://en.wikipedia.org/wiki/ROT13) to a string consisting of lowercase and spaces;

- `rot13 ++. asthma applies [rot13] (https://en.wikipedia.org/wiki/ROT13) to any large number of strings made up of tiny letters and spaces, until the memory area allocated to them is exceeded