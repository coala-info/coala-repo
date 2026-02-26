cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flexsweep
  - cnn
label: flexsweep_cnn
doc: "Run the Flexsweep CNN for training or prediction.\n\n  Depending on the inputs
  the software train, predict or train/predict.\n\nTool homepage: https://github.com/jmurga/flexsweep"
inputs:
  - id: model
    type:
      - 'null'
      - File
    doc: "Path to a pre-trained CNN model. If provided, the CNN\nwill only perform
      prediction."
    inputBinding:
      position: 101
      prefix: --model
  - id: output_folder
    type: Directory
    doc: "Directory to store the trained model, logs, and\npredictions."
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: predict_data
    type:
      - 'null'
      - File
    doc: "Path to feature vectors from empirical data for\nprediction."
    inputBinding:
      position: 101
      prefix: --predict_data
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Path to feature vectors from simulations for training\nthe CNN."
    inputBinding:
      position: 101
      prefix: --train_data
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
stdout: flexsweep_cnn.out
