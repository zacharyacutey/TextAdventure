using System;
class TextAdventure {
  //GENERAL UTILITIES
  public static Random RGI = new Random();
  public static int gen(int x,int y)
  {
    return RGI.Next(x,y+1);
  }
}
