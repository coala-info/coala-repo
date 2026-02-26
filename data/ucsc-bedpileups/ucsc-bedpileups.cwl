cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedPileUps
label: ucsc-bedpileups
doc: "Create a pileup of BED files, showing the number of features covering each base
  in the genome.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: UCSC database name (e.g., hg19, mm10)
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Input BED file
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbose level (higher for more output)
    default: 1
    inputBinding:
      position: 103
      prefix: -verbose
outputs:
  - id: output_file
    type: File
    doc: Output pileup file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedpileups:482--h0b57e2e_0
