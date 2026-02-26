cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-tolower
label: ucsc-tolower
doc: "A UCSC Genome Browser utility to convert sequences in a file to lowercase.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (typically FASTA)
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output file where lowercase sequences will be written
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tolower:482--h0b57e2e_0
