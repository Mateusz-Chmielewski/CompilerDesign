/****************************************************/
/* Program ASCII - display extended ASCII codes     */
/****************************************************/
#include <stdio.h>
#include "test.h"
unsigned char uc; // char control variable of a for loop
int fromASCII = 128, toASCII = 255;
long int x[10];
void main( void )
{
  struct data {
    int	year;
    int month;
    int day;
  };
  data start, finish;
  int i;
  printf( "Extended ASCII codes\n\n");
  for ( uc = fromASCII; uc <= toASCII; uc1++ ) {
    printf( "%3d:%2c", uc, uc ); printf("\n");
  }
  int x1 = fromASCII + 2 * ( 20 +  toASCII );  /* int */
  double realTest = 12.34e-12 + .56 + 78.; /* double */
  x[0] = 1;
  for (i = 1; i < 10; i++) {
    x[i] = x[i-1] * i * i;
  }
  start.year = 2018;
  start.month = 10;
  start.day = 1;
}