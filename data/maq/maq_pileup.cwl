cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq pileup
label: maq_pileup
doc: "Generate pileup from Maq alignments\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: chr_bfa
    type: File
    doc: Input chromosome file (.bfa)
    inputBinding:
      position: 1
  - id: align_map
    type: File
    doc: Input alignment map file (.map)
    inputBinding:
      position: 2
  - id: discard_abnormal_pairs
    type:
      - 'null'
      - boolean
    doc: discard abnormal pairs
    inputBinding:
      position: 103
      prefix: -p
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches
    inputBinding:
      position: 103
      prefix: -m
  - id: max_sum_errors
    type:
      - 'null'
      - int
    doc: maximum sum of errors
    inputBinding:
      position: 103
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 103
      prefix: -q
  - id: only_show_depth
    type:
      - 'null'
      - boolean
    doc: only show depth
    inputBinding:
      position: 103
      prefix: -d
  - id: print_position_on_read
    type:
      - 'null'
      - boolean
    doc: print position on the read
    inputBinding:
      position: 103
      prefix: -P
  - id: required_positions_file
    type:
      - 'null'
      - File
    doc: only output required positions
    inputBinding:
      position: 103
      prefix: -l
  - id: use_single_end_qualities
    type:
      - 'null'
      - boolean
    doc: use single-end mapping qualities
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_pileup.out
