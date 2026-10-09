cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_autoencode
doc: "Build and train an autoencoder.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX autoencode show`.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging (global lyner option -v, written to standard error)"
    inputBinding:
      position: 0
      prefix: -v
  - id: matrix
    type: File
    doc: "Abundance or count matrix in tsv format (first column: feature names; other columns: samples), read with `lyner read`"
    inputBinding:
      position: 2
  - id: layer_config
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --layer-config
    doc: "Layer definition as key=value pairs separated by commas, for example type=Dense,n=4,activation=relu. Repeat for several layers"
    inputBinding:
      position: 20
  - id: from_file
    type:
      - 'null'
      - File
    doc: "Load the model from a yaml or json file"
    inputBinding:
      position: 20
      prefix: --from-file
  - id: store_model
    type:
      - 'null'
      - string
    doc: "Store the model in this file (yaml or json)"
    inputBinding:
      position: 20
      prefix: --store-model
  - id: loss
    type:
      - 'null'
      - string
    doc: "Loss function, for example mse, mae or kld (default mse)"
    inputBinding:
      position: 20
      prefix: --loss
  - id: optimiser
    type:
      - 'null'
      - string
    doc: "Optimiser: adadelta, adagrad, adam, adamax, nadam, rmsprop or sgd (default adam)"
    inputBinding:
      position: 20
      prefix: --optimiser
  - id: epochs
    type:
      - 'null'
      - int
    doc: "Number of epochs (default 500)"
    inputBinding:
      position: 20
      prefix: --epochs
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size (default 5)"
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: shuffle
    type:
      - 'null'
      - string
    doc: "Shuffle the training data: True or False (default True)"
    inputBinding:
      position: 20
      prefix: --shuffle
  - id: validation_split
    type:
      - 'null'
      - float
    doc: "Fraction of the data used for validation, 0 to 1 (default 0.1)"
    inputBinding:
      position: 20
      prefix: --validation-split
  - id: adjust_weights
    type:
      - 'null'
      - float
    doc: "Keep only weights below this quantile or above 1 minus this quantile"
    inputBinding:
      position: 20
      prefix: --adjust-weights
  - id: mode
    type:
      - 'null'
      - string
    doc: "Output: discard, nodes or weights (default nodes)"
    inputBinding:
      position: 20
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: "Training messages, reconstruction errors and the resulting matrix"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: autoencode
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_autoencode.out
