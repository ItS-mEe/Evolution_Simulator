import java.util.*;
class Map{
  //declaring instances
  private LinkedList<Organism> organisms;
  private LinkedList<Food> food;
  public int w;
  public int h;
  private int time;
  private double foodValue = 150;
  
  public Map(int w, int h, double foodValue){//food value = energy per each food eaten
    time = 0;//Set up time
    organisms = new LinkedList<Organism>();//Create blank list of organisms
    food = new LinkedList<Food>();//Create blank list of food
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
   
  public Organism findNearestOrganism (Organism originOrganism){//Find the closest organism to the originOrganism
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
  
  public Food findNearestFood (Organism originOrganism){//Find the closest food to the originOrganism
    double minDistance = 99999;
    Food retVal = food.get(0);
    for(Food checkFood : food){
      double dist = calculateDistance(originOrganism.getX(), checkFood.getX(), originOrganism.getY(), checkFood.getY());
      if(dist < minDistance)retVal = checkFood;
    }
    return retVal;
  }
  
  public void addOrganism(Organism newOrganism){//Add an organism to be registered on the board
    organisms.add(newOrganism);
    newOrganism.setMap(this);
  }

  public void addFood(Food newFood){//Add a food to be registered on the board
    food.add(newFood);
  }
  
  public void update(){//Update the board by reading each organism's decision and progressing in time
    time++;
    for(int i = 0; i < organisms.size(); i++){//Reading and changing each organism's status
      if(organisms.get(i).energy > 0){ //If alive
        Organism organism = organisms.get(i);
        organism.update();//Update the organism itself's status by running through it's neural network
        
        //Setting the organism's new position based on their velocity
        organism.setX(organism.getX() + organism.getXSpeed());
        organism.setY(organism.getY() + organism.getYSpeed());
        
        //Edge loop
        if(organism.getX() > w) organism.setX(organism.getX() - w);
        if(organism.getX() < 0) organism.setX(organism.getX() + w);
        if(organism.getY() > h) organism.setY(organism.getY() - h);
        if(organism.getY() < 0) organism.setY(organism.getY() + h);
        
        //Energy decay
        organism.energy -= (Math.abs(organism.getXSpeed()) + Math.abs(organism.getYSpeed()));
        organism.energy -= 1;
        
        //Check if eatting food(Colliding with food)
        for(int j = 0; j < food.size(); j++){//Getting a reference for all food that exists currently
          Food checkFood = food.get(j);
          if(calculateDistance(organism.getX(), checkFood.getX(), organism.getY(), checkFood.getY()) < organism.getRadius() + checkFood.getRadius()){//If colliding
            food.remove(j);//Food gets removed from the board
            j--;
            organism.energy += foodValue;//Gain energy based on food value
          }
        }
        
        if(organism.getCollisionTimer() > 0){//If the organism had a collision with another organism recently
          organism.setCollisionTimer(organism.getCollisionTimer() - 1);//Reduce timer
        }else{//If the organism haven't collide with organisms in a while
        
          //Check for collision between organisms
          for(int j = 0; j < organisms.size(); j++){//Loop through all other organisms
            Organism checkOrganism = organisms.get(j);
            if(checkOrganism.getCollisionTimer() == 0){//If the organism being check haven't collide with organisms in a while
              if(calculateDistance(organism.getX(), checkOrganism.getX(), organism.getY(), checkOrganism.getY()) < organism.getRadius() + checkOrganism.getRadius()){//If colliding
                
                //Start timer to avoid either of the organims to be involved in another collision calculation for a while
                checkOrganism.setCollisionTimer(50);
                organism.setCollisionTimer(50);
                
                //Determine collision result based on each organism's reaction
                if(organism.getReact()){//If this organism is passive
                  if(checkOrganism.getReact()){//If the checked organism is also passive
                    //Nothing happenes
                  }else{//If the checked organism is aggressive
                    if(Math.random() < 0.4){//The checked organism have a chance of eating this organism
                      checkOrganism.energy += organism.energy;//Eating gives the checked organism all of this organism's energy
                      organisms.remove(i);//This organism gets removed from the board
                      i--;
                      println("eat!");
                    }
                  }
                }else{//If this organism is aggresive
                  if(checkOrganism.getReact()){//If the checked organism is passive
                    if(Math.random() < 0.4){//The checked organism have a chance of being eaten by this organism
                      organism.energy += checkOrganism.energy;//Eating gives the this organism all of the checked organism's energy
                      organisms.remove(j);//Checked organism gets removed from the board
                      j--;
                      println("eat!");
                    }
                  }else{//If the checked organism is also aggresive
                    if(Math.random() < 0.5){//Either this organism eats the checked organism
                      organism.energy += checkOrganism.energy;//Eating gives the this organism all of the checked organism's energy
                      organisms.remove(j);//Checked organism gets removed from the board
                      j--;
                      println("eat!");
                    }else{//Or checked organism eats this organism
                      checkOrganism.energy += organism.energy;//Eating gives the checked organism all of this organism's energy
                      organisms.remove(i);;//This organism gets removed from the board
                      i--;
                      println("eat!");
                    }
                  }              
                }
                
                break;//Each organism should not be able to collide with multiple organisms in one round, so stop checking
              }
            }
          }
          
        }
      }else{//If the organism doesn't have the energy to live
        organisms.remove(i);//This organism gets removed from the board
        i--;
      }
    }
  }
  
  //Calculates the distance between two points, include edge loop
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