module utils;
int gen(int x,int y)
{
  import std.random;
  return uniform(x,y+1);
}
