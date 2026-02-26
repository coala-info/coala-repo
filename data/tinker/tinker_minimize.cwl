cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinker_minimize
label: tinker_minimize
doc: "Software Tools for Molecular Design\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: input_file
    type: File
    doc: Cartesian Coordinate File Name
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_minimize.out
