class OutputNeuron extends Neuron{
  public OutputNeuron(Neuron... input){
    this.input = input;
    weights = new double[input.length];
  }
  public double output(){
    double sum = 0;
    for(int i = 0; i<input.length; i++){
      sum += input[i].output()*weights[i];
    }
    return sum;
  }
}