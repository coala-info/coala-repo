cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy
label: lumpy-sv
doc: "Lumpy: a general probabilistic framework for structural variant discovery. (Note:
  The provided help text contains only container runtime error messages and no usage
  information.)\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
stdout: lumpy-sv.out
