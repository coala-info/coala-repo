cwlVersion: v1.2
class: CommandLineTool
baseCommand: examine
label: examine
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime environment failure
  (no space left on device).\n\nTool homepage: https://github.com/AlBi-HHU/eXamine-stand-alone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/examine:1.0.1--hdfd78af_0
stdout: examine.out
