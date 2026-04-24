cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpest
label: mp-est_mpest
doc: "Maximum Pseudo-likelihood Estimation of Species Trees - MPEST\n\nTool homepage:
  https://github.com/lliu1871/mp-est"
inputs:
  - id: build_njst_tree
    type:
      - 'null'
      - boolean
    doc: build NJst tree.
    inputBinding:
      position: 101
      prefix: -N
  - id: calculate_loglikelihood
    type:
      - 'null'
      - boolean
    doc: calculate loglikelihood of a species tree provided through usertree 
      option -u.
    inputBinding:
      position: 101
      prefix: -L
  - id: calculate_pairwise_quartet_distances
    type:
      - 'null'
      - boolean
    doc: calculate pairwise quartet distances among gene trees. Polytomy 
      (unrooted or rooted) gene trees are allowed.
    inputBinding:
      position: 101
      prefix: -Q
  - id: calculate_pairwise_triple_distances
    type:
      - 'null'
      - boolean
    doc: calculate pairwise triple distances of gene trees. Polytomy rooted gene
      trees are allowed.
    inputBinding:
      position: 101
      prefix: -T
  - id: calculate_partitions
    type:
      - 'null'
      - boolean
    doc: calculate partitions for gene trees.
    inputBinding:
      position: 101
      prefix: -P
  - id: convert_short_branches
    type:
      - 'null'
      - int
    doc: convert short branches (<#) to polytomies in gene trees.
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type:
      - 'null'
      - File
    doc: name of input file in nexus format. Input gene trees must be rooted; 
      polytomy trees are allowed.
    inputBinding:
      position: 101
      prefix: -i
  - id: num_runs
    type:
      - 'null'
      - int
    doc: number of runs
    inputBinding:
      position: 101
      prefix: -n
  - id: optimize_branch_lengths
    type:
      - 'null'
      - boolean
    doc: optimize branch lengths of a fixed species tree provided through 
      usertree option -u.
    inputBinding:
      position: 101
      prefix: -B
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 101
      prefix: -s
  - id: user_tree_file
    type:
      - 'null'
      - File
    doc: name of user tree file.
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mp-est:3.1.0--h7b50bb2_0
stdout: mp-est_mpest.out
