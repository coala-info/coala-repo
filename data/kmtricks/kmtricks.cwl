cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks
label: kmtricks
doc: "A tool for k-mer based analysis of large collections of sequencing data (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/tlemane/kmtricks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
stdout: kmtricks.out
