cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - train
label: deepac_train
doc: "Train a deep learning model for DNA classification.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: custom
    type:
      - 'null'
      - File
    loadContents: true
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
    inputBinding:
      position: 101
      prefix: --gpus
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: Number of CPU cores.
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
      - File
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
      - File
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
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files named in the config file; staged in the working directory 
      so the relative names in the config resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: logs
    type: Directory
    doc: Training logs and saved models (LogPath of the config file, default 
      logs)
    outputBinding:
      glob: |-
        ${
          if (inputs.custom) {
            var m = inputs.custom.contents.match(/^\s*LogPath\s*=\s*(\S+)/m);
            if (m) { return m[1]; }
          }
          return "logs";
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_train.out
