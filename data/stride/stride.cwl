cwlVersion: v1.2
class: CommandLineTool
baseCommand: stride
label: stride
doc: "The provided text does not contain help information for the tool 'stride'; it
  is a log of a failed container build process. No arguments or descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/stride3d/stride"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stride:1.0--1
stdout: stride.out
