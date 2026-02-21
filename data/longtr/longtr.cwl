cwlVersion: v1.2
class: CommandLineTool
baseCommand: longtr
label: longtr
doc: "The provided text does not contain help information or a description of the
  tool; it is a container runtime error log indicating a failure to build the SIF
  format due to insufficient disk space.\n\nTool homepage: https://github.com/gymrek-lab/LongTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longtr:1.2--h077b44d_1
stdout: longtr.out
