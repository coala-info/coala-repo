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
    doc: 'Device to run the process on: cpu or cuda (default = cpu); a particular
      GPU as cuda2.'
    inputBinding:
      position: 101
      prefix: -dev
  - id: saved_model
    type:
      - 'null'
      - File
    doc: The path to a saved existing cnn model, to train or test with. Not in 
      combination with -newModel.
    inputBinding:
      position: 101
      prefix: -model
  - id: model_config
    type:
      - 'null'
      - File
    doc: Create a new CNN model with model parameters at given config file.
    inputBinding:
      position: 101
      prefix: -newModel
  - id: pretrained_model
    type:
      - 'null'
      - File
    doc: Transfer the weights from a previously trained model to a new model 
      (must follow -newModel).
    inputBinding:
      position: 101
      prefix: -pretrained
  - id: layers_to_transfer
    type:
      - 'null'
      - type: array
        items: int
    doc: Layers of the new model to which the pretrained parameters are 
      transferred (use after -pretrained). First layer is 1.
    inputBinding:
      position: 101
      prefix: -layers
  - id: reset_optimizer
    type:
      - 'null'
      - boolean
    doc: Reset the model's optimization state before starting the training 
      session (use with -train).
    inputBinding:
      position: 101
      prefix: -resetOptimizer
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
