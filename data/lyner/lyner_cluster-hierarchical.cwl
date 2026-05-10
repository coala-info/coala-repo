cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - cluster-hierarchical
label: lyner_cluster-hierarchical
doc: "Hierarchical clustering of samples.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input
    type: File
    doc: Input matrix file
    inputBinding:
      position: 1
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: "Distance metric to use. Options: 'euclidean', 'manhattan', 'correlation',
      'cosine'"
    inputBinding:
      position: 102
      prefix: --distance-metric
  - id: method
    type:
      - 'null'
      - string
    doc: "Clustering method to use. Options: 'average', 'complete', 'centroid', 'ward'"
    inputBinding:
      position: 102
      prefix: --method
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: Number of clusters to form
    inputBinding:
      position: 102
      prefix: --n-clusters
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate and save dendrogram plot
    inputBinding:
      position: 102
      prefix: --plot
  - id: plot_dpi
    type:
      - 'null'
      - int
    doc: DPI of the dendrogram plot
    inputBinding:
      position: 102
      prefix: --plot-dpi
  - id: plot_height
    type:
      - 'null'
      - int
    doc: Height of the dendrogram plot in inches
    inputBinding:
      position: 102
      prefix: --plot-height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: Width of the dendrogram plot in inches
    inputBinding:
      position: 102
      prefix: --plot-width
  - id: output_clusters_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_clusters_path`
    inputBinding:
      position: 103
      prefix: --output-clusters
  - id: output_tree_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_tree_path`
    inputBinding:
      position: 104
      prefix: --output-tree
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Output tree file
    outputBinding:
      glob: $(inputs.output_tree_path)
  - id: output_clusters
    type:
      - 'null'
      - File
    doc: Output clusters file
    outputBinding:
      glob: $(inputs.output_clusters_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
