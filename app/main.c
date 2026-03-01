#include <stdio.h>
#include <factorial.h>

int main(int argc, char* argv[])
{
	uint8_t test;
	printf("Hello world\n");
	for(test = 0; test < 18; test++)
	{
		printf("factorial of %d is %ld\n",test,factorial(test));
	}
	return 0;
}
