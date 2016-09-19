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
module combat;
import misc;
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
  int medkits;
}
void estats(Entity e)
{
  import std.stdio;
  writeln(e.name ~ " health:\t",e.health);
}
void pstats(Entity e)
{
  import std.stdio;
  writeln(e.name ~ " health:\t",e.health);
  writeln("Max health:\t",e.max_health);
  writeln("Medkits:\t",e.medkits);
}
void stats(Entity e,Entity p)
{
  estats(e);
  pstats(p);
}
bool is_dead(Entity e)
{
  return e.health <= 0;
}
void do_damage(Entity harmer,Entity harmed,int weapon_index = 0)
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
void action_command(char command,Entity player,Entity enemy)
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
