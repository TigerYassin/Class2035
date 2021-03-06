/* Edge Detection

Your Name: Yassin Alsahlani 
Date: September 14, 2018

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


/* This is also a function prototype.  Do not delete this one.*/
int  Load_Mem(char *, int[]);

//The functions that I will be using
int getEdge(int myArr[5]);
int getEdgeThree(int SumArr[4]);
int getEdgeTwo(int SumArr[3]);

int main(int argc, char *argv[]) {
    int Array[1024];
    int Edges[1024];
    int NumX;
    int N;

    if (argc != 2) {
        printf("usage: ./HW2-1 valuefile\n");
        exit(1);
    }
    NumX = Load_Mem(argv[1], Array);
    if (NumX != 1024) {
        printf("valuefiles must contain 1024 entries\n");
        exit(1);
    }


    int north = 0;
    int south = 0;
    int east = 0;
    int west = 0;

    int temp1 = 0;
    int temp2 = 0;


    for (N = 0; N < NumX; N++) {

        /* your code goes here */

        /* TODO:
             1. Pull in the array
            2. The 2d array is given as a 1D so we must get the edges
            3. Check if cell is an edge cell
                -Left edge: N % 32 ==0
                -Right edge: N % 32 == 31
                -Top Edge: N < 32
                -Bottom Edge: N > 992
            4. Checks to see if its an edge then store the variables
                - Max Val
                - Min Val
            5. If current index is edge then the appropriate side would not be used
            6. Apply Algorithm
                - newVal = Max - Min
            7. Set newVal to current index
        */


        //Check for special condition
        if (N == 0 || N == 31 || N == 992 || N == 1023) {

            if (N == 0) { //does logic for first special case
		int smallArr[] = {Array[1], Array[32], Array[N]};
                Edges[N] = getEdgeTwo(smallArr);
            }

            if (N == 31) {//does logic for second special case
		int smallArr[] = {Array[30], Array[63], Array[N]};
                Edges[N] = getEdgeTwo(smallArr);
            }

            if (N == 992) {//does logic for third special case
		int smallArr[] = {Array[993], Array[960], Array[N]};
                Edges[N] = getEdgeTwo(smallArr);
            }

            if (N == 1023) {//does logic for last special case
		int smallArr[] = {Array[1022], Array[991], Array[N]};
                Edges[N] = getEdgeTwo(smallArr);
            }

	//If it is not a special case, then excute: 
        } else {


            //Check Top Edge
            if (N < 32) {
                int smallArr[] = {Array[N-1], Array[N+1], Array[N+32], Array[N]};
                Edges[N] = getEdgeThree(smallArr);
            }


                //Check Bottom Edge
            else if (N > 992) {
                int smallArr[] = {Array[N-1], Array[N+1], Array[N-32], Array[N]};
                Edges[N] = getEdgeThree(smallArr);
            }


            //Check for left edge
            else if (N % 32 == 0) {
               int smallArr[] = {Array[N+1], Array[N-32], Array[N+32], Array[N]};
                Edges[N] = getEdgeThree(smallArr);
            }


                //Check Right Edge
            else if (N % 32 == 31) {
                int smallArr[] = {Array[N-1], Array[N-32], Array[N+32], Array[N]};
                Edges[N] = getEdgeThree(smallArr);
            }



            else{//Execute else if it is not a special edge nor a regular edge
                int bigArr[] = {Array[N+1], Array[N-1], Array[N-32], Array[N+32], Array[N]};
                Edges[N] = getEdge(bigArr);
            }
        }

        printf("%4d: %8d\n", N, Edges[N]);
    }

    exit(0);
}


//returns (Max-Min) for regular index
int getEdge(int myArr[5]) {
    int max = -100;
    int min = 500;

    for (int x = 0; x < 5; x++) {
	//if the current value is larger than the max then set the max to the current value 
        if (myArr[x] >= max) {
            max = myArr[x];
        }

	//if the current value is less than the min then set the min to the current value 
        if (myArr[x] <= min) {
            min = myArr[x];
        }
    }
    return (max- min);
}



//returns (Max-Min) for 4 point edge
int getEdgeThree(int SumArr[4]) {
    int max = -100;
    int min = 500;

    for (int x = 0; x < 4; x++) {
	//if the current value is larger than the max then set the max to the current value 
        if (SumArr[x] >= max) {
            max = SumArr[x];
        }

	//if the current value is less than the min then set the min to the current value 
        if (SumArr[x] <= min) {
            min = SumArr[x];
        }
    }
    return (max - min);
}



//returns (Max-Min) for 3 point edge
int getEdgeTwo(int SumArr[3]) {
    int max = -100;
    int min = 500;

    for (int x = 0; x < 3; x++) {
	//if the current value is larger than the max then set the max to the current value 
        if (SumArr[x] >= max) {
            max = SumArr[x];
        }

	//if the current value is less than the min then set the min to the current value 
        if (SumArr[x] <= min) {
            min = SumArr[x];
        }
    }
    return (max - min);
}




/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
    int N, Addr, Value, NumVals;
    FILE *FP;

    FP = fopen(InputFileName, "r");
    if (FP == NULL) {
        printf("%s could not be opened; check the filename\n", InputFileName);
        return 0;
    } else {
        for (N = 0; N < 1024; N++) {
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

