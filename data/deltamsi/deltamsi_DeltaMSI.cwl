cwlVersion: v1.2
class: CommandLineTool
baseCommand: DeltaMSI
label: deltamsi_DeltaMSI
doc: "DeltaMSI Copyright 2022 Koen Swaerts, AZ Delta This program comes with ABSOLUTELY
  NO WARRANTY; for details see the GPLv3 LICENCE This is free software, and you are
  welcome to redistribute it under certain conditions\n\nTool homepage: https://github.com/RADar-AZDelta/DeltaMSI"
inputs:
  - id: command
    type: string
    doc: The core command to execute
    inputBinding:
      position: 1
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: Evaluate the model with known data
    inputBinding:
      position: 102
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Predict one or multiple samples
    inputBinding:
      position: 102
  - id: train
    type:
      - 'null'
      - boolean
    doc: Train a new model
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
stdout: deltamsi_DeltaMSI.out
