cwlVersion: v1.2
class: CommandLineTool
baseCommand: delta-filter
label: mummer4_delta-filter
doc: "Reads a delta alignment file from either nucmer or promer and filters the alignments
  based on the command-line switches, leaving only the desired alignments which are
  output to stdout in the same delta format as the input.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: deltafile
    type: File
    doc: delta alignment file
    inputBinding:
      position: 1
  - id: many_to_many_rearrangements
    type:
      - 'null'
      - boolean
    doc: Many-to-many alignment allowing for rearrangements (union of -r and -q 
      alignments)
    inputBinding:
      position: 102
      prefix: -m
  - id: max_overlap_percent
    type:
      - 'null'
      - float
    doc: Set the maximum alignment overlap for -r and -q options as a percent of
      the alignment length [0, 100]
    default: 100.0
    inputBinding:
      position: 102
      prefix: -o
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Set the minimum alignment length
    default: 0
    inputBinding:
      position: 102
      prefix: -l
  - id: min_alignment_uniqueness
    type:
      - 'null'
      - float
    doc: Set the minimum alignment uniqueness, i.e. percent of the alignment 
      matching to unique reference AND query sequence [0, 100]
    default: 0.0
    inputBinding:
      position: 102
      prefix: -u
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Set the minimum alignment identity [0, 100]
    default: 0.0
    inputBinding:
      position: 102
      prefix: -i
  - id: one_to_one_global
    type:
      - 'null'
      - boolean
    doc: 1-to-1 global alignment not allowing rearrangements
    inputBinding:
      position: 102
      prefix: -g
  - id: one_to_one_rearrangements
    type:
      - 'null'
      - boolean
    doc: 1-to-1 alignment allowing for rearrangements (intersection of -r and -q
      alignments)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: query_best_hit
    type:
      - 'null'
      - boolean
    doc: Maps each position of each query to its best hit in the reference, 
      allowing for reference overlaps
    inputBinding:
      position: 102
      prefix: -q
  - id: reference_best_hit
    type:
      - 'null'
      - boolean
    doc: Maps each position of each reference to its best hit in the query, 
      allowing for query overlaps
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_delta-filter.out
