cwlVersion: v1.2
class: CommandLineTool
baseCommand: orientagraph
label: orientagraph
doc: "OrientAGraph is built from TreeMix v1.13 Revision 231 by J.K. Pickrell and J.K.
  Pritchard and has several new features, including the option to run Maximum Likelihood
  Network Orientation (MLNO) as part of the admixture graph search heuristic.\n\n\
  Tool homepage: https://github.com/sriramlab/OrientAGraph"
inputs:
  - id: bootstrap_replicate
    type:
      - 'null'
      - boolean
    doc: Perform a single bootstrap replicate
    inputBinding:
      position: 101
      prefix: -bootstrap
  - id: calculate_standard_errors
    type:
      - 'null'
      - boolean
    doc: Calculate standard errors of migration weights (computationally 
      expensive)
    inputBinding:
      position: 101
      prefix: -se
  - id: estimate_covariances_and_exit
    type:
      - 'null'
      - boolean
    doc: Estimate covariances or f2-statistics from allele frequencies and then 
      exit; the resulting files can be given as input using the -givenmat option
    inputBinding:
      position: 101
      prefix: -freq2stat
  - id: evaluate_all_migration_edges
    type:
      - 'null'
      - boolean
    doc: Evaluate all legal ways to add migration edge to base tree as part of 
      search
    inputBinding:
      position: 101
      prefix: -allmigs
  - id: given_matrix_file
    type:
      - 'null'
      - File
    doc: Allows user to input matrix (e.g. [stem].cov.gz) with the -i flag, the 
      file after this option should contain the standard error (e.g. 
      [stem].covse.gz); if no file is provided after this option, then 0.0001 is
      used as the standard error.
    inputBinding:
      position: 101
      prefix: -givenmat
  - id: global_rearrangements
    type:
      - 'null'
      - boolean
    doc: Do a round of global rearrangements after adding all populations
    inputBinding:
      position: 101
      prefix: -global
  - id: graph_edges_file
    type:
      - 'null'
      - File
    doc: read the graph from a previous TreeMix run
    inputBinding:
      position: 101
      prefix: -g
  - id: graph_vertices_file
    type:
      - 'null'
      - File
    doc: read the graph from a previous TreeMix run
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file
    inputBinding:
      position: 101
      prefix: -i
  - id: known_migration_events_file
    type:
      - 'null'
      - File
    doc: list of known migration events to include (also use -climb)
    inputBinding:
      position: 101
      prefix: -cor_mig
  - id: microsatellite_data
    type:
      - 'null'
      - boolean
    doc: microsatellite data
    inputBinding:
      position: 101
      prefix: -micro
  - id: num_migration_edges
    type:
      - 'null'
      - int
    doc: number of migration edges to add
    inputBinding:
      position: 101
      prefix: -m
  - id: num_warnings_to_display
    type:
      - 'null'
      - int
    doc: Display first N warnings
    inputBinding:
      position: 101
      prefix: -n_warn
  - id: output_stem
    type:
      - 'null'
      - string
    doc: output stem (will be [stem].treeout.gz, [stem].cov.gz, 
      [stem].modelcov.gz)
    inputBinding:
      position: 101
      prefix: -o
  - id: population_add_order_file
    type:
      - 'null'
      - File
    doc: Order to add populations when building starting tree
    inputBinding:
      position: 101
      prefix: -popaddorder
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set the seed for random number generation
    inputBinding:
      position: 101
      prefix: -seed
  - id: refit_model_parameters
    type:
      - 'null'
      - boolean
    doc: Allows user to (re)fit model parameters on starting tree (-tf) or graph
      (-g)
    inputBinding:
      position: 101
      prefix: -refit
  - id: root_populations
    type:
      - 'null'
      - string
    doc: comma-delimited list of populations to set on one side of the root (for
      migration)
    inputBinding:
      position: 101
      prefix: -root
  - id: run_mlno
    type:
      - 'null'
      - boolean
    doc: Run maximum likelihood network orientation (MLNO) as part of search
    inputBinding:
      position: 101
      prefix: -mlno
  - id: score_tree_or_graph
    type:
      - 'null'
      - int
    doc: Score input tree (-tf) or graph (-g) (1) without refitting, (2) with 
      refitting, (3) evaluating each base tree and returning the best, (4) 
      evaluating each network orientation and returning the best
    inputBinding:
      position: 101
      prefix: -score
  - id: snps_per_block
    type:
      - 'null'
      - int
    doc: number of SNPs per block for estimation of covariance matrix
    inputBinding:
      position: 101
      prefix: -k
  - id: tree_topology_file
    type:
      - 'null'
      - File
    doc: Read the tree topology from a file, rather than estimating it
    inputBinding:
      position: 101
      prefix: -tf
  - id: turn_off_sample_size_correction
    type:
      - 'null'
      - boolean
    doc: Turn off sample size correction
    inputBinding:
      position: 101
      prefix: -noss
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orientagraph:1.1--h3b735ea_0
stdout: orientagraph.out
