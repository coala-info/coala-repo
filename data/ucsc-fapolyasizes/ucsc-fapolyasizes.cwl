cwlVersion: v1.2
class: CommandLineTool
baseCommand: faPolyASizes
label: ucsc-fapolyasizes
doc: "Count polyA tail sizes in sequences of a fasta file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to analyze
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fapolyasizes:482--h0b57e2e_0
stdout: ucsc-fapolyasizes.out
