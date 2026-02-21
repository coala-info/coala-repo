cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlecellnet-cli
label: singlecellnet-cli
doc: "SingleCellNet is a tool for single-cell RNA-seq data classification.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/singlecellnet-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
stdout: singlecellnet-cli.out
