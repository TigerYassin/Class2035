#include "graphics.h"
#include "globals.h"
#define YELLOW 0xFFFF00
#define BROWN  0xD2691E
#define DIRT   BROWN
#define BLUE2   0x3c5aa6
#define RED    0xFF0000
#define ORANGE 0xFFA500         
#define GREEN2  0x00FA9A
#define MEWTWO 0x493c4b
#define WHITE2  0xffffff
#define SKIN   0xDCB847
#define BROWN2  0x4c3b2b

void draw_img(int u, int v, const char* img)
{
    int colors[11*11];
    for (int i = 0; i < 11*11; i++)
    {
        if (img[i] == 'R') colors[i] = RED;
        else if (img[i] == 'Y') colors[i] = YELLOW;
        else if (img[i] == '2') colors[i] = BROWN2;
        else if (img[i] == 'G') colors[i] = GREEN;
        else if (img[i] == 'D') colors[i] = DIRT;
        else if (img[i] == '5') colors[i] = BLUE2;
        else if (img[i] == '6') colors[i] = DGREY;
        else if (img[i] == 'N') colors[i] = DGREY;
        else if (img[i] == 'R') colors[i] = RED;
        else if (img[i] == 'B') colors[i] = GREEN2;
        else if (img[i] == 'W') colors[i] = WHITE2;
        else if (img[i] == 'M') colors[i] = MEWTWO;
        else if (img[i] == 'S') colors[i] = SKIN;
        else colors[i] = GREEN2;
    }
    uLCD.BLIT(u, v, 11, 11, colors);
    wait_us(250); // Recovery time!
}

const char pickachu[121] = {
    'B','Y','B','B','B','B','B','B','B','Y','B',
    'B','Y','B','Y','Y','Y','Y','Y','B','Y','B',    
    'B','Y','Y','N','Y','Y','Y','N','Y','Y','B',
    'Y','Y','Y','N','Y','Y','Y','N','Y','Y','Y',
    'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y',
    'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y',
    'Y','Y','R','R','Y','Y','Y','R','R','Y','Y',
    'Y','Y','R','R','Y','Y','Y','R','R','Y','Y',
    'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y',
    'B','Y','Y','Y','Y','Y','Y','Y','Y','Y','B',
    'B','Y','Y','Y','Y','Y','Y','Y','Y','Y','B',
    };
const char boulder[121] = {
'B','B','B','B','2','2','2','B','B','B','B',
'B','B','B','2','2','2','2','2','B','B','B',
'B','B','2','2','2','2','2','2','2','B','B',
'B','2','2','2','2','2','2','2','2','2','B',
'2','2','2','2','2','2','2','2','2','2','2',
'2','2','2','2','2','2','2','2','2','2','2',
'2','2','2','2','2','2','2','2','2','2','2',
'2','2','2','2','2','2','2','2','2','2','2',
'B','2','2','2','2','2','2','2','2','2','B',
'B','B','2','2','2','2','2','2','2','B','B',
'B','B','B','2','2','2','2','2','B','B','B',
    };


const char Q1[121] = {
'6','6','B','B','B','B','B','B','B','B','B',
'6','6','6','B','B','B','B','B','B','B','B',
'6','6','6','6','B','B','B','B','B','B','B',
'6','6','6','6','6','B','B','B','B','B','B',
'6','6','6','6','6','B','B','B','B','B','B',
'6','6','6','6','6','6','B','B','B','B','B',
'6','6','6','6','6','6','B','B','B','B','B',
'6','W','W','6','6','6','6','B','B','B','B',
'6','W','W','6','6','6','6','6','B','B','B',
'6','6','6','6','6','6','6','B','B','B','B',
'6','6','6','6','6','6','B','B','B','B','B',
    };   
    
const char Q2[121] = {
'B','B','B','B','B','B','B','B','B','6','6',
'B','B','B','B','B','B','B','B','6','6','6',
'B','B','B','B','B','B','B','6','6','6','6',
'B','B','B','B','B','B','6','6','6','6','6',
'B','B','B','B','B','B','6','6','6','6','6',
'B','B','B','B','B','6','6','6','6','6','6',
'B','B','B','B','B','6','6','6','6','6','6',
'B','B','B','B','6','6','6','6','W','W','6',
'B','B','B','6','6','6','6','6','W','W','6',
'B','B','B','B','6','6','6','6','6','6','6',
'B','B','B','B','B','6','6','6','6','6','6',
    };
    
    

const char Q4[121] = {
    '6','6','6','6','6','6','B','B','B','B','B',
'6','6','6','6','6','6','6','B','B','B','B',
'6','6','6','6','6','6','6','B','B','B','B',
'6','6','6','6','6','6','6','B','B','B','B',
'6','6','6','6','6','6','B','B','B','B','B',
'6','6','6','6','6','6','B','B','B','B','B',
'6','6','6','6','B','B','B','B','B','B','B',
'6','B','6','6','B','B','B','B','B','B','B',
'B','B','6','6','6','B','B','B','B','B','B',
'B','B','6','6','6','B','B','B','B','B','B',
'B','6','6','6','6','6','B','B','B','B','B',
    
    };

const char Q3[121] = {
'B','B','B','B','B','6','6','6','6','6','6',
'B','B','B','B','6','6','6','6','6','6','6',
'B','B','B','B','6','6','6','6','6','6','6',
'B','B','B','B','6','6','6','6','6','6','6',
'B','B','B','B','B','6','6','6','6','6','6',
'B','B','B','B','B','6','6','6','6','6','6',
'B','B','B','B','B','B','B','6','6','6','6',
'B','B','B','B','B','B','B','6','6','B','6',
'B','B','B','B','B','B','6','6','6','B','B',
'B','B','B','B','B','B','6','6','6','B','B',
'B','B','B','B','B','6','6','6','6','6','B',    
    
    };
    

const char meoth[121] = {
 'B','N','B','B','B','B','B','B','B','N','B',
'B','N','B','N','N','N','N','N','B','N','B',    
'B','N','N','5','N','N','N','5','N','N','B',
'N','N','N','5','N','N','N','5','N','N','N',
'N','N','N','N','N','N','N','N','N','N','N',
'N','N','N','N','N','N','N','N','N','N','N',
'N','N','R','R','N','N','N','R','R','N','N',
'N','N','R','R','N','N','N','R','R','N','N',
'N','N','N','N','N','N','N','N','N','N','N',
'B','N','N','N','N','N','N','N','N','N','B',
'B','N','N','N','N','N','N','N','N','N','B',
    };

const char jessie[121] = {
    'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','R','R','B','D','B','B','B','B',
'B','B','B','B','R','D','B','B','B','B','B',
'B','B','R','R','R','R','R','R','R','B','B',
'B','R','R','R','R','R','R','R','R','R','B',
'B','R','R','N','N','R','N','N','R','R','B',
'B','R','R','R','R','R','R','R','R','R','B',
'B','R','R','R','R','R','R','R','R','R','B',
'B','B','R','W','W','W','W','W','R','B','B',
'B','B','R','R','R','R','R','R','R','B','B',
    
    };
    
const char pokeball[121] = {
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','G','R','R','R','B','B','B','B',
    'B','B','B','R','R','R','R','R','B','B','B',
    'B','B','R','R','R','R','R','R','R','B','B',
    'B','B','5','5','W','W','W','5','5','B','B',
    'B','B','W','W','W','W','W','W','W','B','B',
    'B','B','5','5','W','W','W','5','5','B','B',
    'B','B','R','R','R','R','R','R','R','B','B',
    'B','B','R','R','R','R','R','R','R','B','B',
    'B','B','B','R','R','R','R','R','B','B','B',
    };

const char blank[121] = {
    'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B',
};
    
const char james[121] = {
    'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','5','5','B','D','B','B','B','B',
'B','B','B','B','5','D','B','B','B','B','B',
'B','B','5','5','5','5','5','5','5','B','B',
'B','5','5','5','5','5','5','5','5','5','B',
'B','5','5','N','N','5','N','N','5','5','B',
'B','5','5','5','5','5','5','5','5','5','B',
'B','5','5','5','5','5','5','5','5','5','B',
'B','B','5','W','W','W','W','W','5','B','B',
'B','B','5','5','5','5','5','5','5','B','B',
    
};

const char mewtwo[121] = {
'B','B','B','B','S','S','S','S','B','B','B',
'B','B','B','S','S','S','S','S','S','B','B',
'B','B','M','M','M','M','M','M','S','B','B',
'B','B','M','S','M','M','S','M','W','B','B',
'B','B','M','S','M','M','S','M','B','B','B',
'B','B','M','M','M','M','M','M','S','B','B',
'B','M','M','M','M','M','M','M','M','B','B',
'B','M','S','M','M','M','M','S','M','B','B',
'B','M','S','M','M','M','M','S','M','B','B',
'B','B','M','M','M','M','M','M','B','B','B',
'B','B','M','S','B','S','B','M','B','B','B',
};
const char pokeballcursed[121] = {
 'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','G','N','N','N','B','B','B','B',
'B','B','B','N','N','N','N','N','B','B','B',
'B','B','N','N','N','N','N','N','N','B','B',
'B','B','5','5','M','M','M','5','5','B','B',
'B','B','M','M','M','M','M','M','M','B','B',
'B','B','5','5','M','M','M','5','5','B','B',
'B','B','N','N','N','N','N','N','N','B','B',
'B','B','N','N','N','N','N','N','N','B','B',
'B','B','B','N','N','N','N','N','B','B','B',
    };
    
const char professor[121] = {
'B','B','B','W','W','W','W','W','B','B','B',
'B','B','B','W','W','W','W','W','B','B','B',
'B','B','B','W','G','W','G','W','B','B','W',
'W','B','B','W','G','W','G','W','W','W','W',
'W','W','W','W','W','W','W','W','W','W','W',
'B','W','W','W','W','W','W','W','B','B','B',
'B','B','B','W','W','W','W','W','B','B','B',
'B','B','B','W','W','B','W','W','B','B','B',
'B','B','B','W','W','B','W','W','B','B','B',
'B','B','B','B','B','B','B','B','B','B','B'
   
    };


const char updatedprof[121] = {
'B','B','B','B','B','B','B','B','6','6','B',
'B','B','B','B','B','B','B','B','6','6','B',
'B','B','B','B','B','B','B','6','6','6','6',
'B','B','B','B','B','B','B','6','6','6','6',
'B','B','B','B','B','B','B','6','6','6','6',
'B','B','B','B','B','B','B','B','6','6','6',
'B','B','B','B','B','B','B','B','6','6','B',
'B','B','B','B','B','B','B','B','B','6','B',
'B','B','B','B','B','B','B','B','B','B','B',
'B','B','B','B','B','B','B','B','B','6','B',
'B','B','B','B','B','B','B','B','6','6','6',
    };
    
const char key [121] = {
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','Y','Y','Y','Y','Y','B',
    'B','Y','Y','Y','Y','Y','Y','W','W','Y','B',
    'B','Y','Y','Y','Y','Y','Y','W','W','Y','B',
    'B','Y','B','Y','B','B','Y','Y','Y','Y','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    'B','B','B','B','B','B','B','B','B','B','B',
    };
const char door [121] = {
 'D','D','D','D','D','D','D','D','D','D','D',
 'D','D','D','D','D','D','D','D','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','B','N','D','D','D',
 'D','D','D','D','N','N','B','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',
 'D','D','D','D','N','N','N','N','D','D','D',

    };

const char plant [121] = {
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
'G','G','G','G','G','G','G','G','G','G','G',
    };

void draw_player(int u, int v, int key)
{
   draw_img(u, v, pickachu);
}

void draw_nothing(int u, int v)
{
    // Fill a tile with blackness
    uLCD.filled_rectangle(u, v, u+10, v+10, GREEN2);
}

void draw_wall(int u, int v)
{
    uLCD.filled_rectangle(u, v, u+10, v+10, DIRT);
}    

void draw_plant(int u, int v)
{
    draw_img(u, v, plant);
}

void draw_upper_status()
{
    // Draw bottom border of status bar
//    uLCD.line(0, 9, 127, 9, GREEN);
    
}

void draw_lower_status()
{
    // Draw top border of status bar
    uLCD.line(0, 118, 127, 118, LGREY);
    uLCD.line(0, 117, 127, 117, LGREY);
    uLCD.line(0, 116, 127, 116, LGREY);
    
    // Add other status info drawing code here
}

void draw_border()
{
    uLCD.filled_rectangle(0,     9, 127,  14, WHITE); // Top
    uLCD.filled_rectangle(0,    13,   2, 114, WHITE); // Left
    uLCD.filled_rectangle(0,   114, 127, 117, WHITE); // Bottom
    uLCD.filled_rectangle(124,  14, 127, 117, WHITE); // Right
}

void draw_startScreen()
{   
    uLCD.text_bold(ON);
    uLCD.text_string("Finding ASH!!!", 2, 1, FONT_7X8, WHITE);
    uLCD.text_string("WE NEED YOUR HELP!", 0, 4,FONT_7X8, WHITE);
    uLCD.text_string("Pickachu is lost", 1, 6,FONT_7X8, WHITE);
    uLCD.text_string("and needs help", 1, 7,FONT_7X8, WHITE);
    uLCD.text_string("to find Ash", 1, 8,FONT_7X8, WHITE);
    uLCD.text_string("-----------------",1,11,FONT_7X8, WHITE);
    uLCD.text_string("-----------------",1,13,FONT_7X8, WHITE);
    uLCD.text_string("Select Difficulty", 1, 12, FONT_7X8, WHITE);
    uLCD.text_string("Yassin Alsahlani",1,14, FONT_7X8, GREEN2);
}


void draw_gameend()
{   
    uLCD.filled_rectangle(0,0, 127,  127, BLACK);
    uLCD.text_bold(ON);
    uLCD.text_string("You DIED!", 5, 5, FONT_7X8, WHITE);
}

void draw_boulder(int u, int v){
    draw_img(u,v,boulder);
    
    };

void draw_gameendWin()
{
    uLCD.filled_rectangle(0,0, 127,  127, BLACK); 
    uLCD.text_bold(ON);
    uLCD.text_string("Nice Job!", 5, 5, FONT_7X8, WHITE);
    
}

void draw_TEAMROCKET(int u, int v){
    draw_img(u, v, meoth);
 }  
 
void draw_TEAMROCKET2(int u, int v){
    draw_img(u, v, jessie);
    } 
    
void draw_TEAMROCKET3(int u, int v){
    draw_img(u, v, james);
    }
    
void draw_TEAMROCKET4(int u, int v){
    draw_img(u, v, mewtwo);
}
void draw_NPC(int u, int v)
{
    draw_img(u, v, professor);
}

void draw_updateNPC(int u, int v){
    draw_img(u, v, updatedprof);
    }
void draw_pokeball(int u, int v)
{
    draw_img(u,v,pokeball);
}

void draw_blank(int u, int v){
    draw_img(u, v, blank);
    
    }
void draw_q1(int u, int v){
    draw_img(u,v, Q1);
    }

void draw_q2(int u, int v){
    draw_img(u,v, Q2);
    }

void draw_q3(int u, int v){
    draw_img(u,v, Q3);
    }

void draw_q4(int u, int v){
    draw_img(u,v, Q4);
    }
    
void draw_pokeballcursed(int u, int v)
{
    draw_img(u,v,pokeballcursed);
}
void draw_door(int u, int v)
{
    draw_img(u,v,door);
}
void draw_key(int u, int v)
{
    draw_img(u, v, key);    
}


