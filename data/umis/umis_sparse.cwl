cwlVersion: v1.2
class: CommandLineTool
baseCommand: umis sparse
label: umis_sparse
doc: "Convert a CSV file to a sparse matrix with rows and column names saved as companion
  files.\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: csv_file
    type: File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: sparse_file
    type: File
    doc: Output sparse matrix file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_sparse.out
