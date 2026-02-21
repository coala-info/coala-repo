cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - fastareorder
label: bioformats_fastareorder
doc: "Reorder sequences in a FASTA file.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: fasta
    type: File
    doc: a FASTA file of sequences to reorder
    inputBinding:
      position: 1
  - id: order_file
    type: File
    doc: a file with the sequence order
    inputBinding:
      position: 2
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: ignore sequences in the specified order file that are missing in the input
      FASTA file
    inputBinding:
      position: 103
      prefix: --ignore_missing
outputs:
  - id: output
    type: File
    doc: an output FASTA file of reordered sequences
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
