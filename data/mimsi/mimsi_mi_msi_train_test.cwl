cwlVersion: v1.2
class: CommandLineTool
baseCommand: mi_msi_train_test
label: mimsi_mi_msi_train_test
doc: "MiMSI - A Multiple Instance Learning Model for detecting microsatellite instability\
  \ in NGS data. Trains a model on vectors made by create_data and tests it.\n\nTool\
  \ homepage: https://github.com/mskcc/mimsi"
inputs:
  - id: train_location
    type: Directory
    doc: Directory Location for Training Data
    inputBinding:
      position: 101
      prefix: --train-location
  - id: test_location
    type: Directory
    doc: Directory Location for Testing Data
    inputBinding:
      position: 101
      prefix: --test-location
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of epochs to train (default 40)
    inputBinding:
      position: 101
      prefix: --epochs
  - id: lr
    type:
      - 'null'
      - float
    doc: Learning rate used in training (default 0.0001)
    inputBinding:
      position: 101
      prefix: --lr
  - id: reg
    type:
      - 'null'
      - float
    doc: Weight decay used in training (default 5e-4)
    inputBinding:
      position: 101
      prefix: --reg
  - id: seed
    type:
      - 'null'
      - int
    doc: Random Seed (default 2)
    inputBinding:
      position: 101
      prefix: --seed
  - id: no_cuda
    type:
      - 'null'
      - boolean
    doc: Disables CUDA training for use off GPU
    inputBinding:
      position: 101
      prefix: --no-cuda
  - id: name
    type: string
    default: mi_msi_1
    doc: Name of the model; output files are written as <name>_*.npy and <name>.model
    inputBinding:
      position: 101
      prefix: --name
  - id: save
    type:
      - 'null'
      - string
    doc: Save the model weights to disk after training (any non-empty value turns
      saving on)
    inputBinding:
      position: 101
      prefix: --save
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: model_files
    type:
      type: array
      items: File
    doc: Saved model weights and training/test statistics (written when save is given)
    outputBinding:
      glob: $(inputs.name)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_mi_msi_train_test.out
