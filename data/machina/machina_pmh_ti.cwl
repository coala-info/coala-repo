cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh_ti
label: machina_pmh_ti
doc: "Parses mutation trees and migration graphs to infer phylogenetic relationships.\n\
  \nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: allowed_migration_patterns
    type:
      - 'null'
      - string
    doc: 'Allowed migration patterns: 0 : PS, 1 : PS, S, 2 : PS, S, M, 3 : PS, S,
      M, R. If no pattern is specified, all allowed patterns will be enumerated'
    inputBinding:
      position: 101
      prefix: -m
  - id: color_map_file
    type: string
    doc: Color map file
    inputBinding:
      position: 101
      prefix: -c
  - id: disable_polytomy_resolution
    type:
      - 'null'
      - boolean
    doc: Disable polytomy resolution
    inputBinding:
      position: 101
      prefix: -noPR
  - id: export_ilp
    type:
      - 'null'
      - boolean
    doc: Export ILP
    inputBinding:
      position: 101
      prefix: -e
  - id: frequencies_file
    type: string
    doc: Frequencies file
    inputBinding:
      position: 101
      prefix: -F
  - id: gurobi_logging
    type:
      - 'null'
      - boolean
    doc: Gurobi logging
    inputBinding:
      position: 101
      prefix: -log
  - id: migration_graphs_file
    type:
      - 'null'
      - string
    doc: Optional file with migration graphs
    inputBinding:
      position: 101
      prefix: -G
  - id: mutation_tree_index
    type:
      - 'null'
      - int
    doc: Mutation tree index
    inputBinding:
      position: 101
      prefix: -mutTreeIdx
  - id: mutation_trees
    type: string
    doc: Mutation trees
    inputBinding:
      position: 101
      prefix: -barT
  - id: num_mutation_trees
    type:
      - 'null'
      - int
    doc: Number of mutation trees to consider
    inputBinding:
      position: 101
      prefix: -N
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: output_search_graph
    type:
      - 'null'
      - boolean
    doc: Output search graph
    inputBinding:
      position: 101
      prefix: -g
  - id: primary_anatomical_site
    type: string
    doc: Primary anatomical site
    inputBinding:
      position: 101
      prefix: -p
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    inputBinding:
      position: 101
      prefix: -s
  - id: retain_optimal_solution
    type:
      - 'null'
      - boolean
    doc: Only retain optimal solution
    inputBinding:
      position: 101
      prefix: -useBounds
  - id: time_limit_seconds
    type:
      - 'null'
      - int
    doc: Time limit in seconds for the ILP
    inputBinding:
      position: 101
      prefix: -l
  - id: upper_bound_comigration
    type:
      - 'null'
      - int
    doc: Upper bound on the comigration number
    inputBinding:
      position: 101
      prefix: -UB_gamma
  - id: upper_bound_migration
    type:
      - 'null'
      - int
    doc: Upper bound on the migration number
    inputBinding:
      position: 101
      prefix: -UB_mu
  - id: upper_bound_seeding_site
    type:
      - 'null'
      - int
    doc: Upper bound on the seeding site number
    inputBinding:
      position: 101
      prefix: -UB_sigma
  - id: use_old_ilp
    type:
      - 'null'
      - boolean
    doc: Use old ILP (typically much slower)
    inputBinding:
      position: 101
      prefix: -OLD
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh_ti.out
