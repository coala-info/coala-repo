cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-text-to-fasta
label: dsh-bio_text-to-fasta
doc: "Converts text input to FASTA format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: alphabet
    type:
      - 'null'
      - string
    doc: output FASTA alphabet { dna, protein }
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: input_text_path
    type:
      - 'null'
      - File
    doc: input text path
    inputBinding:
      position: 101
      prefix: --input-text-path
  - id: line_width
    type:
      - 'null'
      - int
    doc: output line width
    inputBinding:
      position: 101
      prefix: --line-width
outputs:
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
