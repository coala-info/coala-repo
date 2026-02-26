cwlVersion: v1.2
class: CommandLineTool
baseCommand: DM.py
label: deepmicro_DM.py
doc: "DeepMicro: A deep learning framework for microbiome analysis.\n\nTool homepage:
  https://github.com/paulzierep/DeepMicro"
inputs:
  - id: act
    type:
      - 'null'
      - string
    doc: activation function for hidden layers
    inputBinding:
      position: 101
      prefix: --act
  - id: ae
    type:
      - 'null'
      - boolean
    doc: run Autoencoder or Deep Autoencoder
    inputBinding:
      position: 101
      prefix: --ae
  - id: ae_lact
    type:
      - 'null'
      - boolean
    doc: latent layer activation function on/off
    inputBinding:
      position: 101
      prefix: --ae_lact
  - id: ae_oact
    type:
      - 'null'
      - boolean
    doc: output layer sigmoid activation function on/off
    inputBinding:
      position: 101
      prefix: --ae_oact
  - id: aeloss
    type:
      - 'null'
      - string
    doc: set autoencoder reconstruction loss function
    inputBinding:
      position: 101
      prefix: --aeloss
  - id: cae
    type:
      - 'null'
      - boolean
    doc: run Convolutional Autoencoder
    inputBinding:
      position: 101
      prefix: --cae
  - id: custom_data
    type:
      - 'null'
      - File
    doc: filename for custom input data under the 'data' folder
    inputBinding:
      position: 101
      prefix: --custom_data
  - id: custom_data_labels
    type:
      - 'null'
      - File
    doc: filename for custom input labels under the 'data' folder
    inputBinding:
      position: 101
      prefix: --custom_data_labels
  - id: data
    type:
      - 'null'
      - string
    doc: prefix of dataset to open (e.g. abundance_Cirrhosis)
    inputBinding:
      position: 101
      prefix: --data
  - id: dataType
    type:
      - 'null'
      - string
    doc: Specify data type for numerical values (float16, float32, float64)
    inputBinding:
      position: 101
      prefix: --dataType
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: custom path for both '/data' and '/results' folders
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: dims
    type:
      - 'null'
      - string
    doc: Comma-separated dimensions for deep representation learning e.g. (-dm 
      50,30,20)
    inputBinding:
      position: 101
      prefix: --dims
  - id: load_rep
    type:
      - 'null'
      - File
    doc: load the learned representation of the training set as a file
    inputBinding:
      position: 101
      prefix: --load_rep
  - id: max_epochs
    type:
      - 'null'
      - int
    doc: Maximum epochs when training autoencoder
    inputBinding:
      position: 101
      prefix: --max_epochs
  - id: method
    type:
      - 'null'
      - string
    doc: classifier(s) to use
    inputBinding:
      position: 101
      prefix: --method
  - id: no_clf
    type:
      - 'null'
      - boolean
    doc: skip classification tasks
    inputBinding:
      position: 101
      prefix: --no_clf
  - id: no_trn
    type:
      - 'null'
      - boolean
    doc: stop before learning representation to see specified autoencoder 
      structure
    inputBinding:
      position: 101
      prefix: --no_trn
  - id: numFolds
    type:
      - 'null'
      - int
    doc: The number of folds for cross-validation in the tranining set
    inputBinding:
      position: 101
      prefix: --numFolds
  - id: numJobs
    type:
      - 'null'
      - int
    doc: 'The number of jobs used in parallel GridSearch. (-1: utilize all possible
      cores; -2: utilize all possible cores except one.)'
    inputBinding:
      position: 101
      prefix: --numJobs
  - id: patience
    type:
      - 'null'
      - int
    doc: The number of epochs which can be executed without the improvement in 
      validation loss, right after the last improvement.
    inputBinding:
      position: 101
      prefix: --patience
  - id: pca
    type:
      - 'null'
      - boolean
    doc: run PCA
    inputBinding:
      position: 101
      prefix: --pca
  - id: repeat
    type:
      - 'null'
      - int
    doc: repeat experiment x times by changing random seed for splitting data
    inputBinding:
      position: 101
      prefix: --repeat
  - id: rf_rate
    type:
      - 'null'
      - float
    doc: What percentage of input size will be the receptive field (kernel) 
      size? [0,1]
    inputBinding:
      position: 101
      prefix: --rf_rate
  - id: rp
    type:
      - 'null'
      - boolean
    doc: run Random Projection
    inputBinding:
      position: 101
      prefix: --rp
  - id: save_rep
    type:
      - 'null'
      - boolean
    doc: write the learned representation of the training set as a file
    inputBinding:
      position: 101
      prefix: --save_rep
  - id: scoring
    type:
      - 'null'
      - string
    doc: scoring metric for classification
    inputBinding:
      position: 101
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for train and test split
    inputBinding:
      position: 101
      prefix: --seed
  - id: st_rate
    type:
      - 'null'
      - float
    doc: What percentage of receptive field (kernel) size will be the stride 
      size? [0,1]
    inputBinding:
      position: 101
      prefix: --st_rate
  - id: svm_cache
    type:
      - 'null'
      - int
    doc: cache size for svm run
    inputBinding:
      position: 101
      prefix: --svm_cache
  - id: vae
    type:
      - 'null'
      - boolean
    doc: run Variational Autoencoder
    inputBinding:
      position: 101
      prefix: --vae
  - id: vae_beta
    type:
      - 'null'
      - float
    doc: weight of KL term
    inputBinding:
      position: 101
      prefix: --vae_beta
  - id: vae_warmup
    type:
      - 'null'
      - boolean
    doc: turn on warm up
    inputBinding:
      position: 101
      prefix: --vae_warmup
  - id: vae_warmup_rate
    type:
      - 'null'
      - float
    doc: warm-up rate which will be multiplied by current epoch to calculate 
      current beta
    inputBinding:
      position: 101
      prefix: --vae_warmup_rate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicro:1.4--pyhdfd78af_1
stdout: deepmicro_DM.py.out
