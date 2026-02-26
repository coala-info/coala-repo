cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixMarketToTsv
label: ucsc-matrixmarkettotsv_matrixMarketToTsv
doc: "Convert matrix file from Matrix Market sparse matrix format to tab-separated-values.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_mtx
    type: File
    doc: a matrix market format matrix
    inputBinding:
      position: 1
  - id: sample_labels
    type: File
    doc: a text file with one label per line. It will end in the first row of 
      the output.
    inputBinding:
      position: 2
  - id: gene_labels
    type: File
    doc: a text file with one gene name per line. It will end up in the first 
      column of the output
    inputBinding:
      position: 3
outputs:
  - id: out_tsv
    type: File
    doc: output tsv file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixmarkettotsv:482--h0b57e2e_0
