cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - doc-dump
label: cobs_doc-dump
doc: "Dump documents from a path\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: path
    type: string
    doc: path to documents to dump
    inputBinding:
      position: 1
  - id: file_type
    type:
      - 'null'
      - string
    doc: '"list" to read a file list, or filter documents by file type (any, text,
      cortex, fasta, fastq, etc)'
    inputBinding:
      position: 102
  - id: no_canonicalize
    type:
      - 'null'
      - boolean
    doc: don't canonicalize DNA k-mers
    default: false
    inputBinding:
      position: 102
      prefix: --no-canonicalize
  - id: term_size
    type:
      - 'null'
      - int
    doc: term size (k-mer size)
    default: 31
    inputBinding:
      position: 102
      prefix: --term-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_doc-dump.out
