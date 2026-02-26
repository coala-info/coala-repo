cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac train
label: deepac_train
doc: "Train a deep learning model for DNA classification.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: custom
    type:
      - 'null'
      - File
    doc: Use the user-supplied configuration file.
    inputBinding:
      position: 101
      prefix: --custom
  - id: gpus
    type:
      - 'null'
      - type: array
        items: string
    doc: GPU devices to use (comma-separated).
    default: all
    inputBinding:
      position: 101
      prefix: --gpus
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: Number of CPU cores.
    default: all
    inputBinding:
      position: 101
      prefix: --n-cpus
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Use the rapid CNN model.
    inputBinding:
      position: 101
      prefix: --rapid
  - id: run_name
    type:
      - 'null'
      - string
    doc: Run name
    default: based on chosen config
    inputBinding:
      position: 101
      prefix: --run-name
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Use the sensitive model.
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: train_data
    type:
      - 'null'
      - Directory
    doc: Path to training data.
    inputBinding:
      position: 101
      prefix: --train-data
  - id: train_labels
    type:
      - 'null'
      - File
    doc: Path to training labels.
    inputBinding:
      position: 101
      prefix: --train-labels
  - id: val_data
    type:
      - 'null'
      - Directory
    doc: Path to validation data.
    inputBinding:
      position: 101
      prefix: --val-data
  - id: val_labels
    type:
      - 'null'
      - File
    doc: Path to validation labels.
    inputBinding:
      position: 101
      prefix: --val-labels
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_train.out
