cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv
label: nanomonsv
doc: "The provided text does not contain help information for nanomonsv; it contains
  container runtime error messages regarding a failure to build a SIF image due to
  insufficient disk space.\n\nTool homepage: https://github.com/friend1ws/nanomonsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
stdout: nanomonsv.out
