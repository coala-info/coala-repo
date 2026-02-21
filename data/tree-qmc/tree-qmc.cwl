cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-qmc
label: tree-qmc
doc: "A tool for species tree estimation from gene trees or character data using weighted
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
    doc: Input are binary characters i.e. bipartitions
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
    doc: Input are characters rather than trees
    inputBinding:
      position: 101
      prefix: --chars
  - id: contract
    type:
      - 'null'
      - float
    doc: Contract internal branches with support less than specified threshold after
      mapping suport to the interval 0 to 1
    inputBinding:
      position: 101
      prefix: --contract
  - id: default_support
    type:
      - 'null'
      - float
    doc: Default branch support to use if branch input tree is missing support
    inputBinding:
      position: 101
      prefix: --default
  - id: execution
    type:
      - 'null'
      - int
    doc: 'Execution mode (0: efficient, 1: brute force, 2: compute weighted quartets,
      3: compute good/bad edges)'
    default: 0
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
  - id: input
    type: File
    doc: File with gene trees in newick format
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
  - id: mapping
    type:
      - 'null'
      - File
    doc: File with individual/leaf names (1st col) mapped to species (2nd col)
    inputBinding:
      position: 101
      prefix: --mapping
  - id: max
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
    doc: Seeds random number generator prior to calling the max cut heuristic
    default: 1
    inputBinding:
      position: 101
      prefix: --maxcutseed
  - id: min
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
    default: 2
    inputBinding:
      position: 101
      prefix: --norm_atax
  - id: pcsonly
    type:
      - 'null'
      - File
    doc: Compute partitioned coalescent support (PCS) for specified branch in species
      tree in file and then exit
    inputBinding:
      position: 101
      prefix: --pcsonly
  - id: polyseed
    type:
      - 'null'
      - int
    doc: Seeds random number generator prior to arbitrarily resolving polytomies
    default: 12345
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
  - id: rootonly
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
    doc: Use shared taxon data structure to normalize quartet weights (Do NOT use
      unless there are NO missing data)
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
  - id: supportonly
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
    doc: Verbose mode for subproblem information
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weight
    type:
      - 'null'
      - string
    doc: 'Weighting scheme for quartets (n: none, h: hybrid, s: support, l: length,
      f: none fast)'
    default: n
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'File for writing output species tree (default: stdout)'
    outputBinding:
      glob: $(inputs.output)
  - id: writetable
    type:
      - 'null'
      - File
    doc: Write branch and quartet support information to CSV
    outputBinding:
      glob: $(inputs.writetable)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tree-qmc:3.0.4--hee07fbb_0
