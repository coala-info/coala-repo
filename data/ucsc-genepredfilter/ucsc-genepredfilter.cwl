cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredFilter
label: ucsc-genepredfilter
doc: "Filter genePred files based on various criteria.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gene_pred_in
    type: File
    doc: Input genePred file
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: Get gene names from this database
    inputBinding:
      position: 102
      prefix: -db
  - id: exclude
    type:
      - 'null'
      - File
    doc: File of gene names to exclude
    inputBinding:
      position: 102
      prefix: -exclude
  - id: include
    type:
      - 'null'
      - File
    doc: File of gene names to include
    inputBinding:
      position: 102
      prefix: -include
outputs:
  - id: gene_pred_out
    type: File
    doc: Output filtered genePred file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredfilter:482--h0b57e2e_0
