cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixToBarChartBed
label: ucsc-matrixtobarchartbed
doc: "Convert a matrix file to a barChart BED file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file to be converted
    inputBinding:
      position: 1
outputs:
  - id: output_bed
    type: File
    doc: Output barChart BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixtobarchartbed:482--h0b57e2e_0
