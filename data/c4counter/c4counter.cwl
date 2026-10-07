cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - c4counter
label: c4counter
doc: "Count occurrences in reference FASTA files\n\nTool homepage: https://github.com/irunonayran/c4counter.git"
inputs:
  - id: references_fasta
    type:
      type: array
      items: File
    doc: Reference FASTA files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Number and types of C4 genes (C4A / C4B, HERV / no HERV) per FASTA file
  - id: svg
    type:
      - 'null'
      - File
    doc: Simple graphical representation of the C4 genes (c4.svg)
    outputBinding:
      glob: c4.svg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/c4counter:0.0.2--pyhdfd78af_0
stdout: c4counter.out
