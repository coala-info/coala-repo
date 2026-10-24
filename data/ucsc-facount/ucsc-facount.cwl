cwlVersion: v1.2
class: CommandLineTool
baseCommand: faCount
label: ucsc-facount
doc: "Count base statistics and CpGs in FA files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input FASTA file(s).
    inputBinding:
      position: 10
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Show only summary statistics.
    inputBinding:
      position: 1
      prefix: -summary
  - id: dinuc
    type:
      - 'null'
      - boolean
    doc: Include statistics on dinucleotide frequencies.
    inputBinding:
      position: 2
      prefix: -dinuc
  - id: strands
    type:
      - 'null'
      - boolean
    doc: Count bases on both strands.
    inputBinding:
      position: 3
      prefix: -strands
outputs:
  - id: stdout
    type: stdout
    doc: Table of base counts per sequence
stdout: ucsc-facount.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-facount:482--h0b57e2e_0
