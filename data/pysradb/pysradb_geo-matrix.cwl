cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb geo-matrix
label: pysradb_geo-matrix
doc: "Generates a matrix from GEO accession data.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: accession
    type: string
    doc: GEO accession (e.g., GSE234190)
    inputBinding:
      position: 101
      prefix: --accession
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: current directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: to_tsv
    type:
      - 'null'
      - boolean
    doc: Convert the matrix file to TSV format
    inputBinding:
      position: 101
      prefix: --to-tsv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb_geo-matrix.out
