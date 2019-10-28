# Lab 5

- operations on vectors and structures;

- emphasis on mnemonics intended for vector / string processing:
  - `rep`;
  - `low ';
  - `movs`;
  - `cmps`;
  - `cld` /` std`;
  - `lea`;
  
## 1 memset

- `memset (string, char, LENGTH)` implemented in Assembly;

- use of `rep` +` stosb`;

## 2-3-strings

- `strlen (string)`;

- the number of occurrences of `char` (in this case, 'i') in` string`;

- use `repne` +` low ';

## 4-5-print-structure

- modification of fields from a declared structure using the syntax `NASM`;

## 6-process-structure

- creating a field in a structure using parts from the other fields of this structure;

- use of `rep` +` movs`;

## 7-find-substring

- displaying all occurrences of a substring in a string;

- complexity: `O (mn) ', with m = substring length and n = string length (implementation in` O (m + n)' using KMP e [here] (https://github.com/teodutu/IOCLA /blob/master/Snippeturi/find_substring_KMP.asm) and follow the template [it] (https://github.com/teodutu/IOCLA/blob/master/Laburi/Lab2/KMP_goto/main.c));

- use `rep` +` cmps`.