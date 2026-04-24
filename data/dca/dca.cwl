cwlVersion: v1.2
class: CommandLineTool
baseCommand: dca
label: dca
doc: "Autoencoder\n\nTool homepage: https://github.com/theislab/dca"
inputs:
  - id: input
    type: File
    doc: Input is raw count data in TSV/CSV or H5AD (anndata) format. Row/col 
      names are mandatory. Note that TSV/CSV files must be in gene x cell layout
      where rows are genes and cols are cells (scRNA-seq convention).Use the 
      -t/--transpose option if your count matrix in cell x gene layout. H5AD 
      files must be in cell x gene format (stats and scanpy convention).
    inputBinding:
      position: 1
  - id: outputdir
    type: Directory
    doc: The path of the output directory
    inputBinding:
      position: 2
  - id: activation
    type:
      - 'null'
      - string
    doc: Activation function of hidden units
    inputBinding:
      position: 103
      prefix: --activation
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 103
      prefix: --batchsize
  - id: batchnorm
    type:
      - 'null'
      - boolean
    doc: Batchnorm
    inputBinding:
      position: 103
      prefix: --batchnorm
  - id: checkcounts
    type:
      - 'null'
      - boolean
    doc: Check if the expression matrix has raw (unnormalized) counts
    inputBinding:
      position: 103
      prefix: --checkcounts
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging. Checks whether every term in loss functions is 
      finite.
    inputBinding:
      position: 103
      prefix: --debug
  - id: denoisesubset
    type:
      - 'null'
      - File
    doc: Perform denoising only for the subset of genes in the given file. Gene 
      names should be line separated.
    inputBinding:
      position: 103
      prefix: --denoisesubset
  - id: dropout_rate
    type:
      - 'null'
      - float
    doc: Dropout rate
    inputBinding:
      position: 103
      prefix: --dropoutrate
  - id: earlystop
    type:
      - 'null'
      - int
    doc: Number of epochs to stop training if no improvement in loss occurs
    inputBinding:
      position: 103
      prefix: --earlystop
  - id: epochs
    type:
      - 'null'
      - int
    doc: Max number of epochs to continue training in case of no improvement on 
      validation loss
    inputBinding:
      position: 103
      prefix: --epochs
  - id: gradclip
    type:
      - 'null'
      - float
    doc: Clip grad values
    inputBinding:
      position: 103
      prefix: --gradclip
  - id: hidden_size
    type:
      - 'null'
      - string
    doc: Size of hidden layers
    inputBinding:
      position: 103
      prefix: --hiddensize
  - id: hyper
    type:
      - 'null'
      - boolean
    doc: Optimizer hyperparameters
    inputBinding:
      position: 103
      prefix: --hyper
  - id: hyperepoch
    type:
      - 'null'
      - int
    doc: Number of epochs used in each hyperpar optimization iteration.
    inputBinding:
      position: 103
      prefix: --hyperepoch
  - id: hypern
    type:
      - 'null'
      - int
    doc: Number of samples drawn from hyperparameter distributions during 
      optimization.
    inputBinding:
      position: 103
      prefix: --hypern
  - id: init
    type:
      - 'null'
      - string
    doc: Initialization method for weights
    inputBinding:
      position: 103
      prefix: --init
  - id: input_dropout
    type:
      - 'null'
      - float
    doc: Input layer dropout probability
    inputBinding:
      position: 103
      prefix: --inputdropout
  - id: l1
    type:
      - 'null'
      - float
    doc: L1 regularization coefficient
    inputBinding:
      position: 103
      prefix: --l1
  - id: l1enc
    type:
      - 'null'
      - float
    doc: Encoder-specific L1 regularization coefficient
    inputBinding:
      position: 103
      prefix: --l1enc
  - id: l2
    type:
      - 'null'
      - float
    doc: L2 regularization coefficient
    inputBinding:
      position: 103
      prefix: --l2
  - id: l2enc
    type:
      - 'null'
      - float
    doc: Encoder-specific L2 regularization coefficient
    inputBinding:
      position: 103
      prefix: --l2enc
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Learning rate
    inputBinding:
      position: 103
      prefix: --learningrate
  - id: loginput
    type:
      - 'null'
      - boolean
    doc: Log-transform input
    inputBinding:
      position: 103
      prefix: --loginput
  - id: no_saveweights
    type:
      - 'null'
      - boolean
    doc: Do not save weights
    inputBinding:
      position: 103
      prefix: --no-saveweights
  - id: nobatchnorm
    type:
      - 'null'
      - boolean
    doc: Do not use batchnorm
    inputBinding:
      position: 103
      prefix: --nobatchnorm
  - id: nocheckcounts
    type:
      - 'null'
      - boolean
    doc: Do not check if the expression matrix has raw (unnormalized) counts
    inputBinding:
      position: 103
      prefix: --nocheckcounts
  - id: nologinput
    type:
      - 'null'
      - boolean
    doc: Do not log-transform inputs
    inputBinding:
      position: 103
      prefix: --nologinput
  - id: nonorminput
    type:
      - 'null'
      - boolean
    doc: Do not zero-mean normalize inputs
    inputBinding:
      position: 103
      prefix: --nonorminput
  - id: norminput
    type:
      - 'null'
      - boolean
    doc: Zero-mean normalize input
    inputBinding:
      position: 103
      prefix: --norminput
  - id: normtype
    type:
      - 'null'
      - string
    doc: 'Type of size factor estimation. Possible values: deseq, zheng.'
    inputBinding:
      position: 103
      prefix: --normtype
  - id: nosizefactors
    type:
      - 'null'
      - boolean
    doc: Do not normalize means by library size
    inputBinding:
      position: 103
      prefix: --nosizefactors
  - id: optimizer
    type:
      - 'null'
      - string
    doc: Optimization method
    inputBinding:
      position: 103
      prefix: --optimizer
  - id: reducelr
    type:
      - 'null'
      - int
    doc: Number of epochs to reduce learning rate if no improvement in loss 
      occurs
    inputBinding:
      position: 103
      prefix: --reducelr
  - id: ridge
    type:
      - 'null'
      - float
    doc: L2 regularization coefficient for dropout probabilities
    inputBinding:
      position: 103
      prefix: --ridge
  - id: saveweights
    type:
      - 'null'
      - boolean
    doc: Save weights
    inputBinding:
      position: 103
      prefix: --saveweights
  - id: sizefactors
    type:
      - 'null'
      - boolean
    doc: Normalize means by library size
    inputBinding:
      position: 103
      prefix: --sizefactors
  - id: tensorboard
    type:
      - 'null'
      - boolean
    doc: Use tensorboard for saving weight distributions and visualization.
    inputBinding:
      position: 103
      prefix: --tensorboard
  - id: testsplit
    type:
      - 'null'
      - boolean
    doc: Use one fold as a test set
    inputBinding:
      position: 103
      prefix: --testsplit
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for training
    inputBinding:
      position: 103
      prefix: --threads
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose input matrix
    inputBinding:
      position: 103
      prefix: --transpose
  - id: type
    type:
      - 'null'
      - string
    doc: 'Type of autoencoder. Possible values: normal, poisson, nb, nb-shared, nb-conddisp
      (default), nb-fork, zinb, zinb-shared, zinb-conddisp( zinb-fork'
    inputBinding:
      position: 103
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dca:0.3.4--pyhdfd78af_0
stdout: dca.out
