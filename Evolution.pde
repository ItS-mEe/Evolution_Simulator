//Declaring Variables
private int SEED = 0;
private int BOARD_W = 960;
private int BOARD_H = 960;
private final int DELAY = 0;
private final int ORGANISM_RADIUS = 10;
private final int FOOD_RADIUS = 5;
private final double FOOD_VALUE = 150;
private final int ORGANISM_PER_ROUND = 100;
private final int FOOD_PER_ROUND = 300;
private final int BIRTH_PER_ORGANISM = 2;
private final int NEW_ORGANISM_PER_ROUND = 20;
private Map board;
private final double START_ENERGY = 420;

public void setup(){
  //Basic settings set up
  frameRate(60);
  randomSeed(SEED);
  noSmooth();
  size(960, 960);
  colorMode(HSB, ORGANISM_PER_ROUND);
  
  board = new Map(BOARD_W, BOARD_H, FOOD_VALUE); //Creating innitial board
  
  println("start");
  
  for(int i = 0; i < ORGANISM_PER_ROUND; i++){//Creating new organisms and adding them to the board
    Organism newOrganism = new Organism((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), ORGANISM_RADIUS, i, START_ENERGY);
    board.addOrganism(newOrganism);
  }
  
  for(int i = 0; i < FOOD_PER_ROUND; i++){//Creating new food and adding them to the board
    Food newFood = new Food((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), FOOD_RADIUS);
    board.addFood(newFood);
  }
}

void draw(){
  clear();//Clear  last screen
  delay(DELAY);
  board.update();//Update the board's situation base on organism's decisions and decay
  
  LinkedList<Organism> organismList = board.getOrganismList(); 
  LinkedList<Food> foodList = board.getFoodList();
  
  if(organismList.size() <= (ORGANISM_PER_ROUND - NEW_ORGANISM_PER_ROUND) / BIRTH_PER_ORGANISM){ //If the amount of organism on the current board is low enough for every organism to have offsprings and have new blood join 
    Map newBoard = new Map(BOARD_W, BOARD_H, FOOD_VALUE); //Creating new board for new generation
    
    for(int i = 0; i < organismList.size(); i++){ //Creating offsprings for each alive organism
      for(int j = 0; j < BIRTH_PER_ORGANISM; j++){
        Organism newOrganism = new Organism((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), ORGANISM_RADIUS, START_ENERGY, organismList.get(i));
        newBoard.addOrganism(newOrganism);
      }
    }
    
    for(int i = 0; i < ORGANISM_PER_ROUND - (organismList.size() * 2); i++){//Creating new blood to join
      Organism newOrganism = new Organism((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), ORGANISM_RADIUS, i, START_ENERGY);
      newBoard.addOrganism(newOrganism);
    }
    
    for(int i = 0; i < FOOD_PER_ROUND; i++){//Creating food
      Food newFood = new Food((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), FOOD_RADIUS);
      board.addFood(newFood);
    }
    board = newBoard;
  }
  for(Organism organism: organismList){//Draw all organisms on the screen
    fill(organism.getHue(), ORGANISM_PER_ROUND, ORGANISM_PER_ROUND);
    stroke(organism.getHue(), ORGANISM_PER_ROUND, ORGANISM_PER_ROUND);
    ellipse(organism.getX() * width / BOARD_W, organism.getY() * height / BOARD_H, organism.getRadius() * width / BOARD_W, organism.getRadius() * height / BOARD_H);
  }
  for(Food food: foodList){//Draw all food on the screen
    fill(0, 0, 100);
    stroke(0, 0, 100);
    ellipse(food.getX() * width / BOARD_W, food.getY() * height / BOARD_H, food.getRadius() * width / BOARD_W, food.getRadius() * height / BOARD_H);
  }
}