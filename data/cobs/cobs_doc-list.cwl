cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - doc-list
label: cobs_doc-list
doc: "list documents\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: path
    type: Directory
    doc: path to documents to list
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
      prefix: --file-type
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
stdout: cobs_doc-list.out
