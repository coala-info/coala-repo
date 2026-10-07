cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dfpl
  - train
label: deepfplearn_train
doc: "Train new models with your data (deepFPlearn feed-forward networks and autoencoders\
  \ on molecular fingerprints).\n\nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: configFile
    type:
      - 'null'
      - File
    doc: Input JSON file that contains all information for training/predicting.
    inputBinding:
      position: 1
      prefix: --configFile
  - id: inputFile
    type:
      - 'null'
      - File
    doc: The file containing the data for training in comma separated CSV format.The first
      column should be smiles.
    inputBinding:
      position: 1
      prefix: --inputFile
  - id: outputDir
    type:
      - 'null'
      - string
    doc: Prefix of output file name. Trained model and respective stats will be returned in
      this directory.
    default: dfpl_train
    inputBinding:
      position: 1
      prefix: --outputDir
  - id: type
    type:
      - 'null'
      - string
    doc: 'Type of the chemical representation. Choices: ''fp'', ''smiles''.'
    inputBinding:
      position: 1
      prefix: --type
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for binary classification.
    inputBinding:
      position: 1
      prefix: --threshold
  - id: gpu
    type:
      - 'null'
      - int
    doc: Select which gpu to use. If not available, leave empty.
    inputBinding:
      position: 1
      prefix: --gpu
  - id: fpType
    type:
      - 'null'
      - string
    doc: The type of fingerprint to be generated/used in input file.
    inputBinding:
      position: 1
      prefix: --fpType
  - id: fpSize
    type:
      - 'null'
      - int
    doc: Size of fingerprint that should be generated.
    inputBinding:
      position: 1
      prefix: --fpSize
  - id: compressFeatures
    type:
      - 'null'
      - boolean
    doc: Should the fingerprints be compressed or not. Activates the autoencoder. (passed
      as True or an empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --compressFeatures
      valueFrom: '$(self ? "True" : "")'
  - id: visualizeLatent
    type:
      - 'null'
      - boolean
    doc: Visualize the latent space of the autoencoder. (passed as True or an empty value,
      which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --visualizeLatent
      valueFrom: '$(self ? "True" : "")'
  - id: enableMultiLabel
    type:
      - 'null'
      - boolean
    doc: Train multi-label classification model in addition to the individual models. (passed
      as True or an empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --enableMultiLabel
      valueFrom: '$(self ? "True" : "")'
  - id: ecWeightsFile
    type:
      - 'null'
      - File
    doc: The .hdf5 file of a trained encoder
    inputBinding:
      position: 1
      prefix: --ecWeightsFile
  - id: ecModelDir
    type:
      - 'null'
      - string
    doc: The directory where the full model of the encoder will be saved
    inputBinding:
      position: 1
      prefix: --ecModelDir
  - id: aeType
    type:
      - 'null'
      - string
    doc: Autoencoder type, variational or deterministic.
    inputBinding:
      position: 1
      prefix: --aeType
  - id: aeEpochs
    type:
      - 'null'
      - int
    doc: Number of epochs for autoencoder training.
    inputBinding:
      position: 1
      prefix: --aeEpochs
  - id: aeBatchSize
    type:
      - 'null'
      - int
    doc: Batch size in autoencoder training.
    inputBinding:
      position: 1
      prefix: --aeBatchSize
  - id: aeActivationFunction
    type:
      - 'null'
      - string
    doc: The activation function for the hidden layers in the autoencoder.
    inputBinding:
      position: 1
      prefix: --aeActivationFunction
  - id: aeLearningRate
    type:
      - 'null'
      - float
    doc: Learning rate for autoencoder training.
    inputBinding:
      position: 1
      prefix: --aeLearningRate
  - id: aeLearningRateDecay
    type:
      - 'null'
      - float
    doc: Learning rate decay for autoencoder training.
    inputBinding:
      position: 1
      prefix: --aeLearningRateDecay
  - id: aeSplitType
    type:
      - 'null'
      - string
    doc: Set how the data is going to be split for the autoencoder
    inputBinding:
      position: 1
      prefix: --aeSplitType
  - id: encFPSize
    type:
      - 'null'
      - int
    doc: Size of encoded fingerprint (z-layer of autoencoder).
    inputBinding:
      position: 1
      prefix: --encFPSize
  - id: split_type
    type:
      - 'null'
      - string
    doc: Set how the data is going to be split for the feedforward neural network
    inputBinding:
      position: 1
      prefix: --split_type
  - id: testSize
    type:
      - 'null'
      - float
    doc: Fraction of the dataset that should be used for testing. Value in [0,1].
    inputBinding:
      position: 1
      prefix: --testSize
  - id: kFolds
    type:
      - 'null'
      - int
    doc: K that is used for K-fold cross-validation in the training procedure.
    inputBinding:
      position: 1
      prefix: --kFolds
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbosity level. O: No additional output, 1: Some additional output, 2: full additional
      output'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: trainAC
    type:
      - 'null'
      - boolean
    doc: Choose to train or not, the autoencoder based on the input file (passed as True or
      an empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --trainAC
      valueFrom: '$(self ? "True" : "")'
  - id: trainFNN
    type:
      - 'null'
      - boolean
    doc: Train the feedforward network either with provided weights. (passed as True or an
      empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --trainFNN
      valueFrom: '$(self ? "True" : "")'
  - id: sampleFractionOnes
    type:
      - 'null'
      - float
    doc: This is the fraction of positive target associations (1s) in comparison to the majority
      class(0s).only works if --sampleDown is enabled
    inputBinding:
      position: 1
      prefix: --sampleFractionOnes
  - id: sampleDown
    type:
      - 'null'
      - boolean
    doc: Enable automatic down sampling of the 0 valued samples. (passed as True or an empty
      value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --sampleDown
      valueFrom: '$(self ? "True" : "")'
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of epochs that should be used for the FNN training
    inputBinding:
      position: 1
      prefix: --epochs
  - id: lossFunction
    type:
      - 'null'
      - string
    doc: Loss function to use during training. mse - mean squared error, bce - binary cross
      entropy.
    inputBinding:
      position: 1
      prefix: --lossFunction
  - id: optimizer
    type:
      - 'null'
      - string
    doc: 'Optimizer to use for backpropagation in the FNN. Possible values: "Adam", "SGD"'
    inputBinding:
      position: 1
      prefix: --optimizer
  - id: batchSize
    type:
      - 'null'
      - int
    doc: Batch size in FNN training.
    inputBinding:
      position: 1
      prefix: --batchSize
  - id: l2reg
    type:
      - 'null'
      - float
    doc: Value for l2 kernel regularizer.
    inputBinding:
      position: 1
      prefix: --l2reg
  - id: dropout
    type:
      - 'null'
      - float
    doc: The fraction of data that is dropped out in each dropout layer.
    inputBinding:
      position: 1
      prefix: --dropout
  - id: learningRate
    type:
      - 'null'
      - float
    doc: Learning rate size in FNN training.
    inputBinding:
      position: 1
      prefix: --learningRate
  - id: learningRateDecay
    type:
      - 'null'
      - float
    doc: Learning rate decay in FNN training.
    inputBinding:
      position: 1
      prefix: --learningRateDecay
  - id: activationFunction
    type:
      - 'null'
      - string
    doc: The activation function for hidden layers in the FNN.
    inputBinding:
      position: 1
      prefix: --activationFunction
  - id: aeWabTracking
    type:
      - 'null'
      - boolean
    doc: Track autoencoder performance via Weights & Biases, see https://wandb.ai. (passed
      as True or an empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --aeWabTracking
      valueFrom: '$(self ? "True" : "")'
  - id: wabTracking
    type:
      - 'null'
      - boolean
    doc: Track FNN performance via Weights & Biases, see https://wandb.ai. (passed as True
      or an empty value, which the tool reads as false)
    inputBinding:
      position: 1
      prefix: --wabTracking
      valueFrom: '$(self ? "True" : "")'
  - id: wabTarget
    type:
      - 'null'
      - string
    doc: Which target to use for tracking performance via Weights & Biases, see https://wandb.ai.
    inputBinding:
      position: 1
      prefix: --wabTarget
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Trained models, statistics and train.log
    outputBinding:
      glob: $(inputs.outputDir)
  - id: encoder_dir
    type:
      - 'null'
      - Directory
    doc: Saved encoder model (when an autoencoder is trained)
    outputBinding:
      glob: $(inputs.ecModelDir)
  - id: latent_plots
    type:
      type: array
      items: File
    doc: UMAP plots of the latent space (--visualizeLatent)
    outputBinding:
      glob: UMAP_*.png
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_train.out
