cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyclone
  - run
label: phyclone_run
doc: "Run a new PhyClone analysis.\n\nTool homepage: https://github.com/Roth-Lab/PhyClone"
inputs:
  - id: assign_loss_prob
    type:
      - 'null'
      - boolean
    doc: "Whether to assign loss probability prior\n                             \
      \     from the cluster data. Note: This option is\n                        \
      \          incompatible with --user-provided-loss-prob"
    inputBinding:
      position: 101
      prefix: --assign-loss-prob
  - id: burnin
    type:
      - 'null'
      - int
    doc: "Number of burn-in iterations using\n                                  unconditional
      SMC sampler."
    inputBinding:
      position: 101
      prefix: --burnin
  - id: cluster_file
    type:
      - 'null'
      - File
    doc: "Path to file with pre-computed cluster\n                               \
      \   assignments of mutations."
    inputBinding:
      position: 101
      prefix: --cluster-file
  - id: concentration_update
    type:
      - 'null'
      - boolean
    doc: "Whether the concentration parameter should\n                           \
      \       be updated during sampling."
    inputBinding:
      position: 101
      prefix: --concentration-update
  - id: concentration_value
    type:
      - 'null'
      - float
    doc: "The (initial) concentration of the Dirichlet\n                         \
      \         process. Higher values will encourage more\n                     \
      \             clusters,  lower values have the opposite\n                  \
      \                effect."
    inputBinding:
      position: 101
      prefix: --concentration-value
  - id: density
    type:
      - 'null'
      - string
    doc: "Allele count density in the PyClone model.\n                           \
      \       Use beta-binomial for most cases."
    inputBinding:
      position: 101
      prefix: --density
  - id: grid_size
    type:
      - 'null'
      - int
    doc: "Grid size for discrete approximation. This\n                           \
      \       will numerically marginalise the cancer cell\n                     \
      \             fraction.  Higher values lead to more\n                      \
      \            accurate approximations at the expense of\n                   \
      \               run time."
    inputBinding:
      position: 101
      prefix: --grid-size
  - id: high_loss_prob
    type:
      - 'null'
      - float
    doc: "Higher loss probability setting.  Used when\n                          \
      \        allowing PhyClone to assign loss prior\n                          \
      \        probability from cluster data."
    inputBinding:
      position: 101
      prefix: --high-loss-prob
  - id: in_file
    type: File
    doc: "Path to TSV format file with copy number and allele count information for
      all samples.\n                                  See the examples directory in
      the GitHub\n                                  repository for format."
    inputBinding:
      position: 101
      prefix: --in-file
  - id: max_time
    type:
      - 'null'
      - float
    doc: Maximum running time in seconds.
    inputBinding:
      position: 101
      prefix: --max-time
  - id: no_assign_loss_prob
    type:
      - 'null'
      - boolean
    doc: "Whether to assign loss probability prior\n                             \
      \     from the cluster data. Note: This option is\n                        \
      \          incompatible with --user-provided-loss-prob"
    inputBinding:
      position: 101
      prefix: --no-assign-loss-prob
  - id: no_concentration_update
    type:
      - 'null'
      - boolean
    doc: "Whether the concentration parameter should\n                           \
      \       be updated during sampling."
    inputBinding:
      position: 101
      prefix: --no-concentration-update
  - id: no_user_provided_loss_prob
    type:
      - 'null'
      - boolean
    doc: "Whether to use user-provided cluster loss\n                            \
      \      probability prior from the cluster file.\n                          \
      \        Requires that the 'outlier_prob' column be\n                      \
      \            present and populated in the cluster file.\n                  \
      \                Note: This option is incompatible with\n                  \
      \                --assign-loss-prob"
    inputBinding:
      position: 101
      prefix: --no-user-provided-loss-prob
  - id: num_chains
    type:
      - 'null'
      - int
    doc: "Number of parallel chains for sampling.\n                              \
      \    Recommended to use at least 4."
    inputBinding:
      position: 101
      prefix: --num-chains
  - id: num_iters
    type:
      - 'null'
      - int
    doc: "Number of iterations of the MCMC sampler to\n                          \
      \        perform."
    inputBinding:
      position: 101
      prefix: --num-iters
  - id: num_particles
    type:
      - 'null'
      - int
    doc: "Number of particles to use during PG\n                                 \
      \ sampling."
    inputBinding:
      position: 101
      prefix: --num-particles
  - id: num_samples_data_point
    type:
      - 'null'
      - int
    doc: "Number of Gibbs updates to reassign data\n                             \
      \     points per SMC iteration."
    inputBinding:
      position: 101
      prefix: --num-samples-data-point
  - id: num_samples_prune_regraph
    type:
      - 'null'
      - int
    doc: "Number of prune-regraph updates per SMC\n                              \
      \    iteration."
    inputBinding:
      position: 101
      prefix: --num-samples-prune-regraph
  - id: outlier_prob
    type:
      - 'null'
      - float
    doc: "Prior probability that data points are\n                               \
      \   outliers and don't fit tree."
    inputBinding:
      position: 101
      prefix: --outlier-prob
  - id: precision
    type:
      - 'null'
      - float
    doc: "The (initial) precision parameter of the\n                             \
      \     Beta-Binomial density.  The higher the value\n                       \
      \           the more similar the Beta-Binomial is to a\n                   \
      \               Binomial."
    inputBinding:
      position: 101
      prefix: --precision
  - id: print_freq
    type:
      - 'null'
      - int
    doc: "How frequently to print information about\n                            \
      \      fitting."
    inputBinding:
      position: 101
      prefix: --print-freq
  - id: proposal
    type:
      - 'null'
      - string
    doc: "Proposal distribution to use for PG\n                                  sampling.
      Fully adapted is the most\n                                  computationally
      expensive but also likely to\n                                  lead to the
      best performance per iteration.\n                                  For large
      datasets it may be necessary to\n                                  use one of
      the other proposals."
    inputBinding:
      position: 101
      prefix: --proposal
  - id: resample_threshold
    type:
      - 'null'
      - float
    doc: ESS threshold to trigger resampling.
    inputBinding:
      position: 101
      prefix: --resample-threshold
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set random seed so results can be\n                                  reproduced.
      By default, a random seed is\n                                  chosen."
    inputBinding:
      position: 101
      prefix: --seed
  - id: subtree_update_prob
    type:
      - 'null'
      - float
    doc: "Probability of updating a subtree (instead\n                           \
      \       of whole tree) using PG sampler."
    inputBinding:
      position: 101
      prefix: --subtree-update-prob
  - id: thin
    type:
      - 'null'
      - int
    doc: "Thinning parameter for storing entries in\n                            \
      \      trace."
    inputBinding:
      position: 101
      prefix: --thin
  - id: user_provided_loss_prob
    type:
      - 'null'
      - boolean
    doc: "Whether to use user-provided cluster loss\n                            \
      \      probability prior from the cluster file.\n                          \
      \        Requires that the 'outlier_prob' column be\n                      \
      \            present and populated in the cluster file.\n                  \
      \                Note: This option is incompatible with\n                  \
      \                --assign-loss-prob"
    inputBinding:
      position: 101
      prefix: --user-provided-loss-prob
outputs:
  - id: out_file
    type: File
    doc: "Path to where trace file will be written in\n                          \
      \        HDF5 format."
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
