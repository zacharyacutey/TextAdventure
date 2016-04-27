import std.stdio;
import std.random;
int[int[3]] map; //Game Map
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
bool has_visited(int[3] position)
{
  try { cast(void)(map[position]); return true;} catch { return false; }
}
void main()
{
  writeln("Defeat the boss at (-9,99,99) to win!");
}
