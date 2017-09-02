class NeuralNetwork {
  private Organism belongedOrganism;
  private Neuron[][] hiddenLayers;
  private Neuron[] outputs;
  private InputNeuron[] inputs;
  
  public NeuralNetwork(){
    //belongedOrganism = organism;
  }
  
  //Clone and return this NeuralNetwork
  public NeuralNetwork clone(InputNeuron... inputs){
    NeuralNetwork newCopy = new NeuralNetwork();//Create a blank neural network
    newCopy.createNetwork(outputs.length, inputs);//Send the inputs into the network
    Neuron[][] thisHiddenLayers = getHiddenLayers();//Get hidden layers
    Neuron[][] newHiddenLayers = newCopy.getHiddenLayers();//Create new blank hidden layers
    for(int i = 0; i < thisHiddenLayers.length; i++){//For each layers
      for(int j = 0; j < thisHiddenLayers[i].length; j++){//For each neuron in the layor
        for(int n = 0; n < inputs.length - 1; n++){//For each input the neuron has
          println(n);
          newHiddenLayers[i][j].setWeight(thisHiddenLayers[i][j].getWeight(n), n);//Set the weight of the neuron's orignial neural network weight to the input to the new one
        }
      }
    }
    return newCopy;
  }
  
  public Neuron[][] getHiddenLayers(){
    return hiddenLayers;
  }
  
  //Creating a new neural network with the specific inputs
  public void createNetwork(int numOutputs, InputNeuron... inputs){
    this.inputs = inputs;
    hiddenLayers = new Neuron[2][this.inputs.length-1];
    for(int j = 0; j < hiddenLayers[0].length; j++){
      hiddenLayers[0][j] = new Neuron(inputs);
      hiddenLayers[0][j].randomizeWeights();
    }
    for(int i = 1; i < hiddenLayers.length; i++){
      for(int j = 0; j<hiddenLayers[i].length; j++){
        hiddenLayers[i][j] = new Neuron(hiddenLayers[i-1]);
        hiddenLayers[i][j].randomizeWeights();
      }
    }
    
    outputs = new OutputNeuron[numOutputs];
    for(int j = 0; j<numOutputs; j++){
      outputs[j] = new OutputNeuron(hiddenLayers[hiddenLayers.length-1]);
      outputs[j].randomizeWeights();
    }
  }
  
  public double[] getOutputs(){
    double[] ret = new double[outputs.length];
    for(int i = 0; i < ret.length; i++){
      ret[i] = outputs[i].output();
    }
    return ret;
  }
}