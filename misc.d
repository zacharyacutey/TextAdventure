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

module misc;
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
