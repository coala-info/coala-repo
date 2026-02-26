cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniasm
label: miniasm
doc: "miniasm: option requires an argument -- 'h'\nSee miniasm.1 for detailed description
  of the command-line options.\n\nTool homepage: https://github.com/lh3/miniasm"
inputs:
  - id: input_paf
    type: File
    doc: Input PAF file
    inputBinding:
      position: 1
  - id: aggressive_overlap_drop_ratio
    type:
      - 'null'
      - float
    doc: aggressive overlap drop ratio in the end
    default: 0.8
    inputBinding:
      position: 102
      prefix: -F
  - id: both_directions_present
    type:
      - 'null'
      - boolean
    doc: both directions of an arc are present in input
    inputBinding:
      position: 102
      prefix: -b
  - id: max_bubble_popping_distance
    type:
      - 'null'
      - int
    doc: max distance for bubble popping
    default: 50000
    inputBinding:
      position: 102
      prefix: -d
  - id: max_gap_differences
    type:
      - 'null'
      - int
    doc: max gap differences between reads for trans-reduction
    default: 1000
    inputBinding:
      position: 102
      prefix: -g
  - id: max_overhang_length
    type:
      - 'null'
      - int
    doc: max over hang length
    default: 1000
    inputBinding:
      position: 102
      prefix: -h
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: min coverage
    default: 3
    inputBinding:
      position: 102
      prefix: -c
  - id: min_end_to_end_ratio
    type:
      - 'null'
      - float
    doc: min end-to-end match ratio
    default: 0.8
    inputBinding:
      position: 102
      prefix: -I
  - id: min_identity
    type:
      - 'null'
      - float
    doc: min identity
    default: 0.05
    inputBinding:
      position: 102
      prefix: -i
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: min match length
    default: 100
    inputBinding:
      position: 102
      prefix: -m
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: min overlap [same as -s]
    inputBinding:
      position: 102
      prefix: -o
  - id: min_span
    type:
      - 'null'
      - int
    doc: min span
    default: 2000
    inputBinding:
      position: 102
      prefix: -s
  - id: output_information
    type:
      - 'null'
      - string
    doc: 'output information: bed, paf, sg or ug'
    default: ug
    inputBinding:
      position: 102
      prefix: -p
  - id: overlap_drop_ratio
    type:
      - 'null'
      - type: array
        items: float
    doc: max and min overlap drop ratio
    default: '[0.7,0.5]'
    inputBinding:
      position: 102
      prefix: -r
  - id: prefilter_contained_reads
    type:
      - 'null'
      - boolean
    doc: prefilter clearly contained reads (2-pass required)
    inputBinding:
      position: 102
      prefix: -R
  - id: read_sequences
    type:
      - 'null'
      - File
    doc: read sequences
    default: '[]'
    inputBinding:
      position: 102
      prefix: -f
  - id: rounds_short_overlap_removal
    type:
      - 'null'
      - int
    doc: rounds of short overlap removal
    default: 3
    inputBinding:
      position: 102
      prefix: -n
  - id: skip_1pass_selection
    type:
      - 'null'
      - boolean
    doc: skip 1-pass read selection
    inputBinding:
      position: 102
      prefix: '-1'
  - id: skip_2pass_selection
    type:
      - 'null'
      - boolean
    doc: skip 2-pass read selection
    inputBinding:
      position: 102
      prefix: '-2'
  - id: small_unitig_threshold
    type:
      - 'null'
      - int
    doc: small unitig threshold
    default: 4
    inputBinding:
      position: 102
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniasm:0.3_r179--ha92aebf_0
stdout: miniasm.out
