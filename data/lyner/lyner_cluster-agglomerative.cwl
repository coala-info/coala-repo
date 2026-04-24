cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - cluster-agglomerative
label: lyner_cluster-agglomerative
doc: "Agglomerative clustering of cells\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file (e.g. .mtx, .tsv, .csv)
    inputBinding:
      position: 1
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: Distance metric to use for clustering (e.g. euclidean, cosine)
    inputBinding:
      position: 102
      prefix: --distance-metric
  - id: linkage
    type:
      - 'null'
      - string
    doc: Linkage method to use for clustering (e.g. ward, average, complete, 
      single)
    inputBinding:
      position: 102
      prefix: --linkage
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: Number of clusters to find
    inputBinding:
      position: 102
      prefix: --n-clusters
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: random_state
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 102
      prefix: --random-state
  - id: resolution
    type:
      - 'null'
      - float
    doc: Resolution parameter for Louvain clustering (if applicable)
    inputBinding:
      position: 102
      prefix: --resolution
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster-agglomerative.out
