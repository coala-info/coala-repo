cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNchain
label: fastga_ALNchain
doc: "Chains the local alignments of a .1aln file into one-to-one global chains.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.alignments.basename)
inputs:
  - id: alignments
    type: File
    doc: Alignment file (.1aln) made by FastGA.
  - id: sources
    type: File[]
    doc: Source genome files (for example FASTA) named in the alignment file; they are staged beside it.
  - id: output
    type:
      - 'null'
      - string
    doc: Output 1-code file name (the .1aln extension is added).
    inputBinding:
      position: 101
      prefix: '-o'
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: '-v'
  - id: max_gap
    type:
      - 'null'
      - int
    doc: 'Maximum gap size. [default: 10000]'
    inputBinding:
      position: 101
      prefix: '-g'
      separate: false
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: 'Maximum overlap size. [default: 10000]'
    inputBinding:
      position: 101
      prefix: '-l'
      separate: false
  - id: gap_cost
    type:
      - 'null'
      - float
    doc: 'A gap of size G costs (-p)*G. [default: 0.1]'
    inputBinding:
      position: 101
      prefix: '-p'
      separate: false
  - id: overlap_cost
    type:
      - 'null'
      - float
    doc: 'An overlap of size O costs (-q)*O. [default: 0.1]'
    inputBinding:
      position: 101
      prefix: '-q'
      separate: false
  - id: score_drop
    type:
      - 'null'
      - int
    doc: 'Score drop threshold for breaking a chain. [default: 1000]'
    inputBinding:
      position: 101
      prefix: '-z'
      separate: false
  - id: min_chain_score
    type:
      - 'null'
      - int
    doc: 'Minimum chain score. [default: 10000]'
    inputBinding:
      position: 101
      prefix: '-s'
      separate: false
  - id: min_fragments
    type:
      - 'null'
      - int
    doc: 'Minimum number of alignment fragments in a chain. [default: 1]'
    inputBinding:
      position: 101
      prefix: '-n'
      separate: false
  - id: max_coverage
    type:
      - 'null'
      - float
    doc: 'Maximum coverage as a fraction of chain size. [default: 0.5]'
    inputBinding:
      position: 101
      prefix: '-c'
      separate: false
  - id: min_extension
    type:
      - 'null'
      - float
    doc: 'Minimum extension as a fraction of sequence size. [default: 0.0]'
    inputBinding:
      position: 101
      prefix: '-e'
      separate: false
  - id: fuzzy_gap
    type:
      - 'null'
      - int
    doc: 'Maximum gap for fuzzy merge. [default: 1000]'
    inputBinding:
      position: 101
      prefix: '-f'
      separate: false
outputs:
  - id: chained_alignments
    type: File
    doc: Chained alignment file.
    outputBinding:
      glob: $(inputs.output).1aln
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignments)
      - $(inputs.sources)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNchain.out
