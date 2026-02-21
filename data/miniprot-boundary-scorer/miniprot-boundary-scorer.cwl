cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniprot-boundary-scorer
label: miniprot-boundary-scorer
doc: "The provided text does not contain help information or usage instructions. It
  contains container runtime error messages indicating a failure to build the SIF
  image due to lack of disk space.\n\nTool homepage: https://github.com/tomasbruna/miniprot-boundary-scorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot-boundary-scorer:1.0.1--h9948957_0
stdout: miniprot-boundary-scorer.out
