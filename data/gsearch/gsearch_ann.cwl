cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch_ann
label: gsearch_ann
doc: "Approximate Nearest Neighbor Embedding using UMAP-like algorithm\n\nTool homepage:
  https://github.com/jean-pierreBoth/gsearch"
inputs:
  - id: embed
    type:
      - 'null'
      - boolean
    doc: --embed to do an embedding
    inputBinding:
      position: 101
      prefix: --embed
  - id: hnsw_dir
    type: Directory
    doc: directory containing hnsw
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: stats
    type:
      - 'null'
      - boolean
    doc: to get stats on nb neighbours
    inputBinding:
      position: 101
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_ann.out
