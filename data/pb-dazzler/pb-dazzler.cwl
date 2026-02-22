cwlVersion: v1.2
class: CommandLineTool
baseCommand: pb-dazzler
label: pb-dazzler
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a Singularity/Docker container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/PacificBiosciences"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-dazzler:0.0.1--h7b50bb2_5
stdout: pb-dazzler.out
