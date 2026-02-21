cwlVersion: v1.2
class: CommandLineTool
baseCommand: IntaRNAhelix
label: intarna_IntaRNAhelix
doc: "The provided text does not contain help information or usage instructions. It
  contains a system error message regarding a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNAhelix.out
