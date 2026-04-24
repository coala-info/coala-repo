cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnarrange
label: dnarrange
doc: "Find rearranged query sequences in query-to-reference alignments.\n\nTool homepage:
  https://github.com/mcfrith/dnarrange"
inputs:
  - id: case_files
    type:
      type: array
      items: File
    doc: case-file(s)
    inputBinding:
      position: 1
  - id: control_files
    type:
      - 'null'
      - type: array
        items: File
    doc: control-file(s)
    inputBinding:
      position: 2
  - id: filter
    type:
      - 'null'
      - int
    doc: discard case reads sharing any (0) or "strongest" (1) rearrangements 
      with control reads
    inputBinding:
      position: 103
      prefix: --filter
  - id: insert
    type:
      - 'null'
      - string
    doc: find insertions of the sequence with this name
    inputBinding:
      position: 103
      prefix: --insert
  - id: max_diff
    type:
      - 'null'
      - int
    doc: maximum query-length difference for shared rearrangement
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: max_mismap
    type:
      - 'null'
      - float
    doc: discard any alignment with mismap probability > PROB
    inputBinding:
      position: 103
      prefix: --max-mismap
  - id: min_cov
    type:
      - 'null'
      - int
    doc: omit any query with any rearrangement shared by < N other queries
    inputBinding:
      position: 103
      prefix: --min-cov
  - id: min_gap
    type:
      - 'null'
      - int
    doc: minimum forward jump in the reference sequence counted as a "big gap"
    inputBinding:
      position: 103
      prefix: --min-gap
  - id: min_rev
    type:
      - 'null'
      - int
    doc: minimum reverse jump in the reference sequence counted as 
      "non-colinear"
    inputBinding:
      position: 103
      prefix: --min-rev
  - id: min_seqs
    type:
      - 'null'
      - int
    doc: minimum query sequences per group
    inputBinding:
      position: 103
      prefix: --min-seqs
  - id: shrink
    type:
      - 'null'
      - boolean
    doc: shrink the output
    inputBinding:
      position: 103
      prefix: --shrink
  - id: types
    type:
      - 'null'
      - string
    doc: 'rearrangement types: C=inter-chromosome, S=inter-strand, N=non-colinear,
      G=big gap'
    inputBinding:
      position: 103
      prefix: --types
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages
    inputBinding:
      position: 103
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: line-wrap width of group summary lines
    inputBinding:
      position: 103
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange.out
