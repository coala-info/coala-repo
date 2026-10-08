cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - exon-ensembl
label: ensemblcov_exon-ensembl
doc: "specific exons of the ensembl ids: downloads the GENCODE v48 GTF and extracts the exons of the given ids\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: exonensembl
    type: File
    doc: "path to the ensembl ids"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: selected_exons
    type:
      - 'null'
      - File
    doc: "Selected exons"
    outputBinding:
      glob: selectedexons.txt
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_exon-ensembl.out
