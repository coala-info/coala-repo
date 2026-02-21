cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - phyml
label: treebest_phyml
doc: "Estimate phylogenies by maximum likelihood using TreeFam extensions and the
  PhyML algorithm.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: tree
    type:
      - 'null'
      - File
    doc: Input tree file
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - string
    doc: alpha parameter for Gamma distribution, 'e' for estimating
    default: '1.0'
    inputBinding:
      position: 103
      prefix: -a
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: number of bootstraps (slow)
    default: 0
    inputBinding:
      position: 103
      prefix: -b
  - id: collapse_splicing
    type:
      - 'null'
      - boolean
    doc: collapse alternative splicing
    inputBinding:
      position: 103
      prefix: -g
  - id: constraining_tree
    type:
      - 'null'
      - File
    doc: constraining tree
    inputBinding:
      position: 103
      prefix: -C
  - id: duplication_probability
    type:
      - 'null'
      - float
    doc: duplication probability
    default: 0.15
    inputBinding:
      position: 103
      prefix: -d
  - id: inconsistent_branch_prob
    type:
      - 'null'
      - float
    doc: prob. of the presence of an inconsistent branch
    default: 0.01
    inputBinding:
      position: 103
      prefix: -p
  - id: invariable_sites
    type:
      - 'null'
      - string
    doc: proportion of invariable sites, 'e' for estimating
    default: '0'
    inputBinding:
      position: 103
      prefix: -i
  - id: kappa
    type:
      - 'null'
      - string
    doc: transversion/transition ratio, 'e' for estimating
    default: e
    inputBinding:
      position: 103
      prefix: -k
  - id: loss_probability_duplication
    type:
      - 'null'
      - float
    doc: probability of a loss following a duplication
    default: 0.2
    inputBinding:
      position: 103
      prefix: -L
  - id: loss_probability_speciation
    type:
      - 'null'
      - float
    doc: probability of a loss following a speciation
    default: 0.1
    inputBinding:
      position: 103
      prefix: -l
  - id: model
    type:
      - 'null'
      - string
    doc: 'nt: JC69 | K2P | F81 | HKY | F84 | TN93 | GTR; aa: JTT | MtREV | Dayhoff
      | WAG'
    inputBinding:
      position: 103
      prefix: -m
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: do not mask low-scoring segments
    inputBinding:
      position: 103
      prefix: -N
  - id: nucleotide_alignment
    type:
      - 'null'
      - boolean
    doc: the input is a nucleotide alignment
    inputBinding:
      position: 103
      prefix: -n
  - id: print_statistics
    type:
      - 'null'
      - boolean
    doc: print out some statistics
    inputBinding:
      position: 103
      prefix: -s
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: quality cut-off
    default: 15
    inputBinding:
      position: 103
      prefix: -F
  - id: species_tree_file
    type:
      - 'null'
      - File
    doc: species tree
    inputBinding:
      position: 103
      prefix: -f
  - id: substitution_categories
    type:
      - 'null'
      - int
    doc: number of relative substitution rate categories
    default: 1
    inputBinding:
      position: 103
      prefix: -c
  - id: task
    type:
      - 'null'
      - string
    doc: build | opt | loglk | dist
    default: build
    inputBinding:
      position: 103
      prefix: -t
  - id: use_species_tree
    type:
      - 'null'
      - boolean
    doc: use a species tree to guide tree building
    inputBinding:
      position: 103
      prefix: -S
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
