cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unifeb
  - hnsw
label: unifeb_hnsw
doc: "Build HNSW/HubNSW graph\n\nTool homepage: https://github.com/jianshu93/unifeb.git"
inputs:
  - id: ef
    type: int
    doc: Search factor for HNSW construction
    inputBinding:
      position: 101
      prefix: --ef
  - id: feature_table
    type: string
    doc: featuretable
    inputBinding:
      position: 101
      prefix: --feature-table
  - id: knbn
    type: int
    doc: Number of neighbours to keep in final adjacency
    inputBinding:
      position: 101
      prefix: --knbn
  - id: nbconn
    type: int
    doc: Number of neighbours by layer
    inputBinding:
      position: 101
      prefix: --nbconn
  - id: scale_modify_f
    type:
      - 'null'
      - float
    doc: scale modification factor in HNSW or HubNSW, must be in [0.2,1]
    default: 0.25
    inputBinding:
      position: 101
      prefix: --scale_modify_f
  - id: tree
    type: string
    doc: tree
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0
stdout: unifeb_hnsw.out
