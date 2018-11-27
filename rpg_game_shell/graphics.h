#ifndef GRAPHICS_H
#define GRAPHICS_H


/**
 * Draws the player. This depends on the player state, so it is not a DrawFunc.
 */
void draw_player(int u, int v, int key);
void draw_q1(int u, int v);
void draw_q2(int u, int v);
void draw_q3(int u, int v);
void draw_q4(int u, int v);
void draw_updateNPC(int u, int v);
void draw_boulder(int u, int v);


void draw_img(int u, int v, const char* img);

/**
 * DrawFunc functions. 
 * These can be used as the MapItem draw functions.
 */
void draw_nothing(int u, int v);
void draw_wall(int u, int v);
void draw_plant(int u, int v);
void draw_door(int u, int v);

/**
 * Draw the upper status bar.
 */
void draw_upper_status();

/**
 * Draw the lower status bar.
 */ 
void draw_lower_status();

/**
 * Draw the border for the map.
 */
void draw_border();

void draw_blank(int u, int v);
void draw_NPC(int u, int v);
void draw_TEAMROCKET(int u, int v);
void draw_pokeball(int u, int v);
void draw_pokeballcursed(int u, int v);
void draw_key(int u, int v);
void draw_gameend();
void draw_TEAMROCKET2(int u, int v);
void draw_TEAMROCKET3(int u, int v);
void draw_TEAMROCKET4(int u, int v);
void draw_gameendWin();
#endif // GRAPHICS_H