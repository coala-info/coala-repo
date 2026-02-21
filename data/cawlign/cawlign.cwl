cwlVersion: v1.2
class: CommandLineTool
baseCommand: cawlign
label: cawlign
doc: "Codon-aware aligner (Note: The provided text is a container execution error
  log and does not contain help documentation).\n\nTool homepage: https://github.com/veg/cawlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cawlign:0.1.16--he91c24d_0
stdout: cawlign.out
