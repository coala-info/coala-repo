cwlVersion: v1.2
class: CommandLineTool
baseCommand: hcluster_sg
label: hcluster_sg
doc: Hierarchically clustering on a sparse graph
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 1
  - id: breaking_edge_density
    type:
      - 'null'
      - float
    doc: breaking edge density
    inputBinding:
      position: 102
      prefix: -b
  - id: category_file
    type:
      - 'null'
      - File
    doc: category file
    inputBinding:
      position: 102
      prefix: -C
  - id: max_size
    type:
      - 'null'
      - int
    doc: maximum size
    inputBinding:
      position: 102
      prefix: -m
  - id: min_edge_density
    type:
      - 'null'
      - float
    doc: minimum edge density between a join
    inputBinding:
      position: 102
      prefix: -s
  - id: min_edge_weight
    type:
      - 'null'
      - float
    doc: minimum edge weight
    inputBinding:
      position: 102
      prefix: -w
  - id: once_fail_inactive_forever
    type:
      - 'null'
      - boolean
    doc: the once-fail-inactive-forever mode
    inputBinding:
      position: 102
      prefix: -O
  - id: single_linkage_only
    type:
      - 'null'
      - boolean
    doc: only find single-linkage clusters (bypass h-cluster)
    inputBinding:
      position: 102
      prefix: -c
  - id: stringent_level
    type:
      - 'null'
      - int
    doc: stringent level ('3' is the strictest)
    inputBinding:
      position: 102
      prefix: -L
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: -v
  - id: weight_resolution
    type:
      - 'null'
      - int
    doc: weight resolution for '-O'
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hcluster_sg:0.5.1--h7d875b9_4
