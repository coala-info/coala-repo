cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cdbg-ops
  - dist
label: unitig-counter_cdbg-ops_dist
doc: "cdbg-ops dist: Calculate distance between two nodes of the compacted de Bruijn graph made by unitig-counter.\n\nTool homepage: https://github.com/johnlees/unitig-counter"
inputs:
  - id: nodes
    type: File
    doc: Name of .node file
    inputBinding:
      position: 101
      prefix: --nodes
  - id: edges
    type: File
    doc: Name of .edges.dbg file
    inputBinding:
      position: 101
      prefix: --edges
  - id: source
    type:
      - 'null'
      - string
    doc: Sequence of source node
    inputBinding:
      position: 101
      prefix: --source
  - id: source_list
    type:
      - 'null'
      - File
    doc: File containing sequences of source nodes
    inputBinding:
      position: 101
      prefix: --source-list
  - id: target
    type:
      - 'null'
      - string
    doc: Sequence of target node
    inputBinding:
      position: 101
      prefix: --target
  - id: all
    type:
      - 'null'
      - boolean
    doc: Generate distances to all other unitigs
    inputBinding:
      position: 101
      prefix: --all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the distance table
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
stdout: unitig-counter_cdbg-ops_dist.out
