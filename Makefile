.PHONY: clean
CFLAGS= -ansi -pedantic -O0 -Wall

all: CRC CRCa1 CRCa2

CRC: main.o crc.o
	gcc -g -o CRC $(CFLAGS) main.o crc.o

CRCa1: main.o crca1.o
	gcc -g -o CRCa1 $(CFLAGS) main.o crca1.o
	
CRCa2: main.o crca2.o
	gcc -g -o CRCa2 $(CFLAGS) main.o crca2.o

main.o: main.c
	gcc -c -g -o main.o $(CFLAGS) main.c

crc.o: crc.c
	gcc -c -g -o crc.o $(CFLAGS) crc.c

crca1.o: crca1.S
	as --64 -o crca1.o crca1.S

crca2.o: crca2.S
	as --64 -o crca2.o crca2.S

clean:
	rm -f *.o CRC CRCa1 CRCa2
