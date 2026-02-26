cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign
doc: "Kalign is a fast and accurate multiple sequence alignment algorithm.\n\nTool
  homepage: https://github.com/TimoLassmann/kalign"
inputs:
  - id: bonus_score
    type:
      - 'null'
      - float
    doc: Bonus score.
    inputBinding:
      position: 101
      prefix: --bonus
  - id: gap_extension_penalty
    type:
      - 'null'
      - float
    doc: Gap extension penalty.
    inputBinding:
      position: 101
      prefix: --gapext
  - id: gap_open_penalty
    type:
      - 'null'
      - float
    doc: Gap open penalty.
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: input
    type:
      - 'null'
      - File
    doc: Input file containing sequences in FASTA format.
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
    doc: Quiet mode; suppresses screen output.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: terminal_gap_extension_penalty
    type:
      - 'null'
      - float
    doc: Terminal gap extension penalty.
    inputBinding:
      position: 101
      prefix: --termgapext
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
    dockerPull: biocontainers/kalign:v1-2.0320110620-5-deb_cv1
