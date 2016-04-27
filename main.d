import std.stdio;
import std.random;
int[int[3]] map; //Game Map
int[3] pos; //Player position
int health=1000;
enum {
  GRASS, //Ground level nothing
  ENEMY_GRASS, //Ground level enemy
  ENTRANCE, //Ground level Descend
  CAVE, //Underground level nothing
  ENEMY_CAVE, //Underground level enemy
  LADDER, //Underground level Ascend/Descend
  BOSS //Boss Battle
} //The enumeration of the possible values for the tile values
bool has_visited()
{
  try { cast(void)(map[pos]); return true;} catch { return false; }
}
void generate_tile()
{
  if(has_visited() || pos == [99,99,-9])
  {
    return;
  }
  else if(pos[2]==0)
  {
    map[pos]=[GRASS,ENEMY_GRASS,ENTRANCE][uniform(0,3)];
  }
  else
  {
    map[pos]=[CAVE,ENEMY_CAVE,LADDER][uniform(0,3)];
  }
}
void left()
{
  pos[0]-=1;
}
void right()
{
  pos[0]+=1;
}
void up()
{
  pos[1]+=1;
}
void down()
{
  pos[1]-=1;
}
void jump()
{
  if(map[pos]==LADDER)
  {
    pos[2]-=1;
  }
  else
  {
    writeln("No ladders leading up from here!");
  }
}
void fall()
{
  if(map[pos]==ENTRANCE || map[pos]==LADDER)
  {
    pos[2]+=1;
  }
  else
  {
    writeln("Can't move down from here!");
  }
}
void help_map()
{
  writeln("W - Up/North");
  writeln("A - Left/West");
  writeln("S - Down/South");
  writeln("D - Right/East");
  writeln("U - Ascend/Up");
  writeln("M - Descend/Down");
}
void main()
{
  map[[99,99,-9]]=BOSS;
  generate_tile();
  writeln("Defeat the boss at (99,99,-9) to win!");
}
