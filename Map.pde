import java.util.*;
class Map{
  private LinkedList<Organism> organisms;
  private LinkedList<Food> food;
  public int w;
  public int h;
  private int time;
  private double foodValue = 150;
  
  public Map(int w, int h, double foodValue){
    time = 0;
    organisms = new LinkedList<Organism>();
    food = new LinkedList<Food>();
    this.foodValue = foodValue;
    this.w = w;
    this.h = h;
  }
  
  public LinkedList<Organism> getOrganismList(){
    return organisms;
  }
  
  public LinkedList<Food> getFoodList(){
    return food;
  }
  
  public Organism getOrganism(int i){
    return organisms.get(i); 
  }
  
  public Food getFood(int i){
    return food.get(i);
  }
  
  public int getTime(){
    return time;
  }
  
  public void setTime(int time){
    this.time = time;
  }
   
  public Organism findNearestOrganism (Organism originOrganism){
    double minDistance = 99999;
    Organism retVal = originOrganism;
    for(Organism organism: organisms){
      if(organism != originOrganism){
        double dist = calculateDistance(originOrganism.getX(), organism.getX(), originOrganism.getY(), organism.getY());
        if(dist < minDistance)retVal = organism;
      }
    }
    return retVal;
  }
  
  public Food findNearestFood (Organism originOrganism){
    double minDistance = 99999;
    Food retVal = food.get(0);
    for(Food checkFood : food){
      double dist = calculateDistance(originOrganism.getX(), checkFood.getX(), originOrganism.getY(), checkFood.getY());
      if(dist < minDistance)retVal = checkFood;
    }
    return retVal;
  }
  
  public void addOrganism(Organism newOrganism){
    organisms.add(newOrganism);
    newOrganism.setMap(this);
  }

  public void addFood(Food newFood){
    food.add(newFood);
  }
  
  public void update(){
    time++;
    for(int i = 0; i < organisms.size(); i++){
      if(organisms.get(i).energy > 0){
        Organism organism = organisms.get(i);
        organism.update();
        organism.setX(organism.getX() + organism.getXSpeed());
        organism.setY(organism.getY() + organism.getYSpeed());
        if(organism.getX() > w) organism.setX(organism.getX() - w);
        if(organism.getX() < 0) organism.setX(organism.getX() + w);
        if(organism.getY() > h) organism.setY(organism.getY() - h);
        if(organism.getY() < 0) organism.setY(organism.getY() + h);
        organism.energy -= (organism.getXSpeed() + organism.getYSpeed());
        for(int j = 0; j < food.size(); j++){
          Food checkFood = food.get(j);
          if(calculateDistance(organism.getX(), checkFood.getX(), organism.getY(), checkFood.getY()) < organism.getRadius() + checkFood.getRadius()){
            food.remove(j);
            j--;
            organism.energy += foodValue;
          }
        }
        if(organism.getCollisionTimer() > 0){
          organism.setCollisionTimer(organism.getCollisionTimer() - 1);
        }else{
          for(int j = 0; j < organisms.size(); j++){
            Organism checkOrganism = organisms.get(j);
            if(checkOrganism.getCollisionTimer() == 0){
              if(calculateDistance(organism.getX(), checkOrganism.getX(), organism.getY(), checkOrganism.getY()) < organism.getRadius() + checkOrganism.getRadius()){
                checkOrganism.setCollisionTimer(50);
                organism.setCollisionTimer(50);
                //println("lol");
                if(organism.getReact()){
                  if(checkOrganism.getReact()){
                    //println("nay");
                  }else{
                    if(Math.random() < 0.4){
                      checkOrganism.energy += organism.energy;
                      organisms.remove(i);
                      i--;
                      //println("eat!");
                    }
                  }
                }else{
                  if(checkOrganism.getReact()){
                    if(Math.random() < 0.4){
                      organism.energy += checkOrganism.energy;
                      organisms.remove(j);
                      j--;
                      //println("eat!");
                    }
                  }else{
                    if(Math.random() < 0.5){
                      organism.energy += checkOrganism.energy;
                      organisms.remove(j);
                      j--;
                      //println("eat!");
                    }else{
                      checkOrganism.energy += organism.energy;
                      organisms.remove(i);
                      i--;
                      //println("eat!");
                    }
                  }              
                }
                break;
              }
            }
          }
        }
      }else{
        organisms.remove(i);
        i--;
      }
    }
  }
  
  private double calculateDistance(int x1, int x2, int y1, int y2){
     double xDist = x1 - x2;
      if(xDist > w / 2){
        xDist -= w;
      }else if(xDist < -w / 2){
        xDist += w;
      }
      double yDist = y1 - y2;
      if(yDist > h / 2){
        yDist -= h;
      }else if(yDist < -h / 2){
        yDist += h;
      }
    return Math.sqrt(xDist * xDist + yDist * yDist);
  }
}