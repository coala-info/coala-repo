cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scaden
  - train
label: scaden_train
doc: "Train a Scaden model\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs:
  - id: training_data
    type: File
    doc: training data (processed .h5ad file from scaden process)
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size to use for training.
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Learning rate used for training.
    inputBinding:
      position: 102
      prefix: --learning_rate
  - id: model_dir
    type:
      - 'null'
      - string
    doc: Path to store the model in
    inputBinding:
      position: 102
      prefix: --model_dir
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: steps
    type:
      - 'null'
      - int
    doc: Number of training steps
    inputBinding:
      position: 102
      prefix: --steps
  - id: train_datasets
    type:
      - 'null'
      - string
    doc: Comma-separated list of datasets used for training. Uses all by 
      default.
    inputBinding:
      position: 102
      prefix: --train_datasets
outputs:
  - id: model
    type: Directory
    doc: Directory with the trained models (m256, m512, m1024)
    outputBinding:
      glob: $(inputs.model_dir || '.')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.model_dir ? {class: 'Directory', basename: inputs.model_dir, listing: []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
