cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixClusterColumns
label: ucsc-matrixclustercolumns
doc: "Cluster columns of a matrix.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file
    inputBinding:
      position: 1
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum correlation to cluster
    inputBinding:
      position: 102
      prefix: -threshold
outputs:
  - id: output_matrix
    type: File
    doc: Output clustered matrix file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixclustercolumns:482--h0b57e2e_0
