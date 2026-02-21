cwlVersion: v1.2
class: CommandLineTool
baseCommand: dipcall
label: dipcall
doc: "The provided text does not contain help information for dipcall; it contains
  container runtime error messages regarding a failure to build the SIF format due
  to insufficient disk space.\n\nTool homepage: https://github.com/lh3/dipcall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipcall:0.3--hdfd78af_0
stdout: dipcall.out
