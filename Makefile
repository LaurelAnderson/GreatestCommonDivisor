gcd: 
       ld -m elf_i386 gcd.o -o output 

gcd.o:
        nasm -f elf32 gcd.asm -o gcd.o
        
run: 
	./output

clean:
        rm -f gcd gcd.o

