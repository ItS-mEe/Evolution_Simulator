class Neuron{
  
  Neuron[] input;
  double[] weights;
  
  public Neuron(Neuron... input){
    this.input = input;
    weights = new double[input.length];
  }
  
  public void randomizeWeights() {
    for(int i = 0; i<weights.length; i++){
      weights[i] = (int)(Math.random() * 2 - 1);
    }
  }
  
  public double output(){
    double sum = 0;
    for(int i = 0; i<input.length; i++){
      sum += sigmoid(input[i].output()*weights[i]);
    }
    return sum;
  }
  
  public void setWeight(double value, int toSet){
    weights[toSet] = value;
  }
    
  private double sigmoid(double input){
    return 1 / ( 1 + Math.pow(Math.E, -input));
  }
}