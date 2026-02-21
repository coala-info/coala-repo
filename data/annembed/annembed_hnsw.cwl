cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - annembed
  - hnsw
label: annembed_hnsw
doc: "Build HNSW graph\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
inputs:
  - id: csv_file
    type: File
    doc: Input CSV file
    inputBinding:
      position: 101
      prefix: --csv
  - id: dist
    type: string
    doc: Distance type is required, must be one of "DistL1", "DistL2", "DistCosine"
      and "DistJeyffreys"
    inputBinding:
      position: 101
      prefix: --dist
  - id: ef
    type: int
    doc: Build factor ef_construct in HNSW
    inputBinding:
      position: 101
      prefix: --ef
  - id: knbn
    type: int
    doc: Number of k-nearest neighbours to be retrieved for embedding
    inputBinding:
      position: 101
      prefix: --knbn
  - id: nbconn
    type: int
    doc: Maximum number of build connections allowed (M in HNSW)
    inputBinding:
      position: 101
      prefix: --nbconn
  - id: scale_modify_f
    type:
      - 'null'
      - float
    doc: Hierarchy scale modification factor in HNSW, must be in [0.2,1]
    default: 1.0
    inputBinding:
      position: 101
      prefix: --scale_modify_f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annembed:0.2.6--h3dc2dae_0
stdout: annembed_hnsw.out
