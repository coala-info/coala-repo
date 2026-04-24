cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign3
doc: "Kalign is a fast and accurate multiple sequence alignment algorithm.\n\nTool
  homepage: https://github.com/TimoLassmann/kalign"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (e.g., fasta, clustal, msf, phylip).
    inputBinding:
      position: 101
      prefix: --format
  - id: gap_extension
    type:
      - 'null'
      - float
    doc: Gap extension penalty.
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gap_open
    type:
      - 'null'
      - float
    doc: Gap open penalty.
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: input
    type: File
    doc: Input file containing sequences to be aligned.
    inputBinding:
      position: 101
      prefix: --input
  - id: matrix
    type:
      - 'null'
      - string
    doc: Substitution matrix.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode, suppress output messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: terminal_gap
    type:
      - 'null'
      - float
    doc: Terminal gap penalties.
    inputBinding:
      position: 101
      prefix: --terminal
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for the alignment.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign3:3.4.0--h503566f_2
