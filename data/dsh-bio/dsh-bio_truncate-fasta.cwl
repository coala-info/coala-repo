cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_truncate-fasta
label: dsh-bio_truncate-fasta
doc: "Truncates FASTA sequences to a specified length.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file.
    inputBinding:
      position: 1
  - id: length
    type: int
    doc: The maximum length to truncate sequences to.
    inputBinding:
      position: 102
      prefix: --length
outputs:
  - id: output_fasta
    type: File
    doc: The output FASTA file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
