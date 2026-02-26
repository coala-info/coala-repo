cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpboot
label: mpboot
doc: "MPBoot version 1.1.1 for Linux 64-bit built Apr 15 2025\nCopyright (c) 2016
  Diep Thi Hoang, Le Sy Vinh, Tomas Flouri, Alexandros Stamatakis, Arndt von Haeseler
  and Bui Quang Minh.\n\nTool homepage: https://github.com/diepthihoang/mpboot"
inputs:
  - id: initial_tree
    type:
      - 'null'
      - File
    doc: 'Initial tree for tree reconstruction (default: MP)'
    inputBinding:
      position: 1
  - id: input_trees_for_consensus
    type:
      - 'null'
      - File
    doc: Set of input trees for consensus reconstruction
    inputBinding:
      position: 2
  - id: alignment
    type: File
    doc: Input alignment (REQUIRED) in PHYLIP/FASTA/NEXUS format
    inputBinding:
      position: 103
      prefix: -s
  - id: assign_support_to_tree
    type:
      - 'null'
      - File
    doc: Assigning support values for <target_tree> to .suptree
    inputBinding:
      position: 103
      prefix: -sup
  - id: candidate_cutoff
    type:
      - 'null'
      - int
    doc: 'Use top #s percentile as cutoff for selecting bootstrap candidates (default:
      10)'
    default: 10
    inputBinding:
      position: 103
      prefix: -cand_cutoff
  - id: candidate_set_size
    type:
      - 'null'
      - int
    doc: 'Size of the candidate tree set (defaut: 5)'
    default: 5
    inputBinding:
      position: 103
      prefix: -numcand
  - id: compute_adjacent_rf_distances
    type:
      - 'null'
      - boolean
    doc: Computing RF distances of adjacent trees in <treefile>
    inputBinding:
      position: 103
      prefix: -rf_adj
  - id: compute_all_rf_distances
    type:
      - 'null'
      - boolean
    doc: Computing all-to-all RF distances of trees in <treefile>
    inputBinding:
      position: 103
      prefix: -rf_all
  - id: compute_consensus_network
    type:
      - 'null'
      - boolean
    doc: Computing consensus network to .nex file
    inputBinding:
      position: 103
      prefix: -net
  - id: compute_consensus_tree
    type:
      - 'null'
      - boolean
    doc: Computing consensus tree to .contree file
    inputBinding:
      position: 103
      prefix: -con
  - id: compute_rf_distances_between_sets
    type:
      - 'null'
      - File
    doc: "Computing all RF distances between two sets of trees\nstored in <treefile>
      and <treefile2>"
    inputBinding:
      position: 103
      prefix: -rf
  - id: cost_matrix_file
    type:
      - 'null'
      - File
    doc: "Read <file> for the matrix of transition cost between character states\n\
      Replace <file> by letter e for uniform cost."
    inputBinding:
      position: 103
      prefix: -cost
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'BIN, DNA, AA, CODON, or MORPH (default: auto-detect)'
    default: auto-detect
    inputBinding:
      position: 103
      prefix: -st
  - id: discard_burnin_trees
    type:
      - 'null'
      - int
    doc: Discarding <burnin> trees at beginning of <treefile>
    inputBinding:
      position: 103
      prefix: -bi
  - id: fixed_iterations
    type:
      - 'null'
      - int
    doc: 'Fix number of iterations to <#iterations> (default: auto)'
    default: auto
    inputBinding:
      position: 103
      prefix: -n
  - id: max_ufboot_iterations
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations (default: 1000)'
    default: 1000
    inputBinding:
      position: 103
      prefix: -nm
  - id: min_correlation
    type:
      - 'null'
      - float
    doc: 'Minimum correlation coefficient (default: 0.99)'
    default: 0.99
    inputBinding:
      position: 103
      prefix: -bcor
  - id: min_split_support
    type:
      - 'null'
      - float
    doc: "Min split support in range [0,1]. 0.5 for majority-rule\nconsensus (default:
      0, i.e. extended consensus)"
    default: 0
    inputBinding:
      position: 103
      prefix: -t
  - id: nni_pars
    type:
      - 'null'
      - boolean
    doc: Hill-climb by NNI instead of SPR
    inputBinding:
      position: 103
      prefix: -nni_pars
  - id: num_parsimony_trees
    type:
      - 'null'
      - int
    doc: 'Number of initial parsimony trees (default: 100)'
    default: 100
    inputBinding:
      position: 103
      prefix: -numpars
  - id: num_taxa_balanced
    type:
      - 'null'
      - int
    doc: Create a random balanced tree.
    inputBinding:
      position: 103
      prefix: -rbal
  - id: num_taxa_caterpillar
    type:
      - 'null'
      - int
    doc: Create a random caterpillar tree.
    inputBinding:
      position: 103
      prefix: -rcat
  - id: num_taxa_circular_split
    type:
      - 'null'
      - int
    doc: Create a random circular split network.
    inputBinding:
      position: 103
      prefix: -rcsg
  - id: num_taxa_uniform
    type:
      - 'null'
      - int
    doc: Create a random tree under Uniform model.
    inputBinding:
      position: 103
      prefix: -ru
  - id: num_taxa_yule_harding
    type:
      - 'null'
      - int
    doc: Create a random tree under Yule-Harding model.
    inputBinding:
      position: 103
      prefix: -r
  - id: optimize_btree_off
    type:
      - 'null'
      - boolean
    doc: Turn off refinement step on the final bootstrap tree set
    inputBinding:
      position: 103
      prefix: -opt_btree_off
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'Using <PREFIX> for output files (default: alignment name)'
    inputBinding:
      position: 103
      prefix: -pre
  - id: perturbation_strength
    type:
      - 'null'
      - float
    doc: 'Perturbation strength for randomized NNI (default: 0.5)'
    default: 0.5
    inputBinding:
      position: 103
      prefix: -pers
  - id: print_site_parsimony_scores
    type:
      - 'null'
      - boolean
    doc: When using together with parsimony tree inference, print site parsimony
      scores of the best tree found.
    inputBinding:
      position: 103
      prefix: -wspars
  - id: print_site_parsimony_scores_user_tree
    type:
      - 'null'
      - File
    doc: Print site parsimony scores of the user tree in <treefile>
    inputBinding:
      position: 103
      prefix: -wspars-user-tree
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed number, normally used for debugging purpose
    inputBinding:
      position: 103
      prefix: -seed
  - id: random_tree_lengths
    type:
      - 'null'
      - type: array
        items: float
    doc: min, mean, and max branch lengths of random trees.
    inputBinding:
      position: 103
      prefix: -rlen
  - id: ratchet_iterations
    type:
      - 'null'
      - int
    doc: 'Number of non-ratchet iterations before each ratchet iteration (default:
      1)'
    default: 1
    inputBinding:
      position: 103
      prefix: -ratchet_iter
  - id: ratchet_off
    type:
      - 'null'
      - boolean
    doc: Turn of ratchet, i.e. Only use tree perturbation
    inputBinding:
      position: 103
      prefix: -ratchet_off
  - id: ratchet_percent
    type:
      - 'null'
      - float
    doc: 'Percentage of informative sites selected for perturbation during ratchet
      (default: 50)'
    default: 50
    inputBinding:
      position: 103
      prefix: -ratchet_percent
  - id: ratchet_weight
    type:
      - 'null'
      - float
    doc: 'Weight to add to each site selected for perturbation during ratchet (default:
      1)'
    default: 1
    inputBinding:
      position: 103
      prefix: -ratchet_wgt
  - id: rell_epsilon
    type:
      - 'null'
      - float
    doc: 'RELL epsilon to break tie (default: 0.5)'
    default: 0.5
    inputBinding:
      position: 103
      prefix: -beps
  - id: spr_radius
    type:
      - 'null'
      - int
    doc: 'Maximum radius of SPR (default: 3)'
    default: 3
    inputBinding:
      position: 103
      prefix: -spr_rad
  - id: stop_iterations
    type:
      - 'null'
      - int
    doc: 'Number of unsuccessful iterations to stop (default: 100)'
    default: 100
    inputBinding:
      position: 103
      prefix: -numstop
  - id: store_multiple_trees
    type:
      - 'null'
      - boolean
    doc: Store multiple equally parsimonious trees per bootstrap replicate
    inputBinding:
      position: 103
      prefix: -mulhits
  - id: top_parsimony_trees
    type:
      - 'null'
      - int
    doc: 'Number of best parsimony trees (default: 20)'
    default: 20
    inputBinding:
      position: 103
      prefix: -toppars
  - id: ufboot_stopping_iterations
    type:
      - 'null'
      - int
    doc: '#Iterations for UFBoot stopping rule (default: 100)'
    default: 100
    inputBinding:
      position: 103
      prefix: -nstep
  - id: ultrafast_bootstrap_replicates
    type:
      - 'null'
      - int
    doc: Ultrafast bootstrap (>=1000)
    inputBinding:
      position: 103
      prefix: -bb
  - id: use_iqp
    type:
      - 'null'
      - boolean
    doc: 'Use the IQP tree perturbation (default: randomized NNI)'
    inputBinding:
      position: 103
      prefix: -iqp
  - id: use_iqpnn
    type:
      - 'null'
      - boolean
    doc: Switch back to the old IQPNNI tree search algorithm
    inputBinding:
      position: 103
      prefix: -iqpnni
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, printing more messages to screen
    inputBinding:
      position: 103
      prefix: -v
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, printing more messages to screen
    inputBinding:
      position: 103
      prefix: -vv
  - id: very_very_verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, printing more messages to screen
    inputBinding:
      position: 103
      prefix: -vvv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpboot:1.2--h503566f_0
stdout: mpboot.out
