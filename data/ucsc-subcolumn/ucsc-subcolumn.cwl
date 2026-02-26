cwlVersion: v1.2
class: CommandLineTool
baseCommand: subColumn
label: ucsc-subcolumn
doc: "Extract a column from a file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: column_num
    type: int
    doc: The 1-based index of the column to extract.
    inputBinding:
      position: 1
  - id: in_file
    type: File
    doc: The input file to process.
    inputBinding:
      position: 2
outputs:
  - id: out_file
    type: File
    doc: The output file where the column will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subcolumn:482--h0b57e2e_0
