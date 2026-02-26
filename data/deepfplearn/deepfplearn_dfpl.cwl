cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepFPlearn
label: deepfplearn_dfpl
doc: "Sub programs of deepFPlearn\n\nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: subcommand
    type: string
    doc: Sub programs of deepFPlearn
    inputBinding:
      position: 1
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Convert known data files to pickle serialization files
    inputBinding:
      position: 102
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Predict your data with existing models
    inputBinding:
      position: 102
  - id: predictgnn
    type:
      - 'null'
      - boolean
    doc: Predict with your GNN models
    inputBinding:
      position: 102
  - id: train
    type:
      - 'null'
      - boolean
    doc: Train new models with your data
    inputBinding:
      position: 102
  - id: traingnn
    type:
      - 'null'
      - boolean
    doc: Train new GNN models with your data
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_dfpl.out
