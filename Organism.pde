class Organism{
  
  //Declaring outputs
  private double xSpeed;
  private double ySpeed;
  private boolean conflictReaction;
  private double x;
  private double y;
  private double mem1;
  private NeuralNetwork brain;
  private Map map;
  private Organism thisOrganism;
  private int radius;
  private int collisionTimer;
  private int hue;
  public double energy;
  
  //Construct an organism with a randomized brain
  public Organism(int x, int y, int radius, int hue, double energy){
    collisionTimer = 0;
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.hue = hue;
    this.energy = energy;
    xSpeed = 0;
    ySpeed = 0;
    mem1 = 0;
    conflictReaction = false;
    buildBrain();//Build a randomized brain
  }
  
  //Construct an organism with a cloned brain to it's parent
  public Organism(int x, int y, int radius, double energy, Organism parents){
    collisionTimer = 0;
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.hue = parents.getHue();
    this.energy = energy;
    xSpeed = 0;
    ySpeed = 0;
    mem1 = 0;
    conflictReaction = false;
    
    //Defining the inputs
    InputNeuron nearestOrganismXdiff = new InputNeuron(){
      public double output(){
        Organism nearestOrganism = map.findNearestOrganism(thisOrganism);        
        double xDist = getX() - nearestOrganism.getX();
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        return xDist;
      }
    };
    
    InputNeuron nearestOrganismYdiff = new InputNeuron(){
      public double output(){
        Organism nearestOrganism = map.findNearestOrganism(thisOrganism);        
        double yDist = getY() - nearestOrganism.getY();
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        return yDist;
      }
    };
    InputNeuron nearestFoodXdiff = new InputNeuron(){
      public double output(){
        Food nearestFood = map.findNearestFood(thisOrganism);        
        double xDist = getX() - nearestFood.getX();
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        return xDist;
        //return 0;
      }
    };
    
    InputNeuron nearestFoodYdiff = new InputNeuron(){
      public double output(){
        Food nearestFood = map.findNearestFood(thisOrganism);        
        double yDist = getY() - nearestFood.getY();
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        return yDist;
        //return 0;
      }
    };
    InputNeuron timeElapsed = new InputNeuron(){
      public double output(){
        return map.time;
        //return 0;
      }
    };
    InputNeuron constant = new InputNeuron(){
      public double output(){
        return 1;
      }
    };
    InputNeuron mem1 = new InputNeuron(){
      public double output(){
        return getMem1();
        //return 0;
      }
    };
    
    brain = parents.getBrain().clone(nearestOrganismXdiff, nearestOrganismYdiff, nearestFoodXdiff, nearestFoodYdiff, timeElapsed, constant, mem1);//Clone the parent's brain
  }
  
  public NeuralNetwork getBrain(){
    return brain;
  }
  
  public int getHue(){
    return hue;
  }
  
  public int getRadius(){
    return radius;
  }
  
  public int getCollisionTimer(){
    return collisionTimer;
  }
  
  public void setCollisionTimer(int timer){
    collisionTimer = timer;
  }
  private void buildBrain(){//Create a randomized brain
    thisOrganism = this;
    brain = new NeuralNetwork();
    
    //Defining inputs
    InputNeuron nearestOrganismXdiff = new InputNeuron(){
      public double output(){
        Organism nearestOrganism = map.findNearestOrganism(thisOrganism);        
        double xDist = getX() - nearestOrganism.getX();
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        return xDist;
      }
    };
    
    InputNeuron nearestOrganismYdiff = new InputNeuron(){
      public double output(){
        Organism nearestOrganism = map.findNearestOrganism(thisOrganism);        
        double yDist = getY() - nearestOrganism.getY();
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        return yDist;
      }
    };
    InputNeuron nearestFoodXdiff = new InputNeuron(){
      public double output(){
        Food nearestFood = map.findNearestFood(thisOrganism);        
        double xDist = getX() - nearestFood.getX();
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        if(xDist > map.w / 2){
          xDist -= map.w;
        }else if(xDist < -map.w / 2){
          xDist += map.w;
        }
        return xDist;
        //return 0;
      }
    };
    
    InputNeuron nearestFoodYdiff = new InputNeuron(){
      public double output(){
        Food nearestFood = map.findNearestFood(thisOrganism);        
        double yDist = getY() - nearestFood.getY();
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        if(yDist > map.h / 2){
          yDist -= map.h;
        }else if(yDist < -map.h / 2){
          yDist += map.h;
        }
        return yDist;
        //return 0;
      }
    };
    InputNeuron timeElapsed = new InputNeuron(){
      public double output(){
        return map.time;
        //return 0;
      }
    };
    InputNeuron constant = new InputNeuron(){
      public double output(){
        return 1;
      }
    };
    InputNeuron mem1 = new InputNeuron(){
      public double output(){
        return getMem1();
        //return 0;
      }
    };
    brain.createNetwork(4, nearestOrganismXdiff, nearestOrganismYdiff, nearestFoodXdiff, nearestFoodYdiff, timeElapsed, constant, mem1);
  }
  
  //Update the organism's status based on what the neural network output.
  public void update(){
    double[] outputs = brain.getOutputs();
    setXSpeed(outputs[0]);
    setYSpeed(outputs[1]);
    setReact(outputs[2] > 0);
    setMem1(outputs[3]);
  }
  
  public void setMap(Map map){
    this.map = map;
  }
  
  public double getXSpeed(){
    return xSpeed;
  }
  
  public double getYSpeed(){
    return ySpeed;
  }
  
  public void setReact(boolean reaction){
    conflictReaction = reaction;
  }
  
  public boolean getReact(){
    return conflictReaction;
  }
  
  private double getMem1(){
    return mem1;
  }
  
  private void setMem1(double mem){
    this.mem1 = mem;
  }
  
  public int getX(){
    return (int)x;
  }
  
  public int getY(){
    return (int)y;
  } 
  
  public void setX(double x){
    this.x = x;
  }
  
  public void setY(double y){
    this.y = y;
  }
  public void setXSpeed(double newSpeed){
    xSpeed = newSpeed;
  }
  
  public void setYSpeed(double newSpeed){
    ySpeed = newSpeed;
  }
}