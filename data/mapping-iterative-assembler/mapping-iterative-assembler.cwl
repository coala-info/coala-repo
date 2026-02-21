cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapping-iterative-assembler
label: mapping-iterative-assembler
doc: "Mapping Iterative Assembler (MIA)\n\nTool homepage: https://github.com/mpieva/mapping-iterative-assembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapping-iterative-assembler:1.0--h503566f_7
stdout: mapping-iterative-assembler.out
