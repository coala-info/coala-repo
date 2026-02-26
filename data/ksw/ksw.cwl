cwlVersion: v1.2
class: CommandLineTool
baseCommand: ksw
label: ksw
doc: "klib smith-waterman\n\nTool homepage: https://github.com/nh13/ksw"
inputs:
  - id: add_header_line
    type:
      - 'null'
      - boolean
    doc: Add a header line to the output
    default: false
    inputBinding:
      position: 101
      prefix: -H
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'The alignment mode: 0 - local, 1 - glocal, 2 - extend, 3 - global'
    default: 0
    inputBinding:
      position: 101
      prefix: -M
  - id: append_cigar
    type:
      - 'null'
      - boolean
    doc: Append the cigar to the output
    default: false
    inputBinding:
      position: 101
      prefix: -c
  - id: append_query_target
    type:
      - 'null'
      - boolean
    doc: Append the query and target to the output
    default: false
    inputBinding:
      position: 101
      prefix: -s
  - id: band_width
    type:
      - 'null'
      - int
    doc: The band width (ksw only)
    default: 536870911
    inputBinding:
      position: 101
      prefix: -w
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: The gap extend penalty (>0)
    default: 2
    inputBinding:
      position: 101
      prefix: -r
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: The gap open penalty (>=0)
    default: 5
    inputBinding:
      position: 101
      prefix: -q
  - id: library_type
    type:
      - 'null'
      - int
    doc: 'The library type: 0 - auto, 1 - ksw2, 2 - parasail'
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: match_score
    type:
      - 'null'
      - int
    doc: The match score (>0)
    default: 1
    inputBinding:
      position: 101
      prefix: -a
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: The mismatch penalty (>0)
    default: 3
    inputBinding:
      position: 101
      prefix: -b
  - id: output_offset_and_length
    type:
      - 'null'
      - boolean
    doc: Output offset-and-length, otherwise start-and-end (all zero-based)
    default: false
    inputBinding:
      position: 101
      prefix: -O
  - id: right_align_gaps
    type:
      - 'null'
      - boolean
    doc: Right-align gaps (ksw only)
    default: false
    inputBinding:
      position: 101
      prefix: -R
  - id: scoring_matrix
    type:
      - 'null'
      - File
    doc: Path to the scoring matrix (4x4 or 5x5)
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ksw:0.2.3--h43eeafb_0
stdout: ksw.out
