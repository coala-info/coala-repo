cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - cluster
label: lyner_cluster
doc: "Cluster cells based on their expression profiles.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Path to the input expression matrix (e.g., CSV, TSV).
    inputBinding:
      position: 1
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: Clustering algorithm to use (e.g., kmeans, leiden).
    inputBinding:
      position: 102
      prefix: --method
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: Number of clusters to generate (required for some methods).
    inputBinding:
      position: 102
      prefix: --n-clusters
  - id: random_state
    type:
      - 'null'
      - int
    doc: Seed for random number generator for reproducible results.
    inputBinding:
      position: 102
      prefix: --random-state
  - id: resolution
    type:
      - 'null'
      - float
    doc: Resolution parameter for Leiden clustering.
    inputBinding:
      position: 102
      prefix: --resolution
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save clustering results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
