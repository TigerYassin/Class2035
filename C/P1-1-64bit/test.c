
/*    This program solves a minesweeper game.

PLEASE FILL IN THESE FIELDS:
Your Name: Yassin Alsahlani
Date: 9/28/2018
 */

#include "minefield.h"
#include <stdlib.h>


//Methods
int start();
int method3(int X, int Y); //opens the selected box
int open(int X, int Y); //TODO Delete this
int method0(int X, int Y);
int method2(int X, int Y);
int count(int X, int Y);
int method1(int X, int Y);


//Datastructure(s)
int values[8][8];

//Variables
int count_unopened;     //keeps count of the number of unopened cells around the selected cell
int count_flag;         //keeps count of number of flags around selected cell



/*
 Start Method that contains the first random run
 Method3() Checks to see if the selected numbers are from box that already was open by checking if values[X][Y] != 35.
        -If the box has already been open, then it will loop back to Start

 */

void solver(int mn) {

    for (int x = 0; x < 8; x++) {
        for(int y = 0; y< 8; y++){
            values[x][y] = 35;
        }
    }
    start();

}

int start() {


    int X = rand() % 8;
    int Y = rand() % 8;
    if (values[X][Y] == 35) {
        method3(X, Y);
    } else{
        start();
    }
}


//Opens the cell at the given index and checks to see if it is a bomb, or a zero or else
int method3(int X, int Y){
    int curr = open(X,Y);   //open

    if(curr == -1){
        curr = 60;
        values[X][Y] = curr;
        method2(X, Y);  //Means that a flag is found
        return 0;
    } else if(curr == 0){
        values[X][Y] = curr;
        method0(X,Y);   //Means that a zero is found
        return 0;
    }
    values[X][Y] = curr; //Means that not bomb nor zero
    method1(X,Y);
    return 0;
}

//Run each time a new cell is open that is not a flag or zero (ONLY run when a box is opened for the first time)
//subtract current value of box with the number of flags around it
//If that number is equal to zero, then run Method0
int method1(int X, int Y){
    count(X, Y);
    int val = values[X][Y] - count_flag;
    values[X][Y] = val;
    if ((val == 0) && (count_unopened > 0)){
        method0(X, Y);  //Calling method zero to open all cells around it
    }
    start();

}


//Run this everytime a bomb is found/flagged
//Goes around the index and finds all the unopened cells (NON-bomb) and subtracts 1 from that value
int method2(int X, int Y){
    for(int x = X-1; x < X+1; x++){
        if(x < 0 || x > 7){
            continue;
        }
        for (int y = Y-1; y < Y+1; y++) {
            if (y < 0 || y > 7){
                continue;
            }
            if ((y == Y) && (x == X)){
                continue;
            }
            if (values[x][y] < 30) {
                values[x][y] = values[x][y] - 1;
                if (values[x][y] == 0) {
                    method0(x, y);
                }
            }

        }
    }

    values[X][Y] = 60; //60 represents a bomb
}

//method0 is called whenever a zero is found and we need to open all the surrounding cells
//but first check if the cell given has any surrounding cells
int method0(int X, int Y){
    count(X, Y);
    if (count_unopened > 0){
        //code to open all unopened boxes around the zero
        for (int x = X-1; x <= X+1; x++){
            if ((x < 0) || (x > 7)){
                continue;
            }
            for (int y=Y-1; y <= Y+1; y++){
                if (y < 0 || y > 7){
                    continue;
                }

                if (x == X && y == Y){
                    continue;
                }

                //check to see if current box is unopend
                if (values[x][y] == 35){
                    method3(x,y);
                }
            }
        }
    }

}

//counts the number of flags and unopend cells around the index X,Y
int count(int X, int Y){
    count_flag = 0;
    count_unopened = 0;
    for(int x = X -1; x <= X +1; x++){
        if(x < 0 || x > 7){
            continue;
        }
        for (int y = Y-1; y < Y + 1; y++) {
            if(y<0 || y > 7){
                continue;
            }

            if ((x == X) && (y == Y)){
                continue;
            }

            if (values[x][y] == 35) {  //counts unopened
                count_unopened = count_unopened + 1;
            } else if (values[x][y] == 60){ //counts the number of flags
                count_flag = count_flag + 1;
            }
        }
    }
    return 0;
}
