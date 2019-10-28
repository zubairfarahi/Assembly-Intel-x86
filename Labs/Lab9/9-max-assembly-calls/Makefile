# IOCLA 2016
# USO remembers

CC=gcc
ASM=nasm
ASMFLAGS=-f elf64

mainmax: max.o main.o
	$(CC) -o $@ $^ -no-pie
main.o: main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

max.o: max.c
	$(CC) -c $^

clean:
	rm -f *.o mainmax
