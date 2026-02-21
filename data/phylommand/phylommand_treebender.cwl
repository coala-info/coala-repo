cwlVersion: v1.2
class: CommandLineTool
baseCommand: treebender
label: phylommand_treebender
doc: "A command line program for manipulating trees in newick or nexus format.\n\n
  Tool homepage: https://github.com/mr-y/phylommand"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input tree file (newick or nexus format)
    inputBinding:
      position: 1
  - id: branch_lengths
    type:
      - 'null'
      - string
    doc: print branch lengths, the separator can be given as first argument after
      the switch, e.g. -a '\n' (default is ','). If the switch r is given as second
      argument after a colon (:), e.g. -a '\n:r', the value of the root branch will
      be printed as well.
    inputBinding:
      position: 102
      prefix: --branch_lengths
  - id: change_names
    type:
      - 'null'
      - string
    doc: change the name of tips. Tip names to be changed should be given pairwise
      with present name first and new name second, separated by '|'. Separate pairs
      should be separated by ','
    inputBinding:
      position: 102
      prefix: --change_names
  - id: clade_credibility
    type:
      - 'null'
      - boolean
    doc: give the log of the product of the support of all clades.
    inputBinding:
      position: 102
      prefix: --clade_credibility
  - id: clear_internal_node_labels
    type:
      - 'null'
      - boolean
    doc: delete the internal node labels
    inputBinding:
      position: 102
      prefix: --clear_internal_node_labels
  - id: cluster
    type:
      - 'null'
      - string
    doc: get clusters based on method (branch_length, long_branch, or tip_name).
    inputBinding:
      position: 102
      prefix: --cluster
  - id: depth
    type:
      - 'null'
      - boolean
    doc: get the longest distance from the root to any of the tips.
    inputBinding:
      position: 102
      prefix: --depth
  - id: distances_to_root
    type:
      - 'null'
      - string
    doc: output the number of nodes and branch length distance to the root for each
      tip. The separator between tip name and value can be specified.
    inputBinding:
      position: 102
      prefix: --distances_to_root
  - id: drop_tips
    type:
      - 'null'
      - string
    doc: drop the given tips from the tree, e.g. -d taxon1,taxon2,taxon3.
    inputBinding:
      position: 102
      prefix: --drop_tips
  - id: file
    type:
      - 'null'
      - File
    doc: give file name, e.g. -f file.tree.
    inputBinding:
      position: 102
      prefix: --file
  - id: format
    type:
      - 'null'
      - string
    doc: give format of input, e.g. --format nexus.
    inputBinding:
      position: 102
      prefix: --format
  - id: get_branch_numbers
    type:
      - 'null'
      - boolean
    doc: assign branch numbers as node labels.
    inputBinding:
      position: 102
      prefix: --get_branch_numbers
  - id: get_relaxed_outgroup
    type:
      - 'null'
      - string
    doc: get the taxa in the clade that include the largest fraction of the difference
      between number of taxa included in the given group and number not included.
    inputBinding:
      position: 102
      prefix: --get_relaxed_outgroup
  - id: get_tip_names
    type:
      - 'null'
      - string
    doc: get the names of the tips in the tree, a separator can be specified.
    inputBinding:
      position: 102
      prefix: --get_tip_names
  - id: internal_node_stats
    type:
      - 'null'
      - string
    doc: print stats about the values on the internal nodes. Counts nodes with value
      above given value.
    default: '1.0'
    inputBinding:
      position: 102
      prefix: --internal_node_stats
  - id: interval
    type:
      - 'null'
      - string
    doc: only print the trees in the interval, e.g. --interval 10-100.
    inputBinding:
      position: 102
      prefix: --interval
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse the string of taxa, e.g. drop all tips but the given.
    inputBinding:
      position: 102
      prefix: --inverse
  - id: is_monophyletic
    type:
      - 'null'
      - string
    doc: test if the given taxa form a monophyletic group.
    inputBinding:
      position: 102
      prefix: --is_monophyletic
  - id: ladderize
    type:
      - 'null'
      - string
    doc: ladderize the tree. If followed by l - left ladderize, if followed by r -
      right ladderize (default).
    inputBinding:
      position: 102
      prefix: --ladderize
  - id: matrix_representation
    type:
      - 'null'
      - boolean
    doc: present a fasta-formated matrix with splits of trees coded as characters.
    inputBinding:
      position: 102
      prefix: --matrix_representation
  - id: mid_point_root
    type:
      - 'null'
      - boolean
    doc: root the tree at the mid point.
    inputBinding:
      position: 102
      prefix: --mid_point_root
  - id: multiply_branch_lengths
    type:
      - 'null'
      - float
    doc: multiply each branch in the tree with the given value.
    default: 1.0
    inputBinding:
      position: 102
      prefix: --multiply_branch_lengths
  - id: multiply_branch_lengths_clade
    type:
      - 'null'
      - string
    doc: multiply branches in clades defined by the most recent common ancestor of
      comma separated taxa.
    inputBinding:
      position: 102
      prefix: --multiply_branch_lengths_clade
  - id: multiply_branch_lengths_until
    type:
      - 'null'
      - string
    doc: multiply branches in tree up until given distance (cut off) from root with
      the given value.
    inputBinding:
      position: 102
      prefix: --multiply_branch_lengths_until
  - id: n_supported
    type:
      - 'null'
      - float
    doc: get the number of nodes with higher support than given value.
    inputBinding:
      position: 102
      prefix: --n_supported
  - id: nni
    type:
      - 'null'
      - string
    doc: perform nearest neighbor interchange. Can take an integer for a specific
      branch or 'all'.
    inputBinding:
      position: 102
      prefix: --nni
  - id: no_branch_length
    type:
      - 'null'
      - boolean
    doc: do not print branch lengths.
    inputBinding:
      position: 102
      prefix: --no_branch_length
  - id: null_short_branches
    type:
      - 'null'
      - float
    doc: set branches with shorter than given value to 0
    inputBinding:
      position: 102
      prefix: --null_short_branches
  - id: number_of_taxa
    type:
      - 'null'
      - boolean
    doc: get the number of tips/taxa in the tree.
    inputBinding:
      position: 102
      prefix: --number_of_taxa
  - id: outgroup_root
    type:
      - 'null'
      - string
    doc: root using most recent common ancestor of given taxa, e.g. -o taxa1,taxa2.
    inputBinding:
      position: 102
      prefix: --outgroup_root
  - id: output
    type:
      - 'null'
      - string
    doc: 'give tree format for output: nexus (x), newick (w), or svg.'
    default: w
    inputBinding:
      position: 102
      prefix: --output
  - id: patristic_distances
    type:
      - 'null'
      - string
    doc: get the total patristic distance to all other taxa in the tree for each taxon.
    inputBinding:
      position: 102
      prefix: --patristic_distances
  - id: random_tree
    type:
      - 'null'
      - string
    doc: get a random topology (no branch lengths) with given number of taxa.
    default: '0'
    inputBinding:
      position: 102
      prefix: --random_tree
  - id: read_figtree_annotations
    type:
      - 'null'
      - boolean
    doc: will read annotations in FigTree/treeanotator format.
    inputBinding:
      position: 102
      prefix: --read_figtree_annotations
  - id: relaxed_outgroup_root
    type:
      - 'null'
      - string
    doc: will root on the group defined as for --get_relaxed_outgroup.
    inputBinding:
      position: 102
      prefix: --relaxed_outgroup_root
  - id: rooted
    type:
      - 'null'
      - boolean
    doc: sets if the tree should be considered as rooted or not.
    inputBinding:
      position: 102
      prefix: --rooted
  - id: set_branch_lengths
    type:
      - 'null'
      - float
    doc: set all branches in the tree to the given value.
    default: 1.0
    inputBinding:
      position: 102
      prefix: --set_branch_lengths
  - id: split
    type:
      - 'null'
      - string
    doc: splits tree based on the longest branch (longest_branch/l) or the mid point
      (mid_point/m).
    inputBinding:
      position: 102
      prefix: --split
  - id: split_stop
    type:
      - 'null'
      - string
    doc: sets criterion for when to stop splitting trees (max_tree_number/t or max_tree_size/s).
    inputBinding:
      position: 102
      prefix: --split_stop
  - id: sum_branch_length
    type:
      - 'null'
      - boolean
    doc: get the sum of the branch lengths in the tree.
    inputBinding:
      position: 102
      prefix: --sum_branch_length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: get additional output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylommand:1.1.0--hc5cd53e_2
stdout: phylommand_treebender.out
