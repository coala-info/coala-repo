cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicClusterMinHashHyperopt
label: schicexplorer_scHicClusterMinHashHyperopt
doc: "Optimizes the parameters of scHicClusterMinHash with hyperopt to match a given cell type or cell cycle annotation.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The matrix to optimize the clustering on."
    inputBinding:
      position: 101
      prefix: --matrix
  - id: cell_color
    type: File
    doc: "The file with the associated cell types or cell cycle stages."
    inputBinding:
      position: 101
      prefix: --cellColor
  - id: method
    type: string
    doc: "Method to optimize by hyperopt: random tree, tpe, adaptive tpe (random, tpe, atpe)"
    inputBinding:
      position: 101
      prefix: --method
  - id: runs
    type:
      - 'null'
      - int
    doc: "Number of runs of hyperopt."
    inputBinding:
      position: 101
      prefix: --runs
  - id: nearest_neighbors
    type:
      - 'null'
      - int
    doc: "Number of nearest neighbors."
    inputBinding:
      position: 101
      prefix: --nearestNeighbors
  - id: number_of_hashfunctions
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of hash functions range: start, stop, stepsize (Default: (1000, 20000, 1000))."
    inputBinding:
      position: 101
      prefix: --numberOfHashfunctions
  - id: number_of_clusters
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of cluster range: start, stop (Default: (6, 15))."
    inputBinding:
      position: 101
      prefix: --numberOfClusters
  - id: number_pca_dimensions
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of PCA range: start, stop, stepsize (Default: (30, 60, 1))."
    inputBinding:
      position: 101
      prefix: --numberPCADimensions
  - id: umap_number_of_neighbors
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of umap neighbors range: start, stop, stepsize (Default: (30, 60, 1))."
    inputBinding:
      position: 101
      prefix: --umap_numberOfNeighbors
  - id: umap_n_components
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of umap n_components range: start, stop, stepsize (Default: (2, 10, 1))."
    inputBinding:
      position: 101
      prefix: --umap_n_components
  - id: umap_min_dist
    type:
      - 'null'
      - type: array
        items: float
    doc: "Number of umap min_dist range: start, stop (Default: (0.0, 0.5))."
    inputBinding:
      position: 101
      prefix: --umap_min_dist
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_file_name_path
    type:
      - 'null'
      - string
    doc: "File names for the result of the optimization (Default: hyperoptMinHash_result.txt)."
    inputBinding:
      position: 102
      prefix: --outputFileName
outputs:
  - id: output_file_name
    type:
      - 'null'
      - File
    doc: "Result of the optimization"
    outputBinding:
      glob: "$(inputs.output_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
