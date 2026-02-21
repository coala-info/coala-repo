cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3_core
label: primer3_primer3_core
doc: "Primer3 is a widely used program for designing PCR primers (Note: The provided
  text contains container runtime error messages rather than the tool's help documentation).\n
  \nTool homepage: https://github.com/primer3-org/primer3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3:2.6.1--pl5321h503566f_7
stdout: primer3_primer3_core.out
