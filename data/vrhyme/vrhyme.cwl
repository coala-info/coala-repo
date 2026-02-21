cwlVersion: v1.2
class: CommandLineTool
baseCommand: vrhyme
label: vrhyme
doc: "The provided text does not contain help information or a description of the
  tool; it is a container runtime error log.\n\nTool homepage: https://github.com/AnantharamanLab/vRhyme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vrhyme:1.1.0--pyhdfd78af_1
stdout: vrhyme.out
