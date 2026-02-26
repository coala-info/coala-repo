cwlVersion: v1.2
class: CommandLineTool
baseCommand: happy-python_happy
label: happy-python_happy
doc: "Estimate assembly haploidy based on base depth of coverage histogram.\n\nTool
  homepage: https://github.com/AntoineHo/HapPy"
inputs:
  - id: command
    type: string
    doc: The subcommand to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
stdout: happy-python_happy.out
