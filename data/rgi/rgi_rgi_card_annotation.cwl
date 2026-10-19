cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - card_annotation
label: rgi_rgi_card_annotation
doc: "Creates card annotations for RGI BWT from card.json.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode (default False)
    inputBinding:
      position: 101
      prefix: --debug
  - id: input
    type: File
    doc: card.json file
    inputBinding:
      position: 101
      prefix: --input
  - id: ncbi
    type:
      - 'null'
      - boolean
    doc: adds ncbi accession to FASTA headers (default False)
    inputBinding:
      position: 101
      prefix: --ncbi
outputs:
  - id: annotation_fasta_files
    type:
      type: array
      items: File
    doc: Annotated reference FASTA files (card_database_v<version>.fasta and card_database_v<version>_all.fasta)
    outputBinding:
      glob: card_database_v*.fasta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
