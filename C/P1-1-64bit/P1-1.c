
/*    This program solves a minesweeper game.

PLEASE FILL IN THESE FIELDS:
Your Name: Yassin Alsahlani
Date: 9/28/2018
 */

#include "minefield.h"
#include <stdlib.h>

void solver(int mn) {



/*
STEPS:
	1. Create a 2D array and the value of each cell should be the prob of it being a bomb
	2. Open random box and if it is zero, then open all boxes around it. If any box around it is zero, then do the same for that box too


*/

start();


}

//Give it a starting point 

int start(){

//Searching for box with least prob of being a bomb
int prob[8][8];
char list[8][8];
int values[8][8];

	for(int x = 0; x < 8; x++){
	for int y = 0; y < 8; y++){
		prob[x][y] = 20;				//DEPENDS ON THE NUMBER OF BOMBS
		list[x][y] = '-';
		values[x][y] = 35; 			//Start off at 35 means that it is unopened, after opening, it will contain the value of the number of bombs around it, then it will change 
								//everytime a bomb is found 
	}
}

int minProb = 1000;
int indexMinX;
int indexMinY;
for(int x = 0; x < 8; x++){
	for(int y =0; y<8; y++){
		if(prob[x][y] < minProb){
		minProb = prob[x][y];
		indexMinX = x;
		indexMinY = y;		
		}

	}
}

//Open first box with least prob of being a bomb and adds value to 2d array
int X = indexMinX;
int Y = indexMinY;
int currentBox = open(X,Y); 
if(currentBox < 0){
mineFlagged(X,Y);

}else{
values[X][Y] = currentBox;
list[X][Y] = 'O';
}



//Update the prob of the boxes around it according to the current box 

//But first checks to see if current index is edge 
int EdgeStatus = checkEdge(X,Y); // 1 if Edge, 0 otherwise
if(EdgeStatus == 0){
	nonEdgeProbUpdate(X,Y, currentBox);
	}
	else{
	edgeProbUpdate(X,Y, currentBox);
	}

}//Closes the Method 


//Gets the value of the current box, finds the number of open boxes around it adds the prob value to the current prob value 
int nonEdgeProbUpdate(X,Y, currentBoxValue){
	//Find all the boxes that are unopen around it 
	int countUnopened = 0;
	int countFlagged = 0;


	//Check if opened from the list array :  open if char == O ; closed if char == - ; flagged if char == F 
	if(list[X-1][Y-1] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X-1][Y] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X-1][Y+1] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X][Y-1] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X][Y+1] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X+1][Y-1] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X+1][Y] == '-'){
	countUnopened = countUnopened + 1;
	}

	if(list[X+1][Y+1] == '-'){
	countUnopened = countUnopened + 1;
	}



	//count the number of bombs around the cell
	if(list[X-1][Y-1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X-1][Y] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X-1][Y+1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X][Y-1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X][Y+1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X+1][Y-1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X+1][Y] == 'F'){
	countFlagged = countFlagged + 1;
	}

	if(list[X+1][Y+1] == 'F'){
	countFlagged = countFlagged + 1;
	}

	
	//Does math for probability of surrounding cells to have a bomb	
	int bombsLeft = currentBoxValue	- countFlagged;
	if(bombsLeft > 0){						//Make sure we dont divide by 0
	int boxProb = (countUnopened / bombsLeft) * 100; 
	}
	else {
	int boxProb = 0; //if this is the case, then all surrounding boxes must but opened and value stored in our list array 
	}




}

int addProb(X, Y, boxProb){ //adds the probability of surronding boxes of being a bomb 
	
	if(list[X-1][Y-1] == '-'){
	prob[X-1][Y-1] = prob[X-1][Y-1] + boxProb; 
	if(boxProb == 100){
		list[X-1][Y-1] = 'F';
		mineFLagged(X-1, Y-1);
	}
	}

	if(list[X-1][Y] == '-'){
	prob[X-1][Y] = prob[X-1][Y] + boxProb; 
	if(boxProb == 100){
		list[X-1][Y] = 'F';
		mineFLagged(X-1, Y);
	}

	}

	if(list[X-1][Y+1] == '-'){
	prob[X-1][Y+1] = prob[X-1][Y+1] + boxProb; 
	if(boxProb == 100){
		list[X-1][Y+1] = 'F';
		mineFLagged(X-1, Y+1);
	}

	}

	if(list[X][Y-1] == '-'){
	prob[X][Y-1] = prob[X][Y-1] + boxProb;
	if(boxProb == 100){
		list[X][Y-1] = 'F';
		mineFLagged(X, Y-1);
	} 
	}

	if(list[X][Y+1] == '-'){
	prob[X][Y+1] = prob[X][Y+1] + boxProb; 
	if(boxProb == 100){
		list[X][Y+1] = 'F';
		mineFLagged(X, Y+1);
	}
	}

	if(list[X+1][Y-1] == '-'){
	prob[X+1][Y-1] = prob[X+1][Y-1] + boxProb; 
	if(boxProb == 100){
		list[X+1][Y-1] = 'F';
		mineFLagged(X+1, Y-1);
	}
	}

	if(list[X+1][Y] == '-'){
	prob[X+1][Y] = prob[X+1][Y] + boxProb; 
	if(boxProb == 100){
		list[X+1][Y] = 'F';
		mineFLagged(X+1, Y);
	}
	}

	if(list[X+1][Y+1] == '-'){
	prob[X+1][Y+1] = prob[X+1][Y+1] + boxProb; 
	if(boxProb == 100){
		list[X+1][Y+1] = 'F';
		mineFLagged(X+1, Y+1); //IF a bomb is found, then subtract 1 from all adjacent boxes and search for any zeros with unopened adjacent boxes 
	}
	}

}

int opened(X, Y){
	if(values < 35){
	return 0;
	}
	return 36;
}


int mineFlagged(X,Y){
	if(opened(X-1, Y-1) < 35){
	values[X-1][Y-1] = values[X-1][Y-1] -1;
	EdgeStatus([X-1][Y-1]);
}

	
	if(opened(X-1, Y) < 35){
	values[X-1][Y] = values[X-1][Y] -1;
	EdgeStatus([X-1][Y]);
}


	if(opened(X-1, Y+1) < 35){
	values[X-1][Y+1] = values[X-1][Y+1] -1;
	EdgeStatus([X-1][Y+1]);
}


	if(opened(X, Y-1) < 35){
	values[X][Y-1] = values[X][Y-1] -1;
	EdgeStatus([X][Y-1]);
}


	if(opened(X, Y+1) < 35){
	values[X][Y+1] = values[X][Y+1] -1;
	EdgeStatus([X][Y+1]);
}

	if(opened(X+1, Y-1) < 35){
	values[X+1][Y-1] = values[X+1][Y-1] -1;
	EdgeStatus([X+1][Y-1]);
}

	if(opened(X+1, Y) < 35){
	values[X+1][Y] = values[X+1][Y] -1;
	EdgeStatus([X+1][Y]);
}

	if(opened(X+1, Y+1) < 35){
	values[X+1][Y+1] = values[X+1][Y+1] -1;
	EdgeStatus([X+1][Y+1]);
}

	
}


int checkEdge(X, Y){ //returns 1 if Edge given
	if(X == 0 || X == 7 || Y == 0 || Y == 7){
	return 1;
	}
	return 0;
}
