cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
label: poppunk_fit-model
doc: "Fit a model (bgmm, dbscan, refine, lineage or threshold) to a QCed PopPUNK reference\
  \ database and assign clusters (poppunk --fit-model).\n\nTool homepage: https://github.com/johnlees/PopPUNK"
arguments: []
inputs:
  - id: fit_model
    type: string
    doc: 'Model to fit: bgmm, dbscan, refine, lineage or threshold.'
    inputBinding:
      position: 100
      prefix: --fit-model
  - id: ref_db
    type: Directory
    doc: Reference database folder made by --create-db (holds <name>.h5 and <name>.dists.*).
    inputBinding:
      position: 101
      prefix: --ref-db
  - id: output
    type: string
    doc: Output folder (prefix for output files).
    default: poppunk_fit
    inputBinding:
      position: 101
      prefix: --output
  - id: model_subsample
    type:
      - 'null'
      - int
    doc: Number of pairwise distances used to fit model [default = 100000].
    inputBinding:
      position: 101
      prefix: --model-subsample
  - id: assign_subsample
    type:
      - 'null'
      - int
    doc: Number of pairwise distances in each assignment batch [default = 5000].
    inputBinding:
      position: 101
      prefix: --assign-subsample
  - id: for_refine
    type:
      - 'null'
      - boolean
    doc: Fit a BGMM or DBSCAN model without assigning all points to initialise a refined model.
    inputBinding:
      position: 101
      prefix: --for-refine
  - id: K
    type:
      - 'null'
      - int
    doc: Maximum number of mixture components [default = 2].
    inputBinding:
      position: 101
      prefix: --K
  - id: D
    type:
      - 'null'
      - int
    doc: Maximum number of clusters in DBSCAN fitting [default = 100].
    inputBinding:
      position: 101
      prefix: --D
  - id: min_cluster_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of points in a cluster in DBSCAN fitting [default = 0.0001].
    inputBinding:
      position: 101
      prefix: --min-cluster-prop
  - id: threshold
    type:
      - 'null'
      - float
    doc: Cutoff if using --fit-model threshold.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: pos_shift
    type:
      - 'null'
      - float
    doc: Maximum amount to move the boundary right past between-strain mean.
    inputBinding:
      position: 101
      prefix: --pos-shift
  - id: neg_shift
    type:
      - 'null'
      - float
    doc: Maximum amount to move the boundary left past within-strain mean.
    inputBinding:
      position: 101
      prefix: --neg-shift
  - id: manual_start
    type:
      - 'null'
      - File
    doc: A file containing information for a start point (refine).
    inputBinding:
      position: 101
      prefix: --manual-start
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the model to refine [default = reference database directory].
    inputBinding:
      position: 101
      prefix: --model-dir
  - id: score_idx
    type:
      - 'null'
      - int
    doc: Index of score to use (0, 1 or 2) [default = 0].
    inputBinding:
      position: 101
      prefix: --score-idx
  - id: summary_sample
    type:
      - 'null'
      - int
    doc: Number of sequences used to estimate graph properties [default = all].
    inputBinding:
      position: 101
      prefix: --summary-sample
  - id: betweenness_sample
    type:
      - 'null'
      - int
    doc: Number of sequences used to estimate betweeness with a GPU [default = 100].
    inputBinding:
      position: 101
      prefix: --betweenness-sample
  - id: unconstrained
    type:
      - 'null'
      - boolean
    doc: Optimise both boundary gradient and intercept.
    inputBinding:
      position: 101
      prefix: --unconstrained
  - id: multi_boundary
    type:
      - 'null'
      - int
    doc: Produce multiple sets of clusters at different boundary positions; number of boundary
      positions between n-1 clusters and the refine optimum.
    inputBinding:
      position: 101
      prefix: --multi-boundary
  - id: indiv_refine
    type:
      - 'null'
      - string
    doc: 'Also run refinement for core and accessory individually: both, core or accessory.'
    inputBinding:
      position: 101
      prefix: --indiv-refine
  - id: ranks
    type:
      - 'null'
      - string
    doc: Comma separated list of ranks used in lineage clustering [default = 1,2,3].
    inputBinding:
      position: 101
      prefix: --ranks
  - id: count_unique_distances
    type:
      - 'null'
      - boolean
    doc: kNN enumerates number of unique distances rather than number of neighbours.
    inputBinding:
      position: 101
      prefix: --count-unique-distances
  - id: reciprocal_only
    type:
      - 'null'
      - boolean
    doc: Only use reciprocal kNN matches for lineage definitions.
    inputBinding:
      position: 101
      prefix: --reciprocal-only
  - id: max_search_depth
    type:
      - 'null'
      - int
    doc: Number of kNN distances per sequence to filter when counting neighbours or using
      only reciprocal matches.
    inputBinding:
      position: 101
      prefix: --max-search-depth
  - id: write_lineage_networks
    type:
      - 'null'
      - boolean
    doc: Save all lineage networks.
    inputBinding:
      position: 101
      prefix: --write-lineage-networks
  - id: use_accessory
    type:
      - 'null'
      - boolean
    doc: Use accessory distances for lineage definitions [default = use core distances].
    inputBinding:
      position: 101
      prefix: --use-accessory
  - id: lineage_resolution
    type:
      - 'null'
      - float
    doc: Minimum genetic separation between isolates required to initiate a new lineage.
    inputBinding:
      position: 101
      prefix: --lineage-resolution
  - id: external_clustering
    type:
      - 'null'
      - File
    doc: File with cluster definitions or other labels generated with any other method.
    inputBinding:
      position: 101
      prefix: --external-clustering
  - id: graph_weights
    type:
      - 'null'
      - boolean
    doc: Save within-strain Euclidean distances into the graph.
    inputBinding:
      position: 101
      prefix: --graph-weights
  - id: gpu_model
    type:
      - 'null'
      - boolean
    doc: Use a GPU when fitting a model.
    inputBinding:
      position: 101
      prefix: --gpu-model
  - id: gpu_graph
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating networks.
    inputBinding:
      position: 101
      prefix: --gpu-graph
  - id: deviceid
    type:
      - 'null'
      - int
    doc: CUDA device ID, if using GPU [default = 0].
    inputBinding:
      position: 101
      prefix: --deviceid
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Switch off model plotting, which can be slow for large datasets.
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: no_local
    type:
      - 'null'
      - boolean
    doc: Do not perform the local optimization step in model refinement (speed up on very
      large datasets).
    inputBinding:
      position: 101
      prefix: --no-local
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use [default = 1].
    inputBinding:
      position: 101
      prefix: --threads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing database files.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
