cwlVersion: v1.2
class: CommandLineTool
baseCommand: stride
label: stride_Stride.GameStudio
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/stride3d/stride"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stride:1.0--1
stdout: stride_Stride.GameStudio.out
