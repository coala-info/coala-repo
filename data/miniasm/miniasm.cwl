cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniasm
label: miniasm
doc: "miniasm: a very fast OLC-based de novo assembler for noisy long reads. It takes
  an all-vs-all read mapping in PAF format and writes the assembly graph in GFA format
  to standard output.\n\nTool homepage: https://github.com/lh3/miniasm"
inputs:
  - id: input_paf
    type: File
    doc: Input PAF file (may be gzip-compressed)
    inputBinding:
      position: 200
  - id: aggressive_overlap_drop_ratio
    type:
      - 'null'
      - float
    doc: aggressive overlap drop ratio in the end
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
    inputBinding:
      position: 102
      prefix: -d
  - id: max_gap_differences
    type:
      - 'null'
      - int
    doc: max gap differences between reads for trans-reduction
    inputBinding:
      position: 102
      prefix: -g
  - id: max_overhang_length
    type:
      - 'null'
      - int
    doc: max over hang length
    inputBinding:
      position: 102
      prefix: -h
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: min coverage
    inputBinding:
      position: 102
      prefix: -c
  - id: min_end_to_end_ratio
    type:
      - 'null'
      - float
    doc: min end-to-end match ratio
    inputBinding:
      position: 102
      prefix: -I
  - id: min_identity
    type:
      - 'null'
      - float
    doc: min identity
    inputBinding:
      position: 102
      prefix: -i
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: min match length
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
    inputBinding:
      position: 102
      prefix: -s
  - id: output_information
    type:
      - 'null'
      - string
    doc: 'output information: bed, paf, sg or ug'
    inputBinding:
      position: 102
      prefix: -p
  - id: overlap_drop_ratio
    type:
      - 'null'
      - type: array
        items: float
    doc: max and min overlap drop ratio (written as FLOAT,FLOAT)
    inputBinding:
      position: 102
      prefix: -r
      itemSeparator: ','
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
    inputBinding:
      position: 102
      prefix: -f
  - id: rounds_short_overlap_removal
    type:
      - 'null'
      - int
    doc: rounds of short overlap removal
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
    inputBinding:
      position: 102
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Assembly graph (GFA) or other output chosen with -p
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniasm:0.3_r179--ha92aebf_0
stdout: miniasm.gfa
