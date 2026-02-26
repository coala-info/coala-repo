cwlVersion: v1.2
class: CommandLineTool
baseCommand: wordLine
label: ucsc-wordline
doc: "Put each word in a file on its own line.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input file to process
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output file where each word is placed on its own line
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wordline:482--h0b57e2e_0
