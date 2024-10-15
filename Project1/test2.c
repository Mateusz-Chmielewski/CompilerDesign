/****************************************************/
/* Program ASCII - displays extended ASCII codes    */
/****************************************************/
#include <stdio.h>
#include "test.h"
unsigned char uc; // control variable of a for loop
int fromASCII = 128, toASCII = 255; 
void main( void )
{ 
	printf("\n\n\Extended ASCII codes\n\n");
	for (uc = fromASCII; uc <= toASCII; uc1++)
	{
		printf("%3d:%2c", uc, uc);
	}
}
int x1 = fromASCII + 2 * ( 20 +  toASCII ); /* these lines /* are
* / for test purposes only ;-) */
double realTest = 12.34 + .56 + 78.;
*/ // unopened comment
"unfinished string constant
/* unfinished comment