/*
Copyright (C) 2016 Zachary Taylor

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

NOTE: MY LEGAL NAME IS SPELLED WITHOUT THE ACUTE ACCENT
You can contact me @
zacharywithanacuteoverthey@gmail.com
*/
module board;
import gen;
import misc;
import std.stdio;
enum { TILE_EMPTY, TILE_ENEMY, TILE_BOSS }
struct Board
{
  int[int[2]] game_board;
  int[2] position;
}
int gen_tile_type()
{
  return gen(0,1);
}
void init_board(Board b)
{
  b.game_board[[0,0]]=TILE_EMPTY;
  b.game_board[[-1,-1]]=TILE_BOSS;
}
void gen_tile(Board b)
{
  if((b.position in b.game_board)==null)
  b.game_board[b.position] = gen_tile_type();
}
int current_tile(Board b)
{
  return b.game_board[b.position];
}
void left(Board b,Entity player)
{
  b.position[0]--;
  gen_tile(b);
  maybe_fight(b,player);
}
void right(Board b,Entity player)
{
  b.position[0]++;
  gen_tile(b);
  maybe_fight(b,player);
}
void up(Board b,Entity player)
{
  b.position[1]++;
  gen_tile(b);
  maybe_fight(b,player);
}
void down(Board b,Entity player)
{
  b.position[1]--;
  gen_tile(b);
  maybe_fight(b,player);
}
void death_screen()
{
  writeln("YOU DIED");
  while(true) readln();
}
void maybe_fight(Board b,Entity player)
{
  string line;
  if(current_tile(b) == TILE_EMPTY)
  {
    writeln("There is nothing but the ground!");
  }
  else if(current_tile(b) == TILE_ENEMY)
  {
    writeln("There is an enemy!");
    Entity e;
    e.name = "Enemy";
    e.max_health = 500;
    e.health = 500;
    Weapon w;
    w.name = "Weapon";
    w.min_damage = 25;
    w.max_damage = 50;
    w.fail = [0,1];
    e.weapons = [w];
    stats(e,player);
    while(!is_dead(player) && !is_dead(e))
    {
      line = readln();
      bool stop = false;
      foreach(i;line)
      {
        stats(e,player);
        if(!stop) action_command(i,player,e);
        if(is_dead(player) || is_dead(e))
          stop = true;
      }
    }
    if(is_dead(player)) death_screen();
    writeln("You killed the enemy!");
    writeln("Select something to loot: 1-Medkit 2-Armor");
    while(true)
    {
      line = readln();
      if(line == "1\n")
      {
        writeln("You took a medkit!");
        player.medkits++;
        break;
      }
      else if(line == "2\n")
      {
        writeln("You took a piece of armor");
        player.armor++;
        break;
      }
      else
      {
        writeln("You can't just stand there!");
      }
    }
  }
  else if(current_tile(b) == TILE_BOSS)
  {
    writeln("The boss Alex_Player approaches!");
    writeln("AND HE TELLS YOU THIS BATTLE ISN'T READY YET! GET LOST!");
  }
  else
  {
    writeln("YOU FELL INTO A HOLE WHERE YOU BELONG, YOU HACKER! [Or the game's glitched]");
    death_screen();
  }
}
void board_command(char c,Board b,Entity e)
{
  switch(c)
  {
    case 'a':
    case 'A':
    left(b,e);
    break;
    case 'd':
    case 'D':
    right(b,e);
    break;
    case 'w':
    case 'W':
    up(b,e);
    break;
    case 's':
    case 'S':
    down(b,e);
    break;
    default:
    writeln("You just sit there, doing nothing...");
    break;
  }
}
