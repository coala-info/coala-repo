cwlVersion: v1.2
class: CommandLineTool
baseCommand: alen
label: alen
doc: "A command-line program to view DNA, RNA or protein alignments in FASTA format.\n
  \nTool homepage: https://github.com/jakobnissen/alen"
inputs:
  - id: alignment
    type: File
    doc: Path to alignment
    inputBinding:
      position: 1
  - id: amino_acids
    type:
      - 'null'
      - boolean
    doc: Force parsing as amino acids
    inputBinding:
      position: 102
      prefix: -a
  - id: monochrome
    type:
      - 'null'
      - boolean
    doc: Disable colors (monochrome, may improve lag)
    inputBinding:
      position: 102
      prefix: -m
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: Display sequences in uppercase
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alen:0.3.3--h4349ce8_0
stdout: alen.out
