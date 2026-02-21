cwlVersion: v1.2
class: CommandLineTool
baseCommand: catUncomment
label: ucsc-catuncomment
doc: "Remove comments from a file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_file
    type: File
    doc: Input file to remove comments from
    inputBinding:
      position: 1
outputs:
  - id: out_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-catuncomment:482--h0b57e2e_0
