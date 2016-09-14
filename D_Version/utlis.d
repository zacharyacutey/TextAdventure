int gen(int x,int y)
{
  import std.random : uniform;
  return uniform!"[]"(x,y);
}
