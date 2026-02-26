cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_fasta-to-text
label: dsh-bio_fasta-to-text
doc: "Converts FASTA sequences to plain text.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing sequences.
    inputBinding:
      position: 1
outputs:
  - id: output_text
    type: File
    doc: Output file to write plain text sequences.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
