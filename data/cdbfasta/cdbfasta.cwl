cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbfasta
label: cdbfasta
doc: "Creates a CDB (Constant DataBase) index for a FASTA file for quick retrieval
  of sequences.\n\nTool homepage: https://github.com/gpertea/cdbfasta"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file to be indexed
    inputBinding:
      position: 1
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Enable compression for the index
    inputBinding:
      position: 102
      prefix: -c
  - id: multi_fasta
    type:
      - 'null'
      - boolean
    doc: Handle multi-fasta files (index all records)
    inputBinding:
      position: 102
      prefix: -m
  - id: record_delimiter
    type:
      - 'null'
      - string
    doc: Specify a custom record delimiter (default is '>')
    inputBinding:
      position: 102
      prefix: -r
  - id: strip_chars
    type:
      - 'null'
      - string
    doc: Strip characters from the end of the sequence ID
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Optional name for the output index file (defaults to <fasta_file>.cbi)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cdbfasta:v0.99-20100722-5-deb_cv1
