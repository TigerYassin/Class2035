// Project includes
#include "globals.h"
#include "hardware.h"
#include "map.h"
#include "graphics.h"
#include "speech.h"
#include "Speaker.h"
#include "SongPlayer.h"

// Functions in this file
int get_action (GameInputs inputs);
int user_Input(GameInputs inputs);
int update_game (int action);
void draw_game (int init);
void draw_startScreen();
void init_main_map ();
int main ();
int buttonPressed1 = 0;
int buttonPressed2 = 0;
int buttonPressed3 = 0;
int pokeballCount = 0;
int pokeballCursedCount = 0;
int xval = 48;
int yval = 1; 
int boulderX = 34;
int v1 = 0;
int v2 = 0;

/**
 * The main game state. Must include Player locations and previous locations for
 * drawing to work properly. Other items can be added as needed.
 */
struct {
    int x,y;    // Current locations
    int px, py; // Previous locations
    int has_key;
    int health;
    int omni;
    int pokeballs;
    int end;
} Player;

/**
 * Given the game inputs, determine what kind of update needs to happen.
 * Possbile return values are defined below.
 */
#define NO_ACTION 0
#define ACTION_BUTTON 1
#define MENU_BUTTON 2
#define GO_LEFT 3
#define GO_RIGHT 4
#define GO_UP 5
#define GO_DOWN 6
#define TALK 7
#define DOORFOUND 8
#define TELEPORT 9
#define DOORFOUND2 10
#define PUSHBOULDER 11 


int get_action(GameInputs inputs)
{
    MapItem* itemNorth = get_north(Player.x,Player.y);
    MapItem* itemSouth = get_south(Player.x,Player.y);
    MapItem* itemEast = get_east(Player.x,Player.y);
    MapItem* itemWest = get_west(Player.x,Player.y);
    MapItem* itemHere = get_here(Player.x,Player.y);



  

/*
Create a boulder that can only be moved by pushing it 
*/
    if((itemEast->type == NPC || itemWest->type == NPC || itemNorth->type == NPC || itemSouth->type == NPC) && inputs.b2 == 0)
    {  return TALK;  }

    
    if((itemEast->type == BOULDER || itemNorth->type == BOULDER || itemSouth->type == BOULDER) && inputs.b2 == 0)
    {return PUSHBOULDER;  }

    
    if((itemEast->type == DOOR || itemWest->type == DOOR || itemNorth->type == DOOR || itemSouth->type == DOOR) && inputs.b2 == 0)
    {return DOORFOUND;  }

    if((itemEast->type == DOOR2 || itemWest->type == DOOR2 || itemNorth->type == DOOR2 || itemSouth->type == DOOR2) && inputs.b2 == 0)
    {return DOORFOUND2;  }


    if((itemEast->type == TR || itemWest->type == TR || itemNorth->type == TR || itemSouth->type == TR))
    {return TELEPORT;  }

    else if((inputs.ay <= -0.2) && (itemNorth->walkable || Player.omni == 1))
    { return GO_UP;  }

    else if((inputs.ay >= 0.2) && (itemSouth->walkable || Player.omni == 1))
    {  return GO_DOWN;}

    else if((inputs.ax <= -0.2) && (itemWest->walkable || Player.omni == 1))
    {
        return GO_LEFT;
    }
    else if((inputs.ax >= 0.2) && (itemEast->walkable || Player.omni == 1))
    {
        return GO_RIGHT;
    }
    else
        return NO_ACTION;
}

int user_Input(GameInputs inputs)
{

    Speaker mySpeaker(p26);
    if (pokeballCount == 0) {
      if(inputs.b1 == 0){
        pc.printf("The first button has been triggered\n" );
        mySpeaker.PlayNote(969.0,0.1,0.2);
        pokeballCount = 8;
        pokeballCursedCount = 5;
      }
      else if(inputs.b2 == 0){
        mySpeaker.PlayNote(1000.0, 0.1, 0.2);
        pc.printf("Second button\n" );
        pokeballCount = 6;
        pokeballCursedCount = 12;
      }
      else if(inputs.b3 == 0){
        mySpeaker.PlayNote(1100.0, 0.1, 0.2);
        pc.printf("Third button\n" );
        pokeballCount = 5;
        pokeballCursedCount = 20;
      }
    }
    else{

    Speaker mySpeaker(p26);
    if(inputs.b1 == 0 && buttonPressed1 == 0)
    {
        int number = 0;
        while(number < 2){
        mySpeaker.PlayNote(1100.0, 0.1, 0.2);
        mySpeaker.PlayNote(800.0, 0.1, 0.2);
        number ++;
        }
        buttonPressed1 = 1;

    }
    if(inputs.b1 == 1 && buttonPressed1 == 1)
    {
        Player.omni = !Player.omni;
        mySpeaker.PlayNote(969.0,0.1,0.2);
        buttonPressed1 = 0;
        return 1;
    }
    if(inputs.b2 == 0 && buttonPressed2 == 0)
    {
        buttonPressed2 = 1;
    }
    if(inputs.b2 == 1 && buttonPressed2 == 1)
    {
        buttonPressed2 = 0;
        return 1;
    }
    if(inputs.b3 == 0 && buttonPressed3 == 0)
    {
        buttonPressed3 = 1;
    }
    if(inputs.b3 == 1 && buttonPressed3 == 1)
    {
        buttonPressed3 = 0;
        return 1;
    }
  }
  return 0;
}


void check_stuff()
{
    MapItem* itemHere = get_here(Player.x,Player.y);
    if(itemHere->type == POKEBALL)
    {
        deleteHere(Player.x,Player.y);
        Player.pokeballs ++;
    }
    else if(itemHere->type == POKEBALLCURSED)
    {
        deleteHere(Player.x,Player.y);
        Player.health --;
    }
    else if(itemHere->type == KEY)
    {
        deleteHere(Player.x,Player.y);
        Player.has_key = 1;
    }
}


/**
 * Update the game state based on the user action. For example, if the user
 * requests GO_UP, then this function should determine if that is possible by
 * consulting the map, and update the Player position accordingly.
 *
 * Return values are defined below. FULL_DRAW indicates that for this frame,
 * draw_game should not optimize drawing and should draw every tile, even if
 * the player has not moved.
 */
#define NO_RESULT 0
#define GAME_OVER 1
#define FULL_DRAW 2
int update_game(int action)
{
  Speaker mySpeaker(p26);

    // Save player previous location before updating
    Player.px = Player.x;
    Player.py = Player.y;

    // Do different things based on the each action.
    // You can define functions like "go_up()" that get called for each case.
    switch(action)
    {
      
        case GO_UP:
            Player.y = Player.y + 1;
            if(yval<10){
              add_NPC(xval,yval+1);
              add_blank(xval,yval);
              yval = yval+1;  
            }
            break;

        case PUSHBOULDER:
            if(boulderX < 38){
              add_boulder(boulderX+1,21);
              add_blank(boulderX, 21);
              boulderX++;
              speech("PIKA PIKA", "PIKACHU!!!");
            }
        case GO_LEFT:
            Player.x = Player.x - 1;
            if(xval>44){
              add_NPC(xval-1,yval);
              add_blank(xval,yval);
              xval = xval -1;  
            }
            break;
        case GO_DOWN:
            Player.y = Player.y - 1;
            break;
        case GO_RIGHT:
            Player.x = Player.x + 1;
            break;
        case TELEPORT:
            if(Player.pokeballs > 0){
              speech("HAHHA", "GOT YOU PUNK!");
              for(int x =0; x < Player.pokeballs; x++){
                add_pokeball(43, x+6);
                add_pokeballCursed(44, x+6);
              }
              Player.x = 42;
              Player.y = 2;
              Player.pokeballs = 0;
              
              add_blank(xval,yval);
              xval = 48; 
              yval = 1;
              add_NPC(xval,yval);
            }else{
              speech("BETTER LUCK", "NEXT TIME");
              Player.x = 2;
              Player.y = 2; 
            }
            break;
        case TALK:
            if(Player.pokeballs == 0)
            {
                //talk to NPC
                /*
                TODO: Add a interaction bubble that pops up when he is talking with the Professor 
                */
                v1 = xval;
                v2 = yval-1;
                add_updateNPC(v1, v2);
                mySpeaker.PlayNote(1200.0,0.4,0.2);

                speech("Oh Pickachu","There you are!");
                speech("Ash is looking","everywhere for you");
                speech("collect 5 Pokemon Balls","and I will grant");
                speech("you the key", "out of here!");
                speech("Don't touch any",  "cursed Pokeballs!");
                speech("And watch out for", "TEAM ROCKET!!!");

                
                for(int x = 0; x < pokeballCount; x++){
                  add_pokeball(41, x + 6);
                }
                for(int y =0; y < pokeballCursedCount; y++){
                  add_pokeballCursed(42, y+6);
                }

                //Move the NPC to the right by 5 steps 
                // add_NPC(47,1);
                // add_blank(48,1);
                // wait(1);
                // add_NPC(46,1);
                // add_blank(47,1);
                // wait(1);
                // add_NPC(45, 1);
                // add_blank(47,1);
                // for(int x = 47; x>= 43; x--){
                //   add_NPC(x,1);
                //   add_blank(x+1, 1);
                //   wait(1);
                // }
                
            }
            else if (Player.pokeballs >= 5)
            {
              mySpeaker.PlayNote(1500.0,0.4,0.2);
                speech("Well done", "Pickachu!");
                add_blank(v1, v2);
                speech("Here is the key", "to the door!");
                add_key(46,1);
            }
            else
                speech("I need more", "PokemonBalls!");
            break;
        case DOORFOUND:
            {

                if(Player.has_key == 0)
                {
                    speech("You don't have the key!","");
                }
                else
                {
                    speech("Hey Pickachu!", "There you are!");
                    Player.end = 0;
                }
                break;
            }
        case DOORFOUND2:
        {

            if(Player.has_key == 0)
            {
              speech("Go get the", "key first!");
            }
            else
            {
                speech("Fantastic!!!", "");
                speech("Watch out", "for MEWTWO");
                // add_plant(34, 20, VERTICAL, 1);
                add_blank(34,20);
            }
            break;
        }
        default:        
        break;
    }
    return NO_RESULT;
}

/**
 * Entry point for frame drawing. This should be called once per iteration of
 * the game loop. This draws all tiles on the screen, followed by the status
 * bars. Unless init is nonzero, this function will optimize drawing by only
 * drawing tiles that have changed from the previous frame.
 */
void draw_game(int init)
{
    // Draw game border first
    if(init)
    {
        draw_border();
    }


    // Iterate over all visible map tiles
    for (int i = -5; i <= 5; i++) // Iterate over columns of tiles
    {
        for (int j = -4; j <= 4; j++) // Iterate over one column of tiles
        {
            // Here, we have a given (i,j)

            // Compute the current map (x,y) of this tile
            int x = i + Player.x;
            int y = j + Player.y;

            // Compute the previous map (px, py) of this tile
            int px = i + Player.px;
            int py = j + Player.py;

            // Compute u,v coordinates for drawing
            int u = (i+5)*11 + 3;
            int v = (j+4)*11 + 15;

            // Figure out what to draw
            DrawFunc draw = NULL;
            if (i == 0 && j == 0) // Only draw the player on init
            {
                draw_player(u, v, Player.has_key);
                continue;
            }
            else if (x >= 0 && y >= 0 && x < map_width() && y < map_height()) // Current (i,j) in the map
            {
                MapItem* curr_item = get_here(x, y);
                MapItem* prev_item = get_here(px, py);
                if (init || curr_item != prev_item) // Only draw if they're different
                {
                    if (curr_item) // There's something here! Draw it
                    {
                        draw = curr_item->draw;
                    }
                    else // There used to be something, but now there isn't
                    {
                        draw = draw_nothing;
                    }
                }
            }
            else if (init) // If doing a full draw, but we're out of bounds, draw the walls.
            {
                draw = draw_wall;
            }

            // Actually draw the tile
            if (draw) draw(u, v);
        }
    }

    // Draw status bars
    draw_upper_status();
    draw_lower_status();
}


/**
 * Initialize the main world map. Add walls around the edges, interior chambers,
 * and plants in the background so you can see motion.
 */
void init_main_map()
{
  
    uLCD.filled_rectangle(0,0,127,127, BLACK);
    // "Random" plants
    Map* map = set_active_map(0);
    for(int i = 21; i < 30; i++)
    {
       add_plant(i, 14,VERTICAL,5);
    }
    for(int i = 36; i < 39; i++)
    {
        add_plant(i,14,VERTICAL,5);
    }

        add_wall(20,1,VERTICAL,20);
        add_wall(40,1,VERTICAL,20);
        add_wall(20,20,HORIZONTAL,14);
        add_wall(35,20,HORIZONTAL,6);

  
    add_door(30,1);
    add_door2(34, 20);
    add_boulder(34, 21); 
    add_NPC(48,1);


    //add a four monsters that block the path to the door 
    for(int x = 26; x < 36; x++){
      if (x%2==1) {
        add_q1(x, 3);
        add_q4(x, 4);
      }else{
        add_q2(x, 3);
        add_q3(x, 4);
      }
    }

    

    
    add_TEAMROCKET(10, 10);
    add_TEAMROCKET2(36,18);
    add_TEAMROCKET3(40, 23);
    add_TEAMROCKET4(27,17);

    add_wall(0,              0,              HORIZONTAL, map_width());
    add_wall(0,              map_height()-1, HORIZONTAL, map_width());
    add_wall(0,              0,              VERTICAL,   map_height());
    add_wall(map_width()-1,  0,              VERTICAL,   map_height());

    print_map();
}

/**
 * Program entry point! This is where it all begins.
 * This function orchestrates all the parts of the game. Most of your
 * implementation should be elsewhere - this holds the game loop, and should
 * read like a road map for the rest of the code.
 */
int main()
{

    // First things first: initialize hardware
    ASSERT_P(hardware_init() == ERROR_NONE, "Hardware init failed!");

    int startScreen = 1;
    //Start screen
    while(startScreen)
    {
        draw_startScreen();

        startScreen = !user_Input(read_inputs());


    }

    // Initialize the maps
    maps_init();
    init_main_map();

    // Initialize game state
    set_active_map(0);
    Player.x = Player.y = 5;
    Player.health = 5;
    Player.omni = 0;
    Player.pokeballs = 0;
    Player.end = 1;
    // Initial drawing
    draw_game(true);

    // Main game loop
    while(Player.end)
    {
        // Timer to measure game update speed
        Timer t; t.start();
        draw_game(false);
        update_game(get_action(read_inputs()));
        draw_game(false);
        // Actuall do the game update:
        // 1. Read inputs
        // 2. Determine action (get_action)
        // 3. Update game (update_game)
        // 3b. Check for game over
        // 4. Draw frame (draw_game)
        // 5. Frame delay
        uLCD.locate(1,15);
        uLCD.printf("LIVES %d",Player.health);
        uLCD.locate(1,0);
        if(Player.x < 10)
            uLCD.printf("X-val 0%d",Player.x);
        else
            uLCD.printf("X-val %d",Player.x);
        uLCD.locate(9,0);
        if (Player.y < 10)
            uLCD.printf("Y-val 0%d",Player.y);
        else
            uLCD.printf("Y-val %d",Player.y);
        uLCD.locate(9,15);
        uLCD.printf("Balls: %d",Player.pokeballs);
        check_stuff();
        user_Input(read_inputs());
        if(Player.health <=0)
        {
            Player.end = 0;
            draw_gameend();
            return;
        }
        t.stop();
        int dt = t.read_ms();
        if (dt < 100) wait_ms(100 - dt);
    }

float note[18]= {1568.0,1396.9,1244.5,1244.5,1396.9,1568.0,1568.0,1568.0,1396.9,
             1244.5,1396.9,1568.0,1396.9,1244.5,1174.7,1244.5,1244.5, 0.0
            };
float duration[18]= {0.48,0.24,0.72,0.48,0.24,0.48,0.24,0.24,0.24,
                 0.24,0.24,0.24,0.24,0.48,0.24,0.48,0.48, 0.0
                };

        draw_gameendWin();
   Speaker mySpeaker(p26);
   for(int x = 0; x < 18; x++){
   mySpeaker.PlayNote(note[x], duration[x], 0.1);
 }
        // thePlayer.PlaySong(note,duration);


}
