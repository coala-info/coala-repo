cwlVersion: v1.2
class: CommandLineTool
baseCommand: macrel
label: macrel
doc: "Macrel is a tool for the prediction and discovery of antimicrobial peptides
  (AMPs). Note: The provided text is an error log and does not contain command-line
  argument definitions.\n\nTool homepage: https://github.com/BigDataBiology/macrel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
stdout: macrel.out
