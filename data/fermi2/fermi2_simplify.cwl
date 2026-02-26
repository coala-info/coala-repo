cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2 simplify
label: fermi2_simplify
doc: "Simplify a MAG graph\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: input_mag
    type: File
    doc: Input MAG file
    inputBinding:
      position: 1
  - id: aggressive_bubble_popping
    type:
      - 'null'
      - boolean
    doc: aggressive bubble popping
    inputBinding:
      position: 102
      prefix: -A
  - id: clean_graph
    type:
      - 'null'
      - boolean
    doc: clean the graph
    inputBinding:
      position: 102
      prefix: -C
  - id: drop_neighbor_ratio
    type:
      - 'null'
      - float
    doc: drop a neighbor if relative overlap ratio below FLOAT
    default: 0.6
    inputBinding:
      position: 102
      prefix: -d
  - id: force_no_modifications
    type:
      - 'null'
      - boolean
    doc: don't attempt to fix erroneous edges (force -O)
    inputBinding:
      position: 102
      prefix: -F
  - id: max_neighbors
    type:
      - 'null'
      - int
    doc: read maximum INT neighbors per node
    default: 512
    inputBinding:
      position: 102
      prefix: -N
  - id: min_coverage_to_keep_bubble
    type:
      - 'null'
      - float
    doc: minimum coverage to keep a bubble
    default: 10.0
    inputBinding:
      position: 102
      prefix: -w
  - id: min_fraction_to_keep_bubble
    type:
      - 'null'
      - float
    doc: minimum fraction to keep a bubble
    default: 0.15
    inputBinding:
      position: 102
      prefix: -r
  - id: min_internal_unitig_read_count
    type:
      - 'null'
      - int
    doc: minimum internal unitig read count
    default: 3
    inputBinding:
      position: 102
      prefix: -i
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap
    default: 0
    inputBinding:
      position: 102
      prefix: -o
  - id: min_overlap_to_merge
    type:
      - 'null'
      - int
    doc: minimum overlap to merge
    default: 0
    inputBinding:
      position: 102
      prefix: -m
  - id: min_relative_overlap_ratio
    type:
      - 'null'
      - float
    doc: minimum relative overlap ratio
    default: 0.7
    inputBinding:
      position: 102
      prefix: -R
  - id: min_tip_length
    type:
      - 'null'
      - int
    doc: minimum tip length
    default: 300
    inputBinding:
      position: 102
      prefix: -l
  - id: min_tip_read_count
    type:
      - 'null'
      - int
    doc: minimum tip read count
    default: 4
    inputBinding:
      position: 102
      prefix: -e
  - id: read_graph_no_modifications
    type:
      - 'null'
      - boolean
    doc: read the graph without modifications
    inputBinding:
      position: 102
      prefix: -O
  - id: skip_bubble_simplification
    type:
      - 'null'
      - boolean
    doc: skip bubble simplification
    inputBinding:
      position: 102
      prefix: -S
  - id: trim_open_end
    type:
      - 'null'
      - string
    doc: trim INT1-bp from an open end if DP below INT2
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_simplify.out
