cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BandageNG
  - reduce
label: bandage_ng_reduce
doc: "Save a subgraph of a larger graph. Bandage reduce takes an input graph and saves\
  \ a reduced subgraph using the graph scope settings. The saved graph will be in\
  \ GFA format.\n\nTool homepage: https://github.com/asl/BandageNG"
inputs:
  - id: inputgraph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 2
  - id: outputgraph
    type: string
    doc: The filename for the GFA graph to be made (if it does not end in '.gfa',
      that extension will be added)
    inputBinding:
      position: 3
  - id: scope
    type:
      - 'null'
      - string
    doc: 'Graph scope, from one of the following options: entire, aroundnodes, aroundblast,
      depthrange, aroundcomponent'
    inputBinding:
      position: 1
      prefix: --scope
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Exact node name matching (default)
    inputBinding:
      position: 1
      prefix: --exact
  - id: partial
    type:
      - 'null'
      - boolean
    doc: Partial node name matching
    inputBinding:
      position: 1
      prefix: --partial
  - id: distance
    type:
      - 'null'
      - int
    doc: The number of node steps away to draw for the aroundnodes and aroundblast
      scopes (0 to 100)
    inputBinding:
      position: 1
      prefix: --distance
  - id: mindepth
    type:
      - 'null'
      - float
    doc: The minimum allowed depth for the depthrange scope [10]
    inputBinding:
      position: 1
      prefix: --mindepth
  - id: maxdepth
    type:
      - 'null'
      - float
    doc: The maximum allowed depth for the depthrange scope [100]
    inputBinding:
      position: 1
      prefix: --maxdepth
  - id: query
    type:
      - 'null'
      - File
    doc: A FASTA file of either nucleotide or protein sequences to be used as BLAST
      queries
    inputBinding:
      position: 1
      prefix: --query
  - id: nodes
    type:
      - 'null'
      - string
    doc: A comma-separated list of starting nodes for the aroundnodes and aroundcomponent
      scopes
    inputBinding:
      position: 1
      prefix: --nodes
  - id: path_names
    type:
      - 'null'
      - string
    doc: A comma-separated list of path names used as seeds for the aroundcomponent
      scope
    inputBinding:
      position: 1
      prefix: --path
  - id: walk
    type:
      - 'null'
      - string
    doc: A comma-separated list of walk names used as seeds for the aroundcomponent
      scope
    inputBinding:
      position: 1
      prefix: --walk
outputs:
  - id: reduced_graph
    type: File
    doc: Reduced graph in GFA format
    outputBinding:
      glob:
        - $(inputs.outputgraph)
        - $(inputs.outputgraph).gfa
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
