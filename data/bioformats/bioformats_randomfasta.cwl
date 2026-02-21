cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - randomfasta
label: bioformats_randomfasta
doc: "Generate a random FASTA file with specified sequence length and number of sequences.\n
  \nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: seq_length
    type: int
    doc: Length of each sequence to generate
    inputBinding:
      position: 1
  - id: seq_num
    type: int
    doc: Number of sequences to generate
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
