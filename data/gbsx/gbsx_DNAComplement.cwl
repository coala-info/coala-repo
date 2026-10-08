cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbsx
  - --DNAComplement
label: gbsx_DNAComplement
doc: "GBSX DNA Complement creator: makes the complement of a given DNA sequence.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: dna_sequence
    type: string
    doc: "A string of DNA"
    inputBinding:
      position: 1
outputs:
  - id: complement
    type: stdout
    doc: The complement of the DNA sequence
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx_DNAComplement.out
