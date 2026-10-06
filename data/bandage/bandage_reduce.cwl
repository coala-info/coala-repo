cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Bandage
  - reduce
label: bandage_reduce
doc: "Bandage reduce takes an input graph and saves a reduced subgraph using the graph\
  \ scope settings. The saved graph will be in GFA format.\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs:
  - id: inputgraph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 1
  - id: outputgraph
    type: string
    doc: The filename for the GFA graph to be made (if it does not end in '.gfa',
      that extension will be added)
    inputBinding:
      position: 2
  - id: scope
    type:
      - 'null'
      - string
    doc: 'Graph scope, from one of the following options: entire, aroundnodes, aroundblast,
      depthrange (default: entire)'
    inputBinding:
      position: 3
      prefix: --scope
  - id: nodes
    type:
      - 'null'
      - string
    doc: 'A comma-separated list of starting nodes for the aroundnodes scope (default:
      none)'
    inputBinding:
      position: 3
      prefix: --nodes
  - id: partial
    type:
      - 'null'
      - boolean
    doc: 'Use partial node name matching (default: exact node name matching)'
    inputBinding:
      position: 3
      prefix: --partial
  - id: distance
    type:
      - 'null'
      - int
    doc: 'The number of node steps away to draw for the aroundnodes and aroundblast
      scopes (0 to 100, default: 0)'
    inputBinding:
      position: 3
      prefix: --distance
  - id: mindepth
    type:
      - 'null'
      - float
    doc: 'The minimum allowed depth for the depthrange scope (0 to 1e+06, default:
      10)'
    inputBinding:
      position: 3
      prefix: --mindepth
  - id: maxdepth
    type:
      - 'null'
      - float
    doc: 'The maximum allowed depth for the depthrange scope (0 to 1e+06, default:
      100)'
    inputBinding:
      position: 3
      prefix: --maxdepth
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
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
