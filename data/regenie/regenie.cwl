cwlVersion: v1.2
class: CommandLineTool
baseCommand: regenie
label: regenie
doc: "A tool for whole-genome regression analysis of large-scale datasets. (Note:
  The provided text appears to be a container execution error log rather than help
  text; therefore, no arguments could be extracted.)\n\nTool homepage: https://rgcgithub.github.io/regenie/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regenie:4.1.2--he9e75c4_0
stdout: regenie.out
