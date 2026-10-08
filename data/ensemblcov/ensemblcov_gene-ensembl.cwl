cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - gene-ensembl
label: ensemblcov_gene-ensembl
doc: "gene list extraction from ensembl: downloads the GENCODE v48 transcript FASTA files and extracts the transcripts of the given ids\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: ensemblid
    type: File
    doc: "path to the ensembl ids"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: isolated_ids
    type:
      - 'null'
      - File
    doc: "Extracted transcript sequences"
    outputBinding:
      glob: isolated-ids.fasta
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_gene-ensembl.out
