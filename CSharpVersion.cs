import Random;
class TextAdventure {
  public static Random RGI = new Random();
  public static int gen(int x,int y)
  {
    return RGI.next(x,y+1);
  }
}
