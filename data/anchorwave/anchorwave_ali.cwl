cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchorwave
  - ali
label: anchorwave_ali
doc: "Sequence alignment using AnchorWave\n\nTool homepage: https://github.com/baoxingsong/AnchorWave"
inputs:
  - id: extend_gap_penalty_1
    type:
      - 'null'
      - int
    doc: extend gap penalty
    default: -2
    inputBinding:
      position: 101
      prefix: -E1
  - id: extend_gap_penalty_2
    type:
      - 'null'
      - int
    doc: extend gap penalty 2
    default: -1
    inputBinding:
      position: 101
      prefix: -E2
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatching penalty
    default: -6
    inputBinding:
      position: 101
      prefix: -B
  - id: open_gap_penalty_1
    type:
      - 'null'
      - int
    doc: open gap penalty
    default: -8
    inputBinding:
      position: 101
      prefix: -O1
  - id: open_gap_penalty_2
    type:
      - 'null'
      - int
    doc: open gap penalty 2
    default: -75
    inputBinding:
      position: 101
      prefix: -O2
  - id: reference_sequence
    type: File
    doc: reference sequence (single sequence in FASTA format)
    inputBinding:
      position: 101
      prefix: -r
  - id: target_sequence
    type: File
    doc: target sequence (single sequence in FASTA format)
    inputBinding:
      position: 101
      prefix: -s
  - id: window_width
    type:
      - 'null'
      - int
    doc: sequence alignment window width
    default: 100000
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anchorwave:1.2.6--h077b44d_0
stdout: anchorwave_ali.out
