cwlVersion: v1.2
class: CommandLineTool
baseCommand: maker_to_proteindb.rb
label: protk_maker_to_proteindb.rb
doc: 'Create a protein database from Maker gene prediction output that is suitable for later processing
  by proteogenomics tools.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: maker_gff
    type: File
    doc: Maker gene prediction output (gff3)
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: info
    type:
      - 'null'
      - boolean
    doc: Include CDS Coordinates
    inputBinding:
      position: 102
      prefix: --info
  - id: prot_fasta
    type:
      - 'null'
      - File
    doc: A fasta file containing protein sequences for each transcript
    inputBinding:
      position: 102
      prefix: --prot-fasta
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
