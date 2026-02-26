cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov exon-ensembl
label: ensemblcov_exon-ensembl
doc: "Generates exon-ensembl coverage data.\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: exonensembl
    type: string
    doc: Exon Ensembl ID
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_exon-ensembl.out
