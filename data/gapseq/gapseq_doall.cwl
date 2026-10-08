cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapseq
  - doall
label: gapseq_doall
doc: "Combine find, find-transport, draft, (medium,) and fill.

Tool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable noisy verbose mode"
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for sequence alignments (default: number of available CPUs)"
    inputBinding:
      position: 101
      prefix: -K
  - id: genome
    type: File
    doc: "Genome sequence in FASTA format (nucleotide or protein, optionally gzipped)"
    inputBinding:
      position: 200
  - id: medium
    type:
      - 'null'
      - File
    doc: "Medium table for gap filling (default: predicted medium)"
    inputBinding:
      position: 201
  - id: domain
    type:
      - 'null'
      - string
    doc: "Bacteria or Archaea (default: auto)"
    inputBinding:
      position: 202
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: doall_files
    type:
      type: array
      items: File
    doc: "Tables, draft and gapfilled models written by the workflow"
    outputBinding:
      glob:
        - "*.tbl"
        - "*.RDS"
        - "*.xml"
        - "*.csv"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq_doall.out
