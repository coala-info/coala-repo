cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov gene-ensembl
label: ensemblcov_gene-ensembl
doc: "For more information, try '--help'.\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: ensemblid
    type: string
    doc: ENSEMBLID
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_gene-ensembl.out
