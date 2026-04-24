cwlVersion: v1.2
class: CommandLineTool
baseCommand: smithwaterman
label: smithwaterman
doc: "When called with literal reference and query sequences, smithwaterman prints
  the cigar match positional string and the match position for the query sequence
  against the reference sequence.\n\nTool homepage: https://github.com/ekg/smithwaterman"
inputs:
  - id: reference_sequence
    type: string
    doc: reference sequence
    inputBinding:
      position: 1
  - id: query_sequence
    type: string
    doc: query sequence
    inputBinding:
      position: 2
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: bandwidth to use (default 0, or non-banded algorithm)
    inputBinding:
      position: 103
      prefix: --bandwidth
  - id: entropy_gap_open_penalty
    type:
      - 'null'
      - boolean
    doc: enable entropy scaling of the gap open penalty
    inputBinding:
      position: 103
      prefix: --entropy-gap-open-penalty
  - id: gap_extend_penalty
    type:
      - 'null'
      - float
    doc: the gap extend penalty
    inputBinding:
      position: 103
      prefix: --gap-extend-penalty
  - id: gap_open_penalty
    type:
      - 'null'
      - float
    doc: the gap open penalty
    inputBinding:
      position: 103
      prefix: --gap-open-penalty
  - id: match_score
    type:
      - 'null'
      - float
    doc: the match score
    inputBinding:
      position: 103
      prefix: --match-score
  - id: mismatch_score
    type:
      - 'null'
      - float
    doc: the mismatch score
    inputBinding:
      position: 103
      prefix: --mismatch-score
  - id: print_alignment
    type:
      - 'null'
      - boolean
    doc: print out the alignment
    inputBinding:
      position: 103
      prefix: --print-alignment
  - id: repeat_gap_extend_penalty
    type:
      - 'null'
      - boolean
    doc: use repeat information when generating gap extension penalties
    inputBinding:
      position: 103
      prefix: --repeat-gap-extend-penalty
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: report the reverse-complement alignment if it scores better
    inputBinding:
      position: 103
      prefix: --reverse-complement
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smithwaterman:1.0.0--h9948957_0
stdout: smithwaterman.out
