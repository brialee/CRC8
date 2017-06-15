#include <stdio.h>
#include <string.h>
#include <sys/time.h>

void crcInit(void);
char crcFast(char *message, long nBytes);
extern char crcTable[256]; /* Defined here for lines 37-41 to work */
long TRIALS = 1000000;

int main(int argc, char *argv[])
{
	unsigned char checkSum = 0;
	long i = 0;
	long j = 0; /*counter for table display loop*/
	struct timeval timeEnd, timeStart;
	unsigned long Mseconds = 0;

	if(argc != 2)
	{
		printf("Usage:\n ./crc \"message\"\n\n");
		return 99;
	}

	/* get start time */
	gettimeofday(&timeStart, NULL);

	/* Initialize crcTable and get check sum */
	printf("\nCalculating.....\n");
	for(; i < TRIALS; i++)
	{
		crcInit();

		/* To see the values for the crcTable, uncomment
		   the below code....*/

		for(; j < 256; j++)
			printf("%d ", crcTable[j]);

		checkSum = crcFast(argv[1], strlen(argv[1]));
	}

	/* get time after computation */
	gettimeofday(&timeEnd, NULL);
	

	/* Subtract time after computation from time before computation */
	Mseconds = (timeEnd.tv_sec*1000 + timeEnd.tv_usec/1000) - (timeStart.tv_sec*1000 + timeStart.tv_usec/1000);
	
	printf("\nCheck Sum: %X\n", checkSum);
	printf("Iterations: %lu\n", TRIALS);
	printf("Total Time: %lu seconds -- %lu miliseconds\n\n", Mseconds/1000, Mseconds);



	return 0;
}
