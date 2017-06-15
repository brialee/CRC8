Cyclic Redundancy Check (CRC) program.

This program was made for CS201 at PSU for Spring 2017 term.
The purpose of the program was to demonstrate use of assembly
langauge operations, branches, and logic. Program follows the
System V x86 calling convention. 

Abstract:
The assignment was to impliment a CRC algorithm in x86-64 assembly, in this
case CRC-8, which outputs a 8-bit signature while using the polynomial
0xD5 (CRC-8 DVB-S2).

Using the Program:
Run the 'make' command, this will generate three versions of the program.
The first version (CRC) has no optimization. CRCa1 replaces the crc.c file
with an assembly langauge file. while CRCa2 makes use of a conditional move
in the assembly file to showcase the gain in speed when not using a branch
statement for the portion of the code that is most intensive. All three
versions display the total amount in time it took to run 1 million times. 
To use, after running make, provide the version you want to use with a message as
an argument. When finished, run 'make clean' to remove the object file and
the executables. 
