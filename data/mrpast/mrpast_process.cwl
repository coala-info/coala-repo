cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast process
label: mrpast_process
doc: "Process MRPAST model and ARG files.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: model
    type: File
    doc: The input YAML file specifying the model
    inputBinding:
      position: 1
  - id: arg_prefix
    type: string
    doc: The prefix of the input tree-seq file(s) specifying the ARG. Assumes 
      .trees file extension.
    inputBinding:
      position: 2
  - id: add_ground_truth
    type:
      - 'null'
      - boolean
    doc: Generate an additional solver input(s) using the ground-truth parameter
      values.
    inputBinding:
      position: 103
      prefix: --add-ground-truth
  - id: bootstrap
    type:
      - 'null'
      - string
    doc: 'Bootstrap the sampled trees to create more than once coalescent matrix.
      coalcounts: standard bootstrap of over marginal trees. jackknife: leave-one-out
      jacktree over blocks of marginal trees.'
    inputBinding:
      position: 103
      prefix: --bootstrap
  - id: bootstrap_iter
    type:
      - 'null'
      - int
    doc: 'How many blocks to split the trees in for jackknifing, number of reps for
      standard bootstrap. Default: 100'
    default: 100
    inputBinding:
      position: 103
      prefix: --bootstrap-iter
  - id: group_by
    type:
      - 'null'
      - string
    doc: Regex to group ARGs or coal files by. By default group by chromosome 
      for bootstrapping and by sample otherwise.
    inputBinding:
      position: 103
      prefix: --group-by
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use. Defaults to 1.
    default: 1
    inputBinding:
      position: 103
      prefix: --jobs
  - id: leave_out
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of population IDs to leave out when counting 
      coalescence
    inputBinding:
      position: 103
      prefix: --leave-out
  - id: map_pops
    type:
      - 'null'
      - string
    doc: A list of <idx1>:<idx2>, comma-separated, which maps a particular 
      population to another population, based on their 0-based indices. Useful 
      for when the ARG populations are in a different order (or have ghosts) 
      compared to the model.
    inputBinding:
      position: 103
      prefix: --map-pops
  - id: max_generation
    type:
      - 'null'
      - float
    doc: 'Ignore all coalescence events occuring after the given generation (default:
      1000000.0)'
    default: 1000000.0
    inputBinding:
      position: 103
      prefix: --max-generation
  - id: min_time_unit
    type:
      - 'null'
      - float
    doc: 'The minimum time unit for distinguishing between coalescence events (default:
      1.0 generation)'
    default: 1.0
    inputBinding:
      position: 103
      prefix: --min-time-unit
  - id: num_times
    type:
      - 'null'
      - int
    doc: Number of time slices to use. Defaults to 20. Use the suffix 'l' or 'L'
      to use left-skewed time slices.
    default: 20
    inputBinding:
      position: 103
      prefix: --num-times
  - id: rate_map_threshold
    type:
      - 'null'
      - float
    doc: Only sample trees from regions with a recombination rate <= to this. 
      Requires --rate-maps
    inputBinding:
      position: 103
      prefix: --rate-map-threshold
  - id: rate_maps
    type:
      - 'null'
      - string
    doc: A filename prefix for tskit-style RateMap files, whose lexicographic 
      sort order matches the input ARGs lexicographic sort order. Generates a 
      glob '<prefix>*.txt'. Used for determining tree sampling (see 
      --rate-map-threshold)
    inputBinding:
      position: 103
      prefix: --rate-maps
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of solver replications to perform. Defaults to 10 * num_epochs.
    inputBinding:
      position: 103
      prefix: --replicates
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 103
      prefix: --seed
  - id: solve
    type:
      - 'null'
      - boolean
    doc: Solve the model after generating the solver inputs.
    inputBinding:
      position: 103
      prefix: --solve
  - id: suffix
    type:
      - 'null'
      - string
    doc: Filenames will use the provided suffix instead of a random one.
    inputBinding:
      position: 103
      prefix: --suffix
  - id: time_slices
    type:
      - 'null'
      - string
    doc: The comma-separated list of time slice values instead of computing them
      from coalescence counts. Or, if prefixed with '+', the list of time slices
      to append to the auto-generated time slices.
    inputBinding:
      position: 103
      prefix: --time-slices
  - id: tree_sample_rate
    type:
      - 'null'
      - int
    doc: 'Sample a tree from the ARG every tree-sample-rate base pairs (default: 125000
      bp)'
    default: 125000
    inputBinding:
      position: 103
      prefix: --tree-sample-rate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, including timing information.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
