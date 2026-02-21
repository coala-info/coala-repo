cwlVersion: v1.2
class: CommandLineTool
baseCommand: genepender
label: genepender
doc: "A tool for genomic data analysis and gene name standardization. (Note: The provided
  text contains system error logs and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/BioTools-Tek/genepender"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepender:v2.6--h470a237_1
stdout: genepender.out
