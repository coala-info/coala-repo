cwlVersion: v1.2
class: CommandLineTool
baseCommand: dastk
label: dastk
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk.out
