cwlVersion: v1.2
class: CommandLineTool
baseCommand: chronumental
label: chronumental
doc: "Convert a distance tree into time tree with distances in days.\n\nTool homepage:
  https://github.com/theosanderson/chronumental"
inputs:
  - id: always_use_final_params
    type:
      - 'null'
      - boolean
    doc: Will force the model to always use the final parameters, rather than 
      simply using those that gave the lowest loss
    inputBinding:
      position: 101
      prefix: --always_use_final_params
  - id: clipped_adam
    type:
      - 'null'
      - boolean
    doc: Will use the clipped version of Adam
    inputBinding:
      position: 101
      prefix: --clipped_adam
  - id: clock
    type:
      - 'null'
      - float
    doc: Molecular clock rate. This should be in units of something per year, 
      where the "something" is the units on the tree. If not given we will 
      attempt to estimate this by RTT. This is only used as a starting point, 
      unless you supply --enforce_exact_clock.
    inputBinding:
      position: 101
      prefix: --clock
  - id: dates
    type: File
    doc: A metadata file with columns strain and date (in "2020-01-02" format, 
      or less precisely, "2021-01", "2021")
    inputBinding:
      position: 101
      prefix: --dates
  - id: enforce_exact_clock
    type:
      - 'null'
      - boolean
    doc: Will cause the clock rate to be exactly fixed at the value specified in
      clock, rather than learnt
    inputBinding:
      position: 101
      prefix: --enforce_exact_clock
  - id: expected_min_between_transmissions
    type:
      - 'null'
      - float
    doc: For forming the prior, an expected minimum time between transmissions 
      in days
    inputBinding:
      position: 101
      prefix: --expected_min_between_transmissions
  - id: hs_scale
    type:
      - 'null'
      - float
    doc: hs scale parameter in the model. Only applies to Horseshoe.
    inputBinding:
      position: 101
      prefix: --hs_scale
  - id: initial_tau
    type:
      - 'null'
      - float
    doc: Initial value for the tau parameter in the model. Only applies to 
      Horseshoe.
    inputBinding:
      position: 101
      prefix: --initial_tau
  - id: lr
    type:
      - 'null'
      - float
    doc: Adam learning rate
    inputBinding:
      position: 101
      prefix: --lr
  - id: model
    type:
      - 'null'
      - string
    doc: Model type to use
    inputBinding:
      position: 101
      prefix: --model
  - id: name_all_nodes
    type:
      - 'null'
      - boolean
    doc: Should we name all nodes in the output tree?
    inputBinding:
      position: 101
      prefix: --name_all_nodes
  - id: only_use_full_dates
    type:
      - 'null'
      - boolean
    doc: Only use full dates, given to the precision of a day
    inputBinding:
      position: 101
      prefix: --only_use_full_dates
  - id: output_unit
    type:
      - 'null'
      - string
    doc: Unit for the output branch lengths on the time tree.
    inputBinding:
      position: 101
      prefix: --output_unit
  - id: reference_node
    type:
      - 'null'
      - string
    doc: A reference node to use for computing dates. This should be early in 
      the tree, and have a correct date. If not specified it will be picked as 
      the oldest node, but often these can be metadata errors.
    inputBinding:
      position: 101
      prefix: --reference_node
  - id: steps
    type:
      - 'null'
      - int
    doc: Number of steps to use for the SVI. Increasing this number will make 
      runtime increase, but yield more accurate results.
    inputBinding:
      position: 101
      prefix: --steps
  - id: treat_mutation_units_as_normalised_to_genome_size
    type:
      - 'null'
      - string
    doc: If your branch sizes, and mutation rate, are normalised to per-site 
      values, then enter the genome size here.
    inputBinding:
      position: 101
      prefix: --treat_mutation_units_as_normalised_to_genome_size
  - id: tree
    type: File
    doc: an input newick tree, potentially gzipped, with branch lengths 
      reflecting genetic distance in integer number of mutations
    inputBinding:
      position: 101
      prefix: --tree
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Will attempt to use the GPU. You will need a version of CUDA installed 
      to suit Numpyro.
    inputBinding:
      position: 101
      prefix: --use_gpu
  - id: use_wandb
    type:
      - 'null'
      - boolean
    doc: This flag will trigger the use of Weights and Biases to log the fitting
      process. This must be installed with 'pip install wandb'
    inputBinding:
      position: 101
      prefix: --use_wandb
  - id: variance_dates
    type:
      - 'null'
      - float
    doc: Scale factor for date distribution. Essentially a measure of how 
      uncertain we think the measured dates are.
    inputBinding:
      position: 101
      prefix: --variance_dates
  - id: variance_on_clock_rate
    type:
      - 'null'
      - boolean
    doc: Will cause the clock rate to be drawn from a random distribution with a
      learnt variance.
    inputBinding:
      position: 101
      prefix: --variance_on_clock_rate
  - id: wandb_project_name
    type:
      - 'null'
      - string
    doc: Wandb project name
    inputBinding:
      position: 101
      prefix: --wandb_project_name
outputs:
  - id: dates_out
    type:
      - 'null'
      - File
    doc: Output for date tsv (otherwise will use default)
    outputBinding:
      glob: $(inputs.dates_out)
  - id: tree_out
    type:
      - 'null'
      - File
    doc: Output for tree (otherwise will use default)
    outputBinding:
      glob: $(inputs.tree_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chronumental:0.0.65--pyhdfd78af_0
