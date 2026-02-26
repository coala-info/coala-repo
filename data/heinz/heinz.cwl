cwlVersion: v1.2
class: CommandLineTool
baseCommand: heinz
label: heinz
doc: "heinz is a tool for graph analysis and optimization. It supports various formulations
  for network flow and cut problems, with options for enumeration, preprocessing,
  and verbosity control.\n\nTool homepage: https://github.com/ls-cwi/heinz"
inputs:
  - id: a
    type:
      - 'null'
      - float
    doc: Specifies a
    inputBinding:
      position: 101
      prefix: -a
  - id: edge_list_file
    type:
      - 'null'
      - File
    doc: Edge list file
    inputBinding:
      position: 101
      prefix: -e
  - id: enable_preprocessing
    type:
      - 'null'
      - boolean
    doc: Enable preprocessing
    inputBinding:
      position: 101
      prefix: -p
  - id: enumeration_mode
    type:
      - 'null'
      - int
    doc: "Enumeration mode:\n     0 - No enumeration\n     1 - No root\n     2 - Fix
      root\n     3 - No root per component (default)"
    default: 3
    inputBinding:
      position: 101
      prefix: -enum
  - id: fdr
    type:
      - 'null'
      - float
    doc: Specifies fdr
    inputBinding:
      position: 101
      prefix: --FDR
  - id: formulation
    type:
      - 'null'
      - int
    doc: "Formulation of the problem:\n     0 - Single Commodity Flow\n     1 - Multi
      Commodity Flow\n     2 - Cut formulation (Flow)\n     3 - Cut formulation (Flow-min)\n\
      \     4 - Cut formulation (Node-separator)\n     5 - Cut formulation (Node-separator,
      BK, default)\n     6 - Tree DP\n     7 - Tree DP heuristic (fixed_edge)\n  \
      \   8 - Tree DP heuristic (random_edge)\n     9 - Tree DP heuristic (uniform_edge)"
    default: 5
    inputBinding:
      position: 101
      prefix: -f
  - id: lambda
    type:
      - 'null'
      - float
    doc: Specifies lambda
    inputBinding:
      position: 101
      prefix: -lambda
  - id: max_cuts
    type:
      - 'null'
      - int
    doc: "Specifies the maximum number of cuts per step\n     (only in conjuction
      with -f 2, optional, default: -1)"
    default: -1
    inputBinding:
      position: 101
      prefix: -maxCuts
  - id: node_file
    type:
      - 'null'
      - File
    doc: Node file
    inputBinding:
      position: 101
      prefix: -n
  - id: root_node
    type:
      - 'null'
      - string
    doc: Specifies the root node (optional)
    inputBinding:
      position: 101
      prefix: -r
  - id: stp_node_file
    type:
      - 'null'
      - File
    doc: STP node file
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Specifies number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -m
  - id: time_limit
    type:
      - 'null'
      - int
    doc: 'Time limit (in seconds, default: -1)'
    default: -1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Specifies the verbosity level:\n     0 - No output\n     1 - Only necessary
      output\n     2 - More verbose output (default)\n     3 - Debug output"
    default: 2
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heinz:2.0.1--h503566f_5
