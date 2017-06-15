#include <stdio.h>


char crcTable[256] = {0};

void crcInit(void)
{

	char remainder, bit;
	int dividend = 0;

	for(; dividend < 256; ++dividend)
	{
		remainder = dividend;
		for(bit = 0; bit < 8; ++bit)
		{
			if(remainder & 0x80)
				remainder = (remainder << 1) ^ 0xD5;

			else
				remainder = (remainder << 1);	
		}

		crcTable[dividend] = remainder;
	}
}



char crcFast(char *message, long numBytes)
{
	unsigned char x;
	char remainder = 0;
	long byte = 0;


	for(; byte < numBytes; ++byte)
	{
		x = message[byte] ^ remainder;
		remainder = crcTable[x];	
	}
	
	return remainder;
}
