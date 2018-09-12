/* Edge Detection

Your Name:
Date:

This program detects edges in a 32X32 image array by comparing the
intensity of each pixel and its 4 immediate neighbors (North, South,
East, and West), computing the difference of the Max and Min intensity
values, and setting the corresponding output pixel to the computed
Max-Min difference in intensity. The program handles pixels on the
boundaries of the image specially to prevent trying to access
neighboring pixels that do not exist (i.e., no image wraparound is
allowed).

*/

#include <stdio.h>
#include <stdlib.h>

/* TEMPORARY: this is an example of a global variable.*/
int  RunningCount; 

/* TEMPORARY: this is an example function prototype.  The function is 
defined below.*/
void CountHi(int);

/* This is also a function prototype.  Do not delete this one.*/
int  Load_Mem(char *, int[]);

int main(int argc, char *argv[]) {
   int	Array[1024];
   int	Edges[1024];
   int	NumX;
   int	N;

   if (argc != 2) {
     printf("usage: ./HW2-1 valuefile\n");
     exit(1);
   }
   NumX = Load_Mem(argv[1], Array);
   if (NumX != 1024) {
     printf("valuefiles must contain 1024 entries\n");
     exit(1);
   }

   RunningCount = 0; // TEMPORARY (for example only). Remove this.

   for(N = 0; N < NumX; N++) {

     Edges[N] = Array[N]; // TEMPORARY (for example only). Replace this.
     CountHi(Array[N]);  // TEMPORARY (for example only). Remove this.
     
     /* your code goes here */

     printf("%4d: %8d\n", N, Edges[N]);
   }

   exit(0);
}

/* Temporary: this is an example function that accesses and changes a global
   variable.  It is not needed for your program and you may remove it */
void CountHi(int Pixel) {
  if (Pixel >= 200)
    RunningCount++;
  return;
}


/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
     printf("%s could not be opened; check the filename\n", InputFileName);
     return 0;
   } else {
     for (N=0; N < 1024; N++) {
       NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
       if (NumVals == 2)
	 IntArray[N] = Value;
       else
	 break;
     }
     fclose(FP);
     return N;
   }
}
