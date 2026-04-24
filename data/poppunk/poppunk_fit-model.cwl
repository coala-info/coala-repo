cwlVersion: v1.2
class: CommandLineTool
baseCommand: poppunk
label: poppunk_fit-model
doc: "PopPUNK (POPulation Partitioning Using Nucleotide Kmers)\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs:
  - id: D
    type:
      - 'null'
      - int
    doc: Maximum number of clusters in DBSCAN fitting
    inputBinding:
      position: 101
      prefix: --D
  - id: K
    type:
      - 'null'
      - int
    doc: Maximum number of mixture components
    inputBinding:
      position: 101
      prefix: --K
  - id: assign_subsample
    type:
      - 'null'
      - int
    doc: Number of pairwise distances in each assignment batch
    inputBinding:
      position: 101
      prefix: --assign-subsample
  - id: betweenness_sample
    type:
      - 'null'
      - int
    doc: Number of sequences used to estimate betweeness with a GPU
    inputBinding:
      position: 101
      prefix: --betweenness-sample
  - id: codon_phased
    type:
      - 'null'
      - boolean
    doc: Used codon phased seeds X--X--X
    inputBinding:
      position: 101
      prefix: --codon-phased
  - id: count_unique_distances
    type:
      - 'null'
      - boolean
    doc: kNN enumerates number of unique distances rather than number of 
      neighbours
    inputBinding:
      position: 101
      prefix: --count-unique-distances
  - id: create_db
    type:
      - 'null'
      - boolean
    doc: Create pairwise distances database between reference sequences
    inputBinding:
      position: 101
      prefix: --create-db
  - id: deviceid
    type:
      - 'null'
      - int
    doc: CUDA device ID, if using GPU
    inputBinding:
      position: 101
      prefix: --deviceid
  - id: distances
    type:
      - 'null'
      - File
    doc: Prefix of input pickle of pre-calculated distances
    inputBinding:
      position: 101
      prefix: --distances
  - id: exact_count
    type:
      - 'null'
      - boolean
    doc: Use the exact k-mer counter with reads
    inputBinding:
      position: 101
      prefix: --exact-count
  - id: external_clustering
    type:
      - 'null'
      - File
    doc: File with cluster definitions or other labels generated with any other 
      method.
    inputBinding:
      position: 101
      prefix: --external-clustering
  - id: fit_model
    type:
      - 'null'
      - string
    doc: Fit a model to a (QCed) reference database
    inputBinding:
      position: 101
      prefix: --fit-model
  - id: for_refine
    type:
      - 'null'
      - boolean
    doc: Fit a BGMM or DBSCAN model without assigning all points to initialise a
      refined model
    inputBinding:
      position: 101
      prefix: --for-refine
  - id: gpu_dist
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating distances
    inputBinding:
      position: 101
      prefix: --gpu-dist
  - id: gpu_graph
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating networks
    inputBinding:
      position: 101
      prefix: --gpu-graph
  - id: gpu_model
    type:
      - 'null'
      - boolean
    doc: Use a GPU when fitting a model
    inputBinding:
      position: 101
      prefix: --gpu-model
  - id: gpu_sketch
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating sketches (read data only)
    inputBinding:
      position: 101
      prefix: --gpu-sketch
  - id: graph_weights
    type:
      - 'null'
      - boolean
    doc: Save within-strain Euclidean distances into the graph
    inputBinding:
      position: 101
      prefix: --graph-weights
  - id: indiv_refine
    type:
      - 'null'
      - string
    doc: Also run refinement for core and accessory individually
    inputBinding:
      position: 101
      prefix: --indiv-refine
  - id: k_step
    type:
      - 'null'
      - int
    doc: K-mer step size
    inputBinding:
      position: 101
      prefix: --k-step
  - id: length_range
    type:
      - 'null'
      - type: array
        items: float
    doc: Allowed length range, outside of which sequences will be excluded [two 
      values needed - lower and upper bounds]
    inputBinding:
      position: 101
      prefix: --length-range
  - id: length_sigma
    type:
      - 'null'
      - float
    doc: Number of standard deviations of length distribution beyond which 
      sequences will be excluded
    inputBinding:
      position: 101
      prefix: --length-sigma
  - id: lineage_resolution
    type:
      - 'null'
      - float
    doc: Minimum genetic separation between isolates required to initiate a new 
      lineage
    inputBinding:
      position: 101
      prefix: --lineage-resolution
  - id: manual_start
    type:
      - 'null'
      - File
    doc: A file containing information for a start point. See documentation for 
      help.
    inputBinding:
      position: 101
      prefix: --manual-start
  - id: max_a_dist
    type:
      - 'null'
      - float
    doc: Maximum accessory distance to permit
    inputBinding:
      position: 101
      prefix: --max-a-dist
  - id: max_k
    type:
      - 'null'
      - int
    doc: Maximum kmer length
    inputBinding:
      position: 101
      prefix: --max-k
  - id: max_pi_dist
    type:
      - 'null'
      - float
    doc: Maximum core distance to permit
    inputBinding:
      position: 101
      prefix: --max-pi-dist
  - id: max_search_depth
    type:
      - 'null'
      - int
    doc: Number of kNN distances per sequence to filter when counting neighbours
      or using only reciprocal matches
    inputBinding:
      position: 101
      prefix: --max-search-depth
  - id: max_zero_dist
    type:
      - 'null'
      - float
    doc: Maximum proportion of zero distances to permit
    inputBinding:
      position: 101
      prefix: --max-zero-dist
  - id: min_cluster_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of points in a cluster in DBSCAN fitting
    inputBinding:
      position: 101
      prefix: --min-cluster-prop
  - id: min_k
    type:
      - 'null'
      - int
    doc: Minimum kmer length
    inputBinding:
      position: 101
      prefix: --min-k
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: Minimum k-mer count when using reads as input
    inputBinding:
      position: 101
      prefix: --min-kmer-count
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing model to use for assigning queries to clusters
    inputBinding:
      position: 101
      prefix: --model-dir
  - id: model_subsample
    type:
      - 'null'
      - int
    doc: Number of pairwise distances used to fit model
    inputBinding:
      position: 101
      prefix: --model-subsample
  - id: multi_boundary
    type:
      - 'null'
      - int
    doc: Produce multiple sets of clusters at different boundary positions. This
      argument sets thenumber of boundary positions between n-1 clusters and the
      refine optimum.
    inputBinding:
      position: 101
      prefix: --multi-boundary
  - id: neg_shift
    type:
      - 'null'
      - float
    doc: Maximum amount to move the boundary left past within-strain mean]
    inputBinding:
      position: 101
      prefix: --neg-shift
  - id: no_local
    type:
      - 'null'
      - boolean
    doc: Do not perform the local optimization step in model refinement (speed 
      up on very large datasets)
    inputBinding:
      position: 101
      prefix: --no-local
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Switch off model plotting, which can be slow for large datasets
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing database files
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: plot_fit
    type:
      - 'null'
      - int
    doc: Create this many plots of some fits relating k-mer to core/accessory 
      distances
    inputBinding:
      position: 101
      prefix: --plot-fit
  - id: pos_shift
    type:
      - 'null'
      - float
    doc: Maximum amount to move the boundary right past between-strain mean
    inputBinding:
      position: 101
      prefix: --pos-shift
  - id: prop_n
    type:
      - 'null'
      - float
    doc: Threshold ambiguous base proportion above which sequences will be 
      excluded
    inputBinding:
      position: 101
      prefix: --prop-n
  - id: qc_db
    type:
      - 'null'
      - boolean
    doc: Run quality control on a reference database
    inputBinding:
      position: 101
      prefix: --qc-db
  - id: qc_keep
    type:
      - 'null'
      - boolean
    doc: Only write failing sequences to a file, don't remove them from the 
      database file
    inputBinding:
      position: 101
      prefix: --qc-keep
  - id: r_files
    type:
      - 'null'
      - File
    doc: File listing reference input assemblies
    inputBinding:
      position: 101
      prefix: --r-files
  - id: ranks
    type:
      - 'null'
      - string
    doc: Comma separated list of ranks used in lineage clustering
    inputBinding:
      position: 101
      prefix: --ranks
  - id: reciprocal_only
    type:
      - 'null'
      - boolean
    doc: Only use reciprocal kNN matches for lineage definitions
    inputBinding:
      position: 101
      prefix: --reciprocal-only
  - id: ref_db
    type:
      - 'null'
      - Directory
    doc: Location of built reference database
    inputBinding:
      position: 101
      prefix: --ref-db
  - id: remove_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of names to remove from the database (regardless of any other 
      QC)
    inputBinding:
      position: 101
      prefix: --remove-samples
  - id: retain_failures
    type:
      - 'null'
      - boolean
    doc: Retain sketches of genomes that do not pass QC filters in separate 
      database
    inputBinding:
      position: 101
      prefix: --retain-failures
  - id: score_idx
    type:
      - 'null'
      - int
    doc: Index of score to use
    inputBinding:
      position: 101
      prefix: --score-idx
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Kmer sketch size
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: strand_preserved
    type:
      - 'null'
      - boolean
    doc: Treat input as being on the same strand, and ignore reverse complement 
      k-mers
    inputBinding:
      position: 101
      prefix: --strand-preserved
  - id: summary_sample
    type:
      - 'null'
      - int
    doc: Number of sequences used to estimate graph properties
    inputBinding:
      position: 101
      prefix: --summary-sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Cutoff if using --fit-model threshold
    inputBinding:
      position: 101
      prefix: --threshold
  - id: unconstrained
    type:
      - 'null'
      - boolean
    doc: Optimise both boundary gradient and intercept
    inputBinding:
      position: 101
      prefix: --unconstrained
  - id: upper_n
    type:
      - 'null'
      - float
    doc: Threshold ambiguous base count above which sequences will be excluded
    inputBinding:
      position: 101
      prefix: --upper-n
  - id: use_accessory
    type:
      - 'null'
      - boolean
    doc: Use accessory distances for lineage definitions
    inputBinding:
      position: 101
      prefix: --use-accessory
  - id: use_model
    type:
      - 'null'
      - boolean
    doc: Apply a fitted model to a reference database to restore database files
    inputBinding:
      position: 101
      prefix: --use-model
  - id: write_lineage_networks
    type:
      - 'null'
      - boolean
    doc: Save all lineage networks
    inputBinding:
      position: 101
      prefix: --write-lineage-networks
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
