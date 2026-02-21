cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacherchant
label: metacherchant
doc: "Metacherchant is a tool for analyzing genomic environments of antibiotic resistance
  genes; however, the provided text contains only system error messages and no help
  documentation to extract arguments.\n\nTool homepage: https://github.com/ctlab/metacherchant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant.out
