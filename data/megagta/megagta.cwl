cwlVersion: v1.2
class: CommandLineTool
baseCommand: megagta
label: megagta
doc: "MegaGTA (Gene-Targeted Assembler) is a tool for de novo assembly of gene-targeted
  sequences from metagenomic data. (Note: The provided text contains only system error
  messages and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta.out
