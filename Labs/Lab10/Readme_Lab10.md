
# Lab0xA - buffer management

- analyzing and exploiting security breaches of the type * buffer overflow *

- the examples are in the form of source code * Assembly *, as well as * C * or executable file

## 1-data-buffer

- a buffer of 64 elements is populated with elements such that `buffer [i] = i + 1`, after which, these values ​​are displayed.

## 2-3-4-stack buffer

- a variable declared on the stack from `0xCAFEBABE` to` 0xDEADBEEF` is modified;

- also on the stack, after this variable, a vector of `64` bytes is initialized;

- is displayed `76` bytes from the stack (** memory disclosure **), corresponding:

    - the `64` bytes of the buffer;

    - `4` bytes: modified variable;

    - `4` bytes:` saved_ebp` from `main` (being in` main`, this is `0`);

    - `4` bytes: random values ​​from the stack.

## 5-6-read-stdin

- highlighted vulnerability: function gets;

- the code * Assembly * is similar to the one from the previous exercise;

- will give the program an input of `68` bytes (from the file` payload`), making the overflow buffer which has a capacity of `64` bytes;

- thus, it is possible to modify the above variable from `0xCAFEBABE` to` 0x574F4C46` (* ASCII: * `FLOW`).

## 7-read-stdin-fgets

- highlighted vulnerability: `fgets' function, with a wrong buffer size;

- the code * Assembly * is similar to the one from the previous exercise;

- The payload is the same as in the previous exercise, but the buffer size specified for the `fgets' function is` 69` bytes, while the actual one is `64` bytes;

- thus, the same modification of the variable `0xCAFEBABE` will be made.

## 8-c-buffer-overflow

- highlighted vulnerabilities: `fgets' function, with a wrong size of the buffer + access to the code * Assembly * generated following the compilation of a program * C *;

- with a buffer of `64` bytes,` fgets` is called with the dimension of `128`;

- From the code * Assemblly * (lines `32` -` 50`) we deduce the size of the payload: `78` bytes.

## 9-overflow-in-binary

- vulnerability highlighted: buffer declared locally (on the stack), with a smaller domain than the maximum of the string that will reach it;

- using `objdump` it is reached the code * Assembly *;

- is successfully achieved through a payload that conveniently modifies `ebp - 12`.