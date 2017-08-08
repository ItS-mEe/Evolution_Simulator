int SEED = 0;
int BOARD_W = 1000;
int BOARD_H = 1000;
final int DELAY = 10;
final int ORGANISM_RADIUS = 10;
final int FOOD_RADIUS = 5;
final double FOOD_VALUE = 150;
final int ORGANISM_PER_ROUND = 100;
final int FOOD_PER_ROUND = 300;
Map board;
final double START_ENERGY = 420;
final double DIST_TO_ENERGY = 0.01;

void setup(){
  frameRate(60);
  randomSeed(SEED);
  noSmooth();
  size(960, 960);
  colorMode(HSB, ORGANISM_PER_ROUND);
  board = new Map(920, 920, FOOD_VALUE);
  println("start");
  for(int i = 0; i < ORGANISM_PER_ROUND; i++){
    Organism newOrganism = new Organism((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), ORGANISM_RADIUS, i, START_ENERGY);
    board.addOrganism(newOrganism);
  }
  for(int i = 0; i < FOOD_PER_ROUND; i++){
    Food newFood = new Food((int)(Math.random() * BOARD_W), (int)(Math.random() * BOARD_H), FOOD_RADIUS);
    board.addFood(newFood);
  }
}

void draw(){
  clear();
  delay(DELAY);
  board.update();
  LinkedList<Organism> organismList = board.getOrganismList();
  LinkedList<Food> foodList = board.getFoodList();
  for(Organism organism: organismList){
    fill(organism.getHue(), ORGANISM_PER_ROUND, ORGANISM_PER_ROUND);
    stroke(organism.getHue(), ORGANISM_PER_ROUND, ORGANISM_PER_ROUND);
    ellipse(organism.getX() * width / BOARD_W, organism.getY() * height / BOARD_H, organism.getRadius() * width / BOARD_W, organism.getRadius() * height / BOARD_H);
  }
  for(Food food: foodList){
    fill(0, 0, 100);
    stroke(0, 0, 100);
    ellipse(food.getX() * width / BOARD_W, food.getY() * height / BOARD_H, food.getRadius() * width / BOARD_W, food.getRadius() * height / BOARD_H);
  }
}