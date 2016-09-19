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
import std.random;

int gen(int x,int y)
{
	return uniform!"[]"(x,y);
}
struct Entity {
	string name;
	int armor;
	int health;
	int max_health;
	int min_damage;
	int max_damage;
	int dodge_fail;
	int damage_miss;
	int medkits;
}
void estats(Entity e)
{
	writeln("Enemy Name:\t",e.name);
	writeln("Enemy Health:\t",e.health);
}
void pstats(Entity p)
{
	writeln("Your Name:\t",p.name);
	writeln("Your current Armor:\t",p.armor);
	writeln("Your current Health:\t",p.health);
	writeln("Your maximum Health:\t",p.max_health);
	writeln("Damage Possible:\t",p.min_damage,"-",p.max_damage);
	writeln("Dodge fail chance:\t1/",p.dodge_fail);
	writeln("Chance of failed attack:\t1/",p.damage_miss);
	writeln("Medkits:\t",p.medkits);
}
