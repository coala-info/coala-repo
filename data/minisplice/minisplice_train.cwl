cwlVersion: v1.2
class: CommandLineTool
baseCommand: minisplice_train
label: minisplice_train
doc: "Train a model for minisplice\n\nTool homepage: https://github.com/lh3/minisplice"
inputs:
  - id: input_data
    type: File
    doc: Input data file
    inputBinding:
      position: 1
  - id: dense_layer_neurons
    type:
      - 'null'
      - int
    doc: number of neurons in the dense layer
    default: 16
    inputBinding:
      position: 102
      prefix: -F
  - id: dropout_rate
    type:
      - 'null'
      - float
    doc: dropout rate (use for large models)
    default: 0.0
    inputBinding:
      position: 102
      prefix: -d
  - id: features_per_layer
    type:
      - 'null'
      - int
    doc: number of features per 1D-CNN layer
    default: 16
    inputBinding:
      position: 102
      prefix: -f
  - id: input_model
    type:
      - 'null'
      - File
    doc: input model
    default: ''
    inputBinding:
      position: 102
      prefix: -i
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: 1D-CNN kernel size
    default: 5
    inputBinding:
      position: 102
      prefix: -k
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: learning rate
    default: 0.001
    inputBinding:
      position: 102
      prefix: -r
  - id: max_epochs
    type:
      - 'null'
      - int
    doc: max number of epoches
    default: 100
    inputBinding:
      position: 102
      prefix: -E
  - id: min_epochs
    type:
      - 'null'
      - int
    doc: min number of epoches
    default: 3
    inputBinding:
      position: 102
      prefix: -e
  - id: minibatch_size
    type:
      - 'null'
      - int
    doc: minibatch size
    default: 64
    inputBinding:
      position: 102
      prefix: -m
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed
    default: 11
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_model
    type:
      - 'null'
      - File
    doc: output model
    outputBinding:
      glob: $(inputs.output_model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
