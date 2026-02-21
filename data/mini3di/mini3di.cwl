cwlVersion: v1.2
class: CommandLineTool
baseCommand: mini3di
label: mini3di
doc: "The provided text does not contain help information or a description of the
  tool; it is a container runtime error log indicating a failure to build the SIF
  image due to insufficient disk space.\n\nTool homepage: https://github.com/althonos/mini3di"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mini3di:0.2.1--pyh7e72e81_0
stdout: mini3di.out
