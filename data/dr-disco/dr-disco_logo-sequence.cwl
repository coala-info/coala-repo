cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - logo-sequence
label: dr-disco_logo-sequence
doc: "Generate logo sequences for regions.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: region
    type: string
    doc: Region to generate logo sequence for.
    inputBinding:
      position: 1
  - id: fasta_input_file
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 2
  - id: offset_negative
    type:
      - 'null'
      - int
    doc: Offset for negative logo sequence.
    inputBinding:
      position: 103
      prefix: --offset-negative
  - id: offset_positive
    type:
      - 'null'
      - int
    doc: Offset for positive logo sequence.
    inputBinding:
      position: 103
      prefix: --offset-positive
outputs:
  - id: fasta_output_file_negative
    type: File
    doc: Output FASTA file for negative logo sequence.
    outputBinding:
      glob: '*.out'
  - id: fasta_output_file_positive
    type: File
    doc: Output FASTA file for positive logo sequence.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
