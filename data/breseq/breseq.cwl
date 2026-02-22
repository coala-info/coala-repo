cwlVersion: v1.2
class: CommandLineTool
baseCommand: breseq
label: breseq
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/barricklab/breseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breseq:0.39.0--h077b44d_3
stdout: breseq.out
