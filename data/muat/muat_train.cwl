cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat train
label: muat_train
doc: "Train a model\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: command
    type: string
    doc: Available commands.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat_train.out
