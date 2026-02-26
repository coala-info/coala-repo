cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi_clean
label: fermi_clean
doc: "Clean a de Bruijn graph\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_mog
    type: File
    doc: Input MOG file
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
    default: 0.7
    inputBinding:
      position: 102
      prefix: -d
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations
    default: 3
    inputBinding:
      position: 102
      prefix: -n
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
    default: 60
    inputBinding:
      position: 102
      prefix: -o
  - id: min_relative_overlap_ratio
    type:
      - 'null'
      - float
    doc: minimum relative overlap ratio
    default: 0.8
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
  - id: skip_bubble_simplification
    type:
      - 'null'
      - boolean
    doc: skip bubble simplification
    inputBinding:
      position: 102
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_clean.out
