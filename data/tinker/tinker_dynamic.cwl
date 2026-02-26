cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinker_dynamic
label: tinker_dynamic
doc: "Software Tools for Molecular Design\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: cartesian_coordinate_file
    type: File
    doc: Enter Cartesian Coordinate File Name
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_dynamic.out
