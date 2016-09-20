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
import std.stdio;
char alex_char(ref Entity player,ref Entity alex)
{
	if(player.attacks[0].max_damage - alex.armor >= alex.health)
	{
		if(alex.medkits > 0)
		{
			return 'm';
		}
		else
		{
			return "qd"[gen(0,1)];
		}
	}
	else
	{
		return 'b';
	}
}
void alex_attack(char c,ref Entity player,ref Entity alex)
{
	switch(c)
	{
		case 'b':
			writeln("Alex: BIG SLASH");
			do_damage(alex,player,0);
			break;
		case 'q':
			writeln("Alex: QUICK SLASH");
			do_damage(alex,player,1);
			break;
		case 'm':
			writeln("ALEX uses a medkit! YES, he has medkits!");
			alex.medkits--;
			alex.health = alex.max_health;
			break;
		default:
			break;
	}
}
void you_attack(char c,char ac,ref Entity player,ref Entity alex)
{
	switch(c)
	{
		case 'a':
			if(ac == 'd' && is_fail(alex.fail))
			{
				writeln("You attack, and Alex tries to dodge and fails!");
				do_damage(player,alex);
			}
			else if(ac == 'd')
			{
				writeln("You attack, and Alex DODGES!");
			}
			else
			{
				writeln("You attack Alex!");
				do_damage(player,alex);
			}
			break;
		case 'd':
			writeln("You have somehow lost the ability to dodge!"); //I'm too lazy to implement that.
			break;
		case 'm':
			if(player.medkits > 0)
			{
				writeln("You use a medkit!");
				player.medkits--;
				player.health = player.max_health;
			}
			else
			{
				writeln("You really shouldn't be fooling around, as you're out of medkits!");
				writeln("YOU REALIZE YOU OPENED YOURSELF UP FOR ATTACK!");
			}
			break;
		case '\n':
			break;
		default:
			writeln("WHAT ARE YOU DOING, THIS GUY IS AS STORNG AS YOU!!!!");
			writeln("Alex: You entered an invalid command! HAHA!");
			break;
	}
}
void boss(ref Entity player){
        string line;
	writeln("Here, have full health");
	player.health = player.max_health;
	Entity alex;
	Weapon big;
	Weapon quick;
	big.name="BIG SLASH";
	quick.name="QUICK SLASH";
	big.min_damage = 15;
	big.max_damage = 50;
	big.fail = [1,4];
	quick.min_damage = 5;
	quick.max_damage = 12;
	quick.fail = [1,10];
	alex.attacks=[big,quick];
	alex.name = "ALEX TRAHAN";
	alex.fail = [1,4];
	alex.max_health = player.max_health;
	alex.health = alex.max_health;
	if(player.armor > 20)
	{
		writeln("You have so much armor, it collapses around you during this fight! ARMOR IS NONE!");
		player.armor = 0;
	}
	alex.armor = player.armor;
	alex.medkits = player.medkits;
    while(!is_dead(player) && !is_dead(alex))
    {
      line = readln()[0..$-1];
      bool stop = false;
      foreach(i;line)
      {
	char c;
        pstats(player);
	pstats(alex);
        if(!stop)
	{
		c = alex_char(player,alex);
		you_attack(i,c,player,alex);
		if(!is_dead(alex))
		{
			alex_attack(c,player,alex);
		}
	}
        if(is_dead(player) || is_dead(alex))
          stop = true;
      }
    }
    if(is_dead(player))
    {
	writeln("ALEX SAYS: I WIN!");
    	death_screen();
    }
    writeln("You defeat Alex, then you realize Zach deletes the whole world before your ey--");
    writeln("ZACH---There's nothing left!");
    death_screen();
}
void main()
{
  writeln("What is your name Player?");
  string n = readln()[0..$-1];
  Board b;
  init_board(b);
  Entity player;
  Weapon w;
  w.min_damage = 10;
  w.max_damage = 30;
  w.fail = [1,5];
  w.name = "Your weapon";
  player.attacks = [w];
  player.max_health = 1000;
  player.health = player.max_health;
  player.fail = [1,4];
  player.name = n;
  while(true)
  {
    string l = readln()[0..$-1];
    foreach(i;l)
    {
      board_command(i,b,player);
    }
  }
}
int gen(int x,int y) //Returns a random integer in the range [x,y]
{
	import std.random;
	return uniform!"[]"(x,y);
}
bool is_fail(int[2] fail_stat) //Returns 1 for fail_stat[0]/fail_stat[1] of the time, 0 otherwise.
{
	int pool = gen(1,fail_stat[1]);
	return pool <= fail_stat[0];
}

struct Weapon
{
  string name;
  int min_damage;
  int max_damage;
  int[2] fail;
}
struct Entity
{
  string name;
  int health;
  int max_health;
  int armor;
  int[2] fail;
  Weapon[] attacks;
  Weapon[] weapons()
  {
    return this.attacks;
  }
  int min_damage(int i=0)
  {
    return this.attacks[i].min_damage;
  }
  int max_damage(int i=0)
  {
    return this.attacks[i].max_damage;
  }
  void weapons(Weapon[] ws)
  {
    this.attacks = ws;
  }
  int medkits;
}
void estats(ref Entity e)
{
  import std.stdio;
  writeln(e.name ~ " health:\t",e.health);
}
void pstats(ref Entity e)
{
  import std.stdio;
  writeln(e.name ~ " health:\t",e.health);
  writeln("Max health:\t",e.max_health);
  writeln("Medkits:\t",e.medkits);
}
void stats(ref Entity e,ref Entity p)
{
  estats(e);
  pstats(p);
}
bool is_dead(ref Entity e)
{
  return e.health <= 0;
}
void do_damage(ref Entity harmer,ref Entity harmed,int weapon_index = 0)
{
  import std.stdio;
  Weapon weapon = harmer.weapons[weapon_index];
  bool fail_var = is_fail(weapon.fail);
  if(fail_var)
  {
    writeln(harmer.name," missed!");
  }
  else
  {
    int damage = gen(harmer.min_damage,harmer.max_damage);
    damage -= harmed.armor;
    if(damage <= 0)
    {
      writeln("The armor of ",harmed.name," blocked the damage!");
      damage = 0;
    }
    harmed.health -= damage;
    writeln(harmer.name," attacked ",harmed.name," and gave ",damage," damage!");
  }
}
void action_command(char command,ref Entity player,ref Entity enemy)
{
  switch(command)
  {
    case 'a':
    case 'A':
      do_damage(player,enemy);
      if(is_dead(enemy)) return;
      do_damage(enemy,player);
      break;
    case 'd':
    case 'D':
      if(is_fail(player.fail))
      {
        writeln("You try to dodge, but failed!");
        do_damage(enemy,player);
      }
      else
      {
        writeln("You succesfully dodged!");
      }
      break;
    case 'm':
    case 'M':
      if(player.medkits > 0)
      {
        writeln("You used a medkit! Health fully restored!");
	player.medkits--;
	player.health = player.max_health;
      }
      else
      {
        writeln("You're out of medkits!");
      }
      do_damage(enemy,player);
      break;
    case '\n':
    case '\r':
      break;
    default:
      writeln("You sit there doing nothing! Giving your enemy a chance to attack!");
      do_damage(enemy,player);
      break;
  }
}

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
void init_board(ref Board b)
{
  b.game_board[[0,0]]=TILE_EMPTY;
  b.game_board[[-1,-1]]=TILE_BOSS;
}
void gen_tile(ref Board b)
{
  if((b.position in b.game_board)==null)
  b.game_board[b.position] = gen_tile_type();
}
int current_tile(ref Board b)
{
  try { return b.game_board[b.position]; } catch(Exception o){ return gen(0,1); }
}
void left(ref Board b,ref Entity player)
{
  b.position[0]--;
  gen_tile(b);
  maybe_fight(b,player);
}
void right(ref Board b,ref Entity player)
{
  b.position[0]++;
  gen_tile(b);
  maybe_fight(b,player);
}
void up(ref Board b,ref Entity player)
{
  b.position[1]++;
  gen_tile(b);
  maybe_fight(b,player);
}
void down(ref Board b,ref Entity player)
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
void maybe_fight(ref Board b,ref Entity player)
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
    w.min_damage = 1;
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
    writeln("The boss Alex approaches! You feel like you're fighting something not from this world!");
    boss(player);
  }
  else
  {
    writeln("YOU FELL INTO A HOLE WHERE YOU BELONG, YOU HACKER! [Or the game's glitched]");
    death_screen();
  }
}
void board_command(char c,ref Board b,ref Entity e)
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
    case '\n':
    case '\r':
    break;
    default:
    writeln("You just sit there, doing nothing...");
    break;
  }
}
