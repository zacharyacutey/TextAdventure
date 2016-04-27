import std.stdio;
import std.random;
int[int[3]][] map; //Game Map
int[3] pos; //Player position

enum {
  GRASS, //Ground level nothing
  ENEMY_GRASS, //Ground level enemy
  CAVE, //Underground level nothing
  ENEMY_CAVE, //Underground level enemy
  ENTRANCE, //Ground level Descend
  LADDER, //Underground level Ascend/Descend
  BOSS //Boss Battle
} //The enumeration of the possible values for the tile values

void main()
{
  
}
