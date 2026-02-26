cwlVersion: v1.2
class: CommandLineTool
baseCommand: toupper
label: ucsc-toupper
doc: "Converts all characters in a file to uppercase.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file to be converted to uppercase
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output file with uppercase text
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-toupper:482--h0b57e2e_0
