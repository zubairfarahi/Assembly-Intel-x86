## General:

- definition (the verb "a xora"): the verb "a xora", which belongs to the first group of conjugation, is introduced in Romanian;

- the property [1] will be used: `x ^ a ^ a = x`;

- For the "internal" functions of the tasks (those that are not called directly from the hand) it was generally preferred to transmit the parameters through registers, in order to use less memory on the stack and to simplify the code;

- following the tips in * The Art of Assembly Language Programming *, the code is indented with 16 spaces (2 tabs of 8),

## Task 1:

- the decryption key is after the first `\ 0` in the input, that is to say` input [strlen (input) + 1] ';

- bytes will be scanned with both the encrypted string and the key until `\ 0 'will be found and the octets in the string and the key will be xorated between them.

## Task 2:

- because the encrypted string was formed xorand one byte from the initial one with its successor, the decryption will be done in reverse: it will start from the end of the input and will xor each byte (except the first) with its predecessor.

## Task 3:

- the key will be found as in Task 1;

- one byte of the string and one of the key will be formed at the same time based on the hex numbers in the input, which will then be xora;

- `string [i ]` will be formed from` string [2 * i] `and` string [2 * i + 1] xorat with key [2 * i] `and key [2 * i + 1] `.

## Task 4:

- it processes each `8` bytes of the input, generates the corresponding values ​​according to the base encryption32, after which the` 40` of result bits are processed each `8` to create the bytes from the initial string;

- the `40` bits are kept from` MSB` to `LSB` in the pair edi: esi`.

## Task 5:

- all possible values ​​of the key byte (from `0` to` 255`) are checked in turn, and if following the input chord with this key a string containing "force" is obtained, it means that the correct key has been found ( `142`)

- if not, using `[1] ', the original input is recreated, xorando again with the current key.

## Task 6:

- the key is found as in Task 1;

- the byte byte is encrypted, both the encrypted string and the key, and is xorated to form the original string;

- when the key is finished (`` 0 '' is found, it is resumed from the beginning, being taken over by the function parameters.