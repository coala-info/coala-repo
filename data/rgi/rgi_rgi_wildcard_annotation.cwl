cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - wildcard_annotation
label: rgi_rgi_wildcard_annotation
doc: "Creates card annotations for RGI BWT from Variants or WildCARD data.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: card_json
    type: File
    doc: card.json file
    inputBinding:
      position: 101
      prefix: --card_json
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode (default False)
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_directory
    type: Directory
    doc: input directory for wildcard
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: version
    type: string
    doc: specify version downloaded for wildcard / variants
    inputBinding:
      position: 101
      prefix: --version
outputs:
  - id: annotation_files
    type:
      type: array
      items: File
    doc: Annotated WildCARD reference FASTA files and index written in the working directory
    outputBinding:
      glob:
        - wildcard_database_v*.fasta
        - index-for-model-sequences.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
