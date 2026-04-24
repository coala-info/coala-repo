cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-qmc
label: treeqmc_tree-qmc
doc: "A tool for estimating species trees from gene trees or character data using
  quartet-based methods.\n\nTool homepage: https://github.com/molloy-lab/TREE-QMC"
inputs:
  - id: bayes
    type:
      - 'null'
      - boolean
    doc: Use presets for bayesian support (-n 0.333 -x 1.0 -d 0.333)
    inputBinding:
      position: 101
      prefix: --bayes
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Use presets for boostrap support (-n 0 -x 100 -d 0)
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: bp
    type:
      - 'null'
      - boolean
    doc: Input are binary characters i.e. bipartitions. Missing states are N, -, and
      ?
    inputBinding:
      position: 101
      prefix: --bp
  - id: char2tree
    type:
      - 'null'
      - boolean
    doc: Write character matrix as trees (newick strings) to output and exit
    inputBinding:
      position: 101
      prefix: --char2tree
  - id: chars
    type:
      - 'null'
      - boolean
    doc: Input are characters rather than trees. Missing states are N, -, and ?
    inputBinding:
      position: 101
      prefix: --chars
  - id: contract
    type:
      - 'null'
      - float
    doc: Contract internal branches with support less than specified threshold after
      mapping support to the interval 0 to 1
    inputBinding:
      position: 101
      prefix: --contract
  - id: default_support
    type:
      - 'null'
      - float
    doc: Default branch support if not provided as input
    inputBinding:
      position: 101
      prefix: --default
  - id: execution_mode
    type:
      - 'null'
      - int
    doc: 'Execution mode (0: efficient, 1: brute force, 2: weighted quartets exit,
      3: good/bad edges exit)'
    inputBinding:
      position: 101
      prefix: --execution
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Use fast algorithm that does not support weights or polytomies (-w f)
    inputBinding:
      position: 101
      prefix: --fast
  - id: hybrid
    type:
      - 'null'
      - boolean
    doc: Use hybrid weighting scheme (-w h)
    inputBinding:
      position: 101
      prefix: --hybrid
  - id: input_file
    type: File
    doc: File with gene trees in newick format (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: lrt
    type:
      - 'null'
      - boolean
    doc: Use presets for likelihood support (-n 0.0 -x 1.0 -d 0.0)
    inputBinding:
      position: 101
      prefix: --lrt
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: File with individual/leaf names (1st col) mapped to species (2nd col)
    inputBinding:
      position: 101
      prefix: --mapping
  - id: max_support
    type:
      - 'null'
      - float
    doc: Maximum value of input branch support
    inputBinding:
      position: 101
      prefix: --max
  - id: maxcutseed
    type:
      - 'null'
      - int
    doc: Seeds random number generator prior to calling the max cut heuristic. If
      -1, system time is used.
    inputBinding:
      position: 101
      prefix: --maxcutseed
  - id: min_support
    type:
      - 'null'
      - float
    doc: Minimum value of input branch support
    inputBinding:
      position: 101
      prefix: --min
  - id: norm_atax
    type:
      - 'null'
      - int
    doc: 'Normalization scheme for artificial taxa (0: none, 1: uniform, 2: non-uniform)'
    inputBinding:
      position: 101
      prefix: --norm_atax
  - id: pcs_only
    type:
      - 'null'
      - File
    doc: Compute partitioned coalescent support (PCS) for specified branch in species
      tree in file (annotate branch with PCS) and then exit
    inputBinding:
      position: 101
      prefix: --pcsonly
  - id: polyseed
    type:
      - 'null'
      - int
    doc: Seeds random number generator with prior to arbitrarily resolving polytomies.
      If -1, system time is used.
    inputBinding:
      position: 101
      prefix: --polyseed
  - id: root
    type:
      - 'null'
      - string
    doc: Root species tree at given species if possible (list of species separated
      by commas)
    inputBinding:
      position: 101
      prefix: --root
  - id: root_only
    type:
      - 'null'
      - File
    doc: Root species tree in file and then exit
    inputBinding:
      position: 101
      prefix: --rootonly
  - id: shared
    type:
      - 'null'
      - boolean
    doc: Use shared taxon data structure to normalize quartet weights. Do NOT use
      unless there are NO missing data.
    inputBinding:
      position: 101
      prefix: --shared
  - id: support
    type:
      - 'null'
      - boolean
    doc: Compute quartet support for output species tree
    inputBinding:
      position: 101
      prefix: --support
  - id: support_only
    type:
      - 'null'
      - File
    doc: Compute quartet support for species tree in file and then exit
    inputBinding:
      position: 101
      prefix: --supportonly
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbose mode (0: none, 1: CSV subproblem info, 2: detailed CSV subproblem
      info)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weight
    type:
      - 'null'
      - string
    doc: 'Weighting scheme for quartets (n: none, h: hybrid, s: support, l: length,
      f: none fast)'
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File for writing output species tree
    outputBinding:
      glob: $(inputs.output_file)
  - id: write_table
    type:
      - 'null'
      - File
    doc: Write branch and quartet support information to CSV
    outputBinding:
      glob: $(inputs.write_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treeqmc:3.0.1--hee07fbb_0
