cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia
label: mapping-iterative-assembler_mia
doc: "Mapping Iterative Assembler (MIA) for ancient DNA assembly. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/mpieva/mapping-iterative-assembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapping-iterative-assembler:1.0--h503566f_7
stdout: mapping-iterative-assembler_mia.out
