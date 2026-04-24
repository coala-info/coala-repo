cwlVersion: v1.2
class: CommandLineTool
baseCommand: halla
label: halla
doc: "HAllA: Hierarchical All-against-All significance association testing version
  0.8.40\n\nTool homepage: http://huttenhower.sph.harvard.edu/halla"
inputs:
  - id: block_num
    type:
      - 'null'
      - int
    doc: Number of top clusters to show (for hallagram only); if -1, show all 
      clusters
    inputBinding:
      position: 101
      prefix: --block_num
  - id: cbar_label
    type:
      - 'null'
      - string
    doc: 'Hallagram/clustermap: label for the colorbar'
    inputBinding:
      position: 101
      prefix: --cbar_label
  - id: disable_bypass_discretization_if_possible
    type:
      - 'null'
      - boolean
    doc: Disable bypassing discretization when all features are continuous
    inputBinding:
      position: 101
      prefix: --disable_bypass_discretization_if_possible
  - id: disable_permute_speedup
    type:
      - 'null'
      - boolean
    doc: Disable breaking early in the permutation test if p-value is 
      insignificant
    inputBinding:
      position: 101
      prefix: --disable_permute_speedup
  - id: disable_verbose
    type:
      - 'null'
      - boolean
    doc: Disable verbose
    inputBinding:
      position: 101
      prefix: --disable_verbose
  - id: discretize_func
    type:
      - 'null'
      - string
    doc: Discretization - function {None, quantile, kmeans, uniform, jenks}
    inputBinding:
      position: 101
      prefix: --discretize_func
  - id: discretize_num_bins
    type:
      - 'null'
      - int
    doc: Discretization - number of bins
    inputBinding:
      position: 101
      prefix: --discretize_num_bins
  - id: dont_copy
    type:
      - 'null'
      - boolean
    doc: Don't make a copy of the data files in the output directory
    inputBinding:
      position: 101
      prefix: --dont_copy
  - id: dont_skip_large_blocks
    type:
      - 'null'
      - boolean
    doc: Don't skip very large (>45 features) blocks in diagnostic plots
    inputBinding:
      position: 101
      prefix: --dont_skip_large_blocks
  - id: fdr_alpha
    type:
      - 'null'
      - float
    doc: FDR threshold
    inputBinding:
      position: 101
      prefix: --fdr_alpha
  - id: fdr_method
    type:
      - 'null'
      - string
    doc: FDR method - check statsmodels.stats.multitest.multipletests()
    inputBinding:
      position: 101
      prefix: --fdr_method
  - id: fnr_thresh
    type:
      - 'null'
      - float
    doc: FNR threshold
    inputBinding:
      position: 101
      prefix: --fnr_thresh
  - id: force_permutations
    type:
      - 'null'
      - boolean
    doc: If turned on, force permutation testing
    inputBinding:
      position: 101
      prefix: --force_permutations
  - id: generate_clustermap
    type:
      - 'null'
      - boolean
    doc: Generates clustermap
    inputBinding:
      position: 101
      prefix: --clustermap
  - id: generate_diagnostic_plot
    type:
      - 'null'
      - boolean
    doc: Generates diagnostic plot
    inputBinding:
      position: 101
      prefix: --diagnostic_plot
  - id: generate_hallagram
    type:
      - 'null'
      - boolean
    doc: Generates hallagram
    inputBinding:
      position: 101
      prefix: --hallagram
  - id: gini_uncertainty_level
    type:
      - 'null'
      - float
    doc: Gini uncertainty mode opts to split larger hierarchical branches when 
      the difference in Gini impurity improvement is less than the given level.
    inputBinding:
      position: 101
      prefix: --gini_uncertainty_level
  - id: large_diagnostic_subset
    type:
      - 'null'
      - int
    doc: Subset the feature pairs plotted in large block (>15, <45) diagnostic 
      plots.
    inputBinding:
      position: 101
      prefix: --large_diagnostic_subset
  - id: linkage_method
    type:
      - 'null'
      - string
    doc: Hierarchical clustering linkage method - check 
      scipy.cluster.hierarchy.linkage()
    inputBinding:
      position: 101
      prefix: --linkage_method
  - id: max_freq_thresh
    type:
      - 'null'
      - float
    doc: The maximum frequency threshold - features with max frequences >= the 
      threshold will be removed
    inputBinding:
      position: 101
      prefix: --max_freq_thresh
  - id: no_hallagram
    type:
      - 'null'
      - boolean
    doc: Turn off the automatically generated hallagram
    inputBinding:
      position: 101
      prefix: --no_hallagram
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Turn off the progress bar for p-value table calculations
    inputBinding:
      position: 101
      prefix: --no_progress
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use when running permutation tests in parallel, 
      default=4
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: pdist_metric
    type:
      - 'null'
      - string
    doc: Distance/similarity metric {spearman, pearson, dcor, mi, nmi, xicor}
    inputBinding:
      position: 101
      prefix: --pdist_metric
  - id: permute_func
    type:
      - 'null'
      - string
    doc: P-value approximation function in the p-value permutation test
    inputBinding:
      position: 101
      prefix: --permute_func
  - id: permute_iters
    type:
      - 'null'
      - int
    doc: '# iterations in the p-value permutation test'
    inputBinding:
      position: 101
      prefix: --permute_iters
  - id: plot_file_type
    type:
      - 'null'
      - string
    doc: File type of hallagram output
    inputBinding:
      position: 101
      prefix: --plot_file_type
  - id: rank_cluster
    type:
      - 'null'
      - string
    doc: Procedure to rank cluster using the p-values within the cluster {best, 
      average}
    inputBinding:
      position: 101
      prefix: --rank_cluster
  - id: seed
    type:
      - 'null'
      - int
    doc: Randomization seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: sim2dist_disable_abs
    type:
      - 'null'
      - boolean
    doc: Hierarchical clustering - disable setting similarity scores as absolute
      when computing distance
    inputBinding:
      position: 101
      prefix: --sim2dist_disable_abs
  - id: splitting_diagnostic_mode
    type:
      - 'null'
      - boolean
    doc: Diagnostic mode to write out tree descent algorithm progress. Prints 
      branches being considered at each step and Gini score improvement (the 
      latter only if applicable). Values listed in brackets are indices 
      (0-indexed) of features in X and Y datasets respectively.
    inputBinding:
      position: 101
      prefix: --splitting_diagnostic_mode
  - id: transform_data_funcs
    type:
      - 'null'
      - type: array
        items: string
    doc: Continuous data transformation function - a list
    inputBinding:
      position: 101
      prefix: --transform_data_funcs
  - id: trim
    type:
      - 'null'
      - float
    doc: Trim hallagram to features containing at least one significant block
    inputBinding:
      position: 101
      prefix: --trim
  - id: use_alla
    type:
      - 'null'
      - boolean
    doc: Use AllA instead of HAllA
    inputBinding:
      position: 101
      prefix: --alla
  - id: x_dataset_label
    type:
      - 'null'
      - string
    doc: 'Hallagram/clustermap: label for X dataset'
    inputBinding:
      position: 101
      prefix: --x_dataset_label
  - id: x_file
    type: File
    doc: 'Path to X dataset: a tab-delimited input file, one row per feature, one
      column per measurement'
    inputBinding:
      position: 101
      prefix: --x_file
  - id: y_dataset_label
    type:
      - 'null'
      - string
    doc: 'Hallagram/clustermap: label for Y dataset'
    inputBinding:
      position: 101
      prefix: --y_dataset_label
  - id: y_file
    type:
      - 'null'
      - File
    doc: 'Path to Y dataset: a tab-delimited input file, one row per feature, one
      column per measurement'
    inputBinding:
      position: 101
      prefix: --y_file
outputs:
  - id: out_dir
    type: Directory
    doc: Directory path to store results
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halla:0.8.40--pyhdfd78af_0
