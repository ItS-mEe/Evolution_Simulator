class Food{
  private int x;
  private int y;
  private int radius;
  
  public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }
  public void setX(int x){
    this.x = x;
  }
  public void setY(int y){
    this.y = y;
  }
  public int getRadius(){
    return radius;
  }

  public Food(int x, int y, int radius){
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
}