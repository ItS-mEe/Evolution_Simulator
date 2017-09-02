class Neuron{
  //Decaring this neuron's inputs and the weight they have to this neuron.
  Neuron[] input;
  double[] weights;
  
  //Construcing this neuron and give it inputs
  public Neuron(Neuron... input){
    this.input = input;
    weights = new double[input.length];
  }
 
  public void randomizeWeights() {
    for(int i = 0; i<weights.length; i++){
      weights[i] = Math.random() * 3 - 1;
    }
  }
  
  public double output(){
    double sum = 0;
    for(int i = 0; i<input.length; i++){
      sum += input[i].output()*weights[i];
    }
    return sigmoid(sum);
  }
  
  public void setWeight(double value, int toSet){
    weights[toSet] = value;
  }
  
  public double getWeight(int toGet){
    return weights[toGet];
  }
    
  private double sigmoid(double input){
    return 1 / ( 1 + Math.pow(Math.E, -input));
  }
}