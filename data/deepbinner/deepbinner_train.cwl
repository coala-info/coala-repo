cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner train
label: deepbinner_train
doc: "Train the neural network\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: aug
    type:
      - 'null'
      - float
    doc: Data augmentation factor (1 = no augmentation)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --aug
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Training batch size
    default: 20
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: batches_per_epoch
    type:
      - 'null'
      - int
    doc: The number of samples per epoch will be this times the batch size
    default: 5000
    inputBinding:
      position: 101
      prefix: --batches_per_epoch
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs
    default: 100
    inputBinding:
      position: 101
      prefix: --epochs
  - id: model_in
    type:
      - 'null'
      - File
    doc: An existing model to use as a starting point for training
    inputBinding:
      position: 101
      prefix: --model_in
  - id: train
    type: File
    doc: Balanced training data produced by the balance command
    inputBinding:
      position: 101
      prefix: --train
  - id: val
    type: File
    doc: Validation data used to assess the training
    inputBinding:
      position: 101
      prefix: --val
outputs:
  - id: model_out
    type: File
    doc: Filename for the trained model
    outputBinding:
      glob: $(inputs.model_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
