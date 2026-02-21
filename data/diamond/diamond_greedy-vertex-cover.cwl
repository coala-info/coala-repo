cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - greedy-vertex-cover
label: diamond_greedy-vertex-cover
doc: "Greedy vertex cover clustering tool for DIAMOND\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: connected_component_depth
    type:
      - 'null'
      - int
    doc: Depth to cluster connected components
    inputBinding:
      position: 101
      prefix: --connected-component-depth
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: edge_format
    type:
      - 'null'
      - string
    doc: Edge format for greedy vertex cover (default/triplet)
    inputBinding:
      position: 101
      prefix: --edge-format
  - id: edges
    type:
      - 'null'
      - File
    doc: Input file for greedy vertex cover
    inputBinding:
      position: 101
      prefix: --edges
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: member_cover
    type:
      - 'null'
      - float
    doc: Minimum coverage% of the cluster member sequence
    default: 80.0
    inputBinding:
      position: 101
      prefix: --member-cover
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory limit in GB
    default: 16G
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: mutual_cover
    type:
      - 'null'
      - float
    doc: Minimum mutual coverage% of the cluster member and representative 
      sequence
    inputBinding:
      position: 101
      prefix: --mutual-cover
  - id: no_reassign
    type:
      - 'null'
      - boolean
    doc: Do not reassign to closest representative
    inputBinding:
      position: 101
      prefix: --no-reassign
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: symmetric
    type:
      - 'null'
      - boolean
    doc: Edges are symmetric
    inputBinding:
      position: 101
      prefix: --symmetric
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: centroid_out
    type:
      - 'null'
      - File
    doc: Output file for centroids
    outputBinding:
      glob: $(inputs.centroid_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
