cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - auto-generate
label: ensemblcov_auto-generate
doc: "autogenerate the ensemble gene conversion: downloads the GENCODE v48 GTF and writes the gene id to gene name table (annotation)\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: generate
    type: string
    doc: "provide yes as argument"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: annotation_table
    type:
      - 'null'
      - File
    doc: "Gene id to gene name table"
    outputBinding:
      glob: annotation
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_auto-generate.out
