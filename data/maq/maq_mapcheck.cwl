cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq_mapcheck
label: maq_mapcheck
doc: "Check mapping quality of reads.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: chr_bfa
    type: File
    doc: Reference genome file in BFA format
    inputBinding:
      position: 1
  - id: input_map
    type: File
    doc: Input map file
    inputBinding:
      position: 2
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches
    default: 7
    inputBinding:
      position: 103
      prefix: -m
  - id: max_sum_errors
    type:
      - 'null'
      - int
    doc: maximum sum of errors
    default: 60
    inputBinding:
      position: 103
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 41
    inputBinding:
      position: 103
      prefix: -q
  - id: polymorphic_sites
    type:
      - 'null'
      - File
    doc: polymorphic sites
    default: 'null'
    inputBinding:
      position: 103
      prefix: -P
  - id: print_count
    type:
      - 'null'
      - boolean
    doc: print count instead of fraction
    inputBinding:
      position: 103
      prefix: -c
  - id: quality_scale
    type:
      - 'null'
      - int
    doc: quality scale
    default: 10
    inputBinding:
      position: 103
      prefix: -S
  - id: use_single_end_qualities
    type:
      - 'null'
      - boolean
    doc: use single-end mapping qualities
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_mapcheck.out
