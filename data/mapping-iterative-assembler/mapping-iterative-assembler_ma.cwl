cwlVersion: v1.2
class: CommandLineTool
baseCommand: ma
label: mapping-iterative-assembler_ma
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/mpieva/mapping-iterative-assembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapping-iterative-assembler:1.0--h503566f_7
stdout: mapping-iterative-assembler_ma.out
