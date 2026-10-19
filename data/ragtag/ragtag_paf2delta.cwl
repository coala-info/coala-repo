cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - paf2delta
label: ragtag_paf2delta
doc: "Convert a PAF file to a Nucmer delta file (written to standard output). PAF\
  \ lines must have CIGAR strings.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: paf
    type: File
    doc: PAF file to convert (gzip allowed)
    inputBinding:
      position: 1
  - id: reference
    type:
      - 'null'
      - File
    doc: PATH to the reference fasta file
    inputBinding:
      position: 101
      prefix: -r
  - id: query
    type:
      - 'null'
      - File
    doc: PATH to the query fasta file
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: delta
    type: stdout
    doc: Nucmer delta file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_paf2delta.delta
