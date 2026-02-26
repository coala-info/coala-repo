cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastahack
label: fastahack
doc: "fastahack is a small tool for indexing and extracting sequences from FASTA files.\n\
  \nTool homepage: https://github.com/ekg/fastahack"
inputs:
  - id: fasta_file
    type: File
    doc: The FASTA file to be indexed or queried.
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check the FASTA file for consistency.
    inputBinding:
      position: 102
      prefix: --check
  - id: entries
    type:
      - 'null'
      - boolean
    doc: Print the names of the sequences in the FASTA file.
    inputBinding:
      position: 102
      prefix: --entries
  - id: index
    type:
      - 'null'
      - boolean
    doc: Generate an index file (.fai) for the FASTA file.
    inputBinding:
      position: 102
      prefix: --index
  - id: region
    type:
      - 'null'
      - string
    doc: 'Extract the sequence of the specified region (format: seq:start-end).'
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastahack:2016.07.2--0
stdout: fastahack.out
