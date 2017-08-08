class NeuralNetwork {
  private Organism belongedOrganism;
  private Neuron[][] hiddenLayers;
  private Neuron[] outputs;
  private InputNeuron[] inputs;
  
  public NeuralNetwork(Organism organism){
    belongedOrganism = organism;
  }
  
  public void createNetwork(int numOutputs, InputNeuron... inputs){
    this.inputs = inputs;
    hiddenLayers = new Neuron[2][this.inputs.length-1];
    for(int j = 0; j < hiddenLayers[0].length; j++){
      hiddenLayers[0][j] = new Neuron();
      hiddenLayers[0][j].randomizeWeights();
    }
    for(int i = 1; i < hiddenLayers.length; i++){
      for(int j = 0; j<hiddenLayers[i].length; j++){
        hiddenLayers[i][j] = new Neuron(hiddenLayers[i-1]);
        hiddenLayers[i][j].randomizeWeights();
      }
    }
    
    outputs = new Neuron[numOutputs];
    for(int j = 0; j<numOutputs; j++){
      outputs[j] = new Neuron(hiddenLayers[hiddenLayers.length-1]);
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