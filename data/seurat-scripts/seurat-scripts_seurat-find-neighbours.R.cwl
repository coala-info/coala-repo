cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-neighbours.R
label: seurat-scripts_seurat-find-neighbours.R
doc: 'Build a shared nearest neighbour graph from a Seurat object (Seurat FindNeighbors).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 4
      prefix: --output-format=
      separate: false
  - id: distance_matrix
    type:
      - 'null'
      - boolean
    doc: Boolean value of whether the provided matrix is a distance matrix; note, for objects of class dist, this parameter will be set automatically.
    inputBinding:
      position: 5
      prefix: --distance-matrix
  - id: k_param
    type:
      - 'null'
      - int
    doc: Defines k for the k-nearest neighbor algorithm
    inputBinding:
      position: 6
      prefix: --k-param=
      separate: false
  - id: no_compute_snn
    type:
      - 'null'
      - boolean
    doc: Avoid computing the shared nearest neighbor graph. Default is to have it computed.
    inputBinding:
      position: 7
      prefix: --no-compute-snn
  - id: prune_snn
    type:
      - 'null'
      - float
    doc: Sets the cutoff for acceptable Jaccard index when computing the neighborhood overlap for the SNN construction. Any edges with values less than or equal to this will be set to 0 and removed from the SNN graph. Essentially sets the strigency of pruning (0 --- no pruning, 1 --- prune everything).
    inputBinding:
      position: 8
      prefix: --prune-snn=
      separate: false
  - id: nn_method
    type:
      - 'null'
      - string
    doc: 'Method for nearest neighbor finding. Options include: rann (default), annoy'
    inputBinding:
      position: 9
      prefix: --nn-method=
      separate: false
  - id: annoy_metric
    type:
      - 'null'
      - string
    doc: 'Distance metric for annoy. Options include: euclidean (default), cosine, manhattan, and hamming'
    inputBinding:
      position: 10
      prefix: --annoy-metric=
      separate: false
  - id: graph_name
    type:
      - 'null'
      - string
    doc: Name of graph to use for the clustering algorithm.
    inputBinding:
      position: 11
      prefix: --graph-name=
      separate: false
  - id: nn_eps
    type:
      - 'null'
      - float
    doc: Error bound when performing nearest neighbor seach using RANN; default of 0.0 implies exact nearest neighbor search
    inputBinding:
      position: 12
      prefix: --nn-eps=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Maximal number of iterations per random start
    inputBinding:
      position: 13
      prefix: --verbose
  - id: force_recalc
    type:
      - 'null'
      - boolean
    doc: Force recalculation of SNN
    inputBinding:
      position: 14
      prefix: --force-recalc
  - id: features
    type:
      - 'null'
      - string
      - File
    doc: Comma-separated list of genes to use for building SNN. Alternatively, text file with one gene per line.
    inputBinding:
      position: 15
      prefix: --features=
      separate: false
  - id: reduction
    type:
      - 'null'
      - string
    doc: Reduction to use as input for building the SNN
    inputBinding:
      position: 16
      prefix: --reduction=
      separate: false
  - id: dims
    type:
      - 'null'
      - string
    doc: Dimensions of reduction to use as input. A comma-separated list of the dimensions to use in construction of the SNN graph (e.g. To use the first 5 PCs, pass 1,2,3,4,5).
    inputBinding:
      position: 17
      prefix: --dims=
      separate: false
  - id: assay
    type:
      - 'null'
      - string
    doc: Assay to use in construction of SNN
    inputBinding:
      position: 18
      prefix: --assay=
      separate: false
  - id: do_plot
    type:
      - 'null'
      - boolean
    doc: Plot SNN graph on tSNE coordinates
    inputBinding:
      position: 19
      prefix: --do-plot
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
