cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepMedicRun
label: deepmedic
doc: "DeepMedic: A 3D multi-scale convolutional neural network framework for medical
  image segmentation.\n\nTool homepage: https://github.com/Kamnitsask/deepmedic"
inputs:
  - id: device
    type:
      - 'null'
      - string
    doc: The device to run on (e.g., 'cpu', 'gpu', 'gpu0').
    default: cpu
    inputBinding:
      position: 101
      prefix: -dev
  - id: load_saved_model
    type:
      - 'null'
      - File
    doc: Path to a saved model to load for training or testing.
    inputBinding:
      position: 101
      prefix: -load
  - id: model_config
    type:
      - 'null'
      - File
    doc: Path to the model configuration file.
    inputBinding:
      position: 101
      prefix: -model
  - id: reset_optimizer
    type:
      - 'null'
      - boolean
    doc: Reset the optimizer's state when loading a model.
    inputBinding:
      position: 101
      prefix: -reset_opt
  - id: test_config
    type:
      - 'null'
      - File
    doc: Path to the testing/inference configuration file.
    inputBinding:
      position: 101
      prefix: -test
  - id: train_config
    type:
      - 'null'
      - File
    doc: Path to the training configuration file.
    inputBinding:
      position: 101
      prefix: -train
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmedic:0.6.1--py27h24bf2e0_0
stdout: deepmedic.out
