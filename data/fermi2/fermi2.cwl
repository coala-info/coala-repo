cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2
label: fermi2
doc: "Fermi2 is a de novo assembler for short reads (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/lh3/fermi2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2.out
