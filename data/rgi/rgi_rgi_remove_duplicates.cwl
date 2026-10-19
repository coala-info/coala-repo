cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - remove_duplicates
label: rgi_rgi_remove_duplicates
doc: "Removes duplicate sequences from an annotated FASTA file.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: card_annotation
    type: File
    doc: card_annotation input fasta file
    inputBinding:
      position: 101
      prefix: --card_annotation
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_fasta_file
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_fasta_file_path
    type: string
    doc: output fasta file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_fasta_file
    type: File
    doc: output fasta file
    outputBinding:
      glob: $(inputs.output_fasta_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
