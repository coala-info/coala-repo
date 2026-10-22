cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-run-umap.R
label: seurat-scripts_seurat-run-umap.R
doc: 'Run UMAP on a Seurat object (Seurat RunUMAP).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: Input file with Seurat object in either RDS-Seurat, Loom or SCE.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file_path
    type: string
    doc: File name in which to store the serialized Seurat object.
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
  - id: dims
    type:
      - 'null'
      - string
    doc: Which dimensions to use as input features, used only if list('features')  is NULL
    inputBinding:
      position: 4
      prefix: --dims=
      separate: false
  - id: reduction
    type:
      - 'null'
      - string
    doc: Which dimensional reduction (PCA or ICA) to use for the UMAP input. Default is PCA
    inputBinding:
      position: 5
      prefix: --reduction=
      separate: false
  - id: features
    type:
      - 'null'
      - string
    doc: Comma-separated list of features to use. If set, run UMAP on this subset of features (instead of running on a set of reduced dimensions). Not set (NULL) by default;  dims must be NULL to run on features
    inputBinding:
      position: 6
      prefix: --features=
      separate: false
  - id: graph
    type:
      - 'null'
      - string
    doc: Name of graph on which to run UMAP
    inputBinding:
      position: 7
      prefix: --graph=
      separate: false
  - id: assay
    type:
      - 'null'
      - string
    doc: Assay to pull data for when using  list('features') , or assay used to construct Graph if running UMAP on a Graph
    inputBinding:
      position: 8
      prefix: --assay=
      separate: false
  - id: nn_name
    type:
      - 'null'
      - string
    doc: Name of knn output on which to run UMAP
    inputBinding:
      position: 9
      prefix: --nn.name=
      separate: false
  - id: slot
    type:
      - 'null'
      - string
    doc: The slot used to pull data for when using  list('features') . data slot is by default.
    inputBinding:
      position: 10
      prefix: --slot=
      separate: false
  - id: umap_method
    type:
      - 'null'
      - string
    doc: UMAP implementation to run. Can be list uwot, uwot-learn, umap-learn (rquires python umap-learn package).
    inputBinding:
      position: 11
      prefix: --umap.method=
      separate: false
  - id: reduction_model
    type:
      - 'null'
      - string
    doc: list('DimReduc')  object that contains the umap model
    inputBinding:
      position: 12
      prefix: --reduction.model=
      separate: false
  - id: return_model
    type:
      - 'null'
      - boolean
    doc: whether UMAP will return the uwot model
    inputBinding:
      position: 13
      prefix: --return.model
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: This determines the number of neighboring points used in local approximations of manifold structure. Larger values will result in more global structure being preserved at the loss of detailed local structure. In general this parameter should often be in the range 5 to 50.
    inputBinding:
      position: 14
      prefix: --n.neighbors=
      separate: false
  - id: n_components
    type:
      - 'null'
      - int
    doc: The dimension of the space to embed into.
    inputBinding:
      position: 15
      prefix: --n.components=
      separate: false
  - id: metric
    type:
      - 'null'
      - string
    doc: 'metric: This determines the choice of metric used to measure distance in the input space. A wide variety of metrics are already coded, and a user defined function can be passed as long as it has been JITd by numba.'
    inputBinding:
      position: 16
      prefix: --metric=
      separate: false
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: The number of training epochs to be used in optimizing the low dimensional embedding. Larger values result in more accurate embeddings. If NULL is specified, a value will be selected based on the size of the input dataset (200 for large datasets, 500 for small).
    inputBinding:
      position: 17
      prefix: --n.epochs=
      separate: false
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: The initial learning rate for the embedding optimization.
    inputBinding:
      position: 18
      prefix: --learning.rate=
      separate: false
  - id: min_dist
    type:
      - 'null'
      - float
    doc: This controls how tightly the embedding is allowed compress points together. Larger values ensure embedded points are moreevenly distributed, while smaller values allow the algorithm to optimise more accurately with regard to local structure. Sensible values are in the range 0.001 to 0.5.
    inputBinding:
      position: 19
      prefix: --min.dist=
      separate: false
  - id: spread
    type:
      - 'null'
      - float
    doc: The effective scale of embedded points. In combination with min.dist this determines how clustered/clumped the embedded points are.
    inputBinding:
      position: 20
      prefix: --spread=
      separate: false
  - id: set_op_mix_ratio
    type:
      - 'null'
      - float
    doc: Interpolate between (fuzzy) union and intersection as the set operation used to combine local fuzzy simplicial sets to obtain a global fuzzy simplicial sets. Both fuzzy set operations use the product t-norm. The value of this parameter should be between 0.0 and 1.0; a value of 1.0 will use a pure fuzzy union, while 0.0 will use a pure fuzzy intersection.
    inputBinding:
      position: 21
      prefix: --set.op.mix.ratio=
      separate: false
  - id: local_connectivity
    type:
      - 'null'
      - int
    doc: The local connectivity required - i.e. the number of nearest neighbors that should be assumed to be connected at a local level. The higher this value the more connected the manifold becomes locally. In practice this should be not more than the local intrinsic dimension of the manifold.
    inputBinding:
      position: 22
      prefix: --local.connectivity=
      separate: false
  - id: repulsion_strength
    type:
      - 'null'
      - float
    doc: Weighting applied to negative samples in low dimensional embedding optimization. Values higher than one will result in greater weight being given to negative samples.
    inputBinding:
      position: 23
      prefix: --repulsion.strength=
      separate: false
  - id: negative_sample_rate
    type:
      - 'null'
      - int
    doc: The number of negative samples to select per positive sample in the optimization process. Increasing this value will result in greater repulsive force being applied, greater optimization cost, but slightly more accuracy.
    inputBinding:
      position: 24
      prefix: --negative.sample.rate=
      separate: false
  - id: a
    type:
      - 'null'
      - float
    doc: More specific parameters controlling the embedding. If NULL, these values are set automatically as determined by min. dist and spread. Parameter of differentiable approximation of right adjoint functor.
    inputBinding:
      position: 25
      prefix: --a=
      separate: false
  - id: b
    type:
      - 'null'
      - float
    doc: More specific parameters controlling the embedding. If NULL, these values are set automatically as determined by min. dist and spread. Parameter of differentiable approximation of right adjoint functor.
    inputBinding:
      position: 26
      prefix: --b=
      separate: false
  - id: uwot_sgd
    type:
      - 'null'
      - boolean
    doc: Set list('uwot::umap(fast_sgd = TRUE)') ; see  list('umap')  for more details
    inputBinding:
      position: 27
      prefix: --uwot.sgd
  - id: seed_use
    type:
      - 'null'
      - int
    doc: Set a random seed. By default, sets the seed to 42. Setting NULL will not set a seed
    inputBinding:
      position: 28
      prefix: --seed.use=
      separate: false
  - id: metric_kwds
    type:
      - 'null'
      - string
    doc: A dictionary of arguments to pass on to the metric, such as the p value for Minkowski distance. If NULL then no arguments are passed on.
    inputBinding:
      position: 29
      prefix: --metric.kwds=
      separate: false
  - id: angular_rp_forest
    type:
      - 'null'
      - boolean
    doc: Whether to use an angular random projection forest to initialise the approximate nearest neighbor search. This can be faster, but is mostly on useful for metric that use an angular style distance such as cosine, correlation etc. In the case of those metrics angular forests will be chosen automatically.
    inputBinding:
      position: 30
      prefix: --angular.rp.forest
  - id: do_not_verbose
    type:
      - 'null'
      - boolean
    doc: Controls verbosity
    inputBinding:
      position: 31
      prefix: --do-not-verbose
  - id: reduction_name
    type:
      - 'null'
      - string
    doc: Name to store dimensional reduction under in the Seurat object
    inputBinding:
      position: 32
      prefix: --reduction.name=
      separate: false
  - id: reduction_key
    type:
      - 'null'
      - string
    doc: dimensional reduction key, specifies the string before the number for the dimension names. UMAP by default
    inputBinding:
      position: 33
      prefix: --reduction.key=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: FILE IN
    inputBinding:
      position: 34
      prefix: --output-format=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: The Seurat object with the UMAP reduction.
    outputBinding:
      glob: $(inputs.output_object_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
