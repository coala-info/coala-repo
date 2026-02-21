cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - best
label: treebest_best
doc: "Estimate the best gene tree given a CDS alignment, using PHYML and species tree
  information.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: cds_alignment
    type: File
    doc: Input CDS alignment file
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - string
    doc: alpha parameter for Gamma distribution
    default: '1.0'
    inputBinding:
      position: 102
      prefix: -a
  - id: apply_constraint_to_phyml
    type:
      - 'null'
      - boolean
    doc: apply constraint to PHYML
    inputBinding:
      position: 102
      prefix: -A
  - id: collapse_alternative_splicing
    type:
      - 'null'
      - boolean
    doc: collapse alternative splicing forms
    inputBinding:
      position: 102
      prefix: -g
  - id: constraining_tree
    type:
      - 'null'
      - File
    doc: constraining tree
    inputBinding:
      position: 102
      prefix: -C
  - id: debug_info
    type:
      - 'null'
      - boolean
    doc: output some debug information
    inputBinding:
      position: 102
      prefix: -D
  - id: discard_missing_species
    type:
      - 'null'
      - boolean
    doc: discard species that do not appear at all
    inputBinding:
      position: 102
      prefix: -r
  - id: duplication_probability
    type:
      - 'null'
      - float
    doc: duplication probability
    default: 0.15
    inputBinding:
      position: 102
      prefix: -d
  - id: ignore_gene_evolution_prob
    type:
      - 'null'
      - boolean
    doc: ignore the prob. of gene evolution (NOT recommended)
    inputBinding:
      position: 102
      prefix: -S
  - id: inconsistent_branch_prob
    type:
      - 'null'
      - float
    doc: prob. of the presence of an inconsistent branch
    default: 0.01
    inputBinding:
      position: 102
      prefix: -b
  - id: intermediate_tree_prefix
    type:
      - 'null'
      - string
    doc: prefix of intermediate trees
    inputBinding:
      position: 102
      prefix: -p
  - id: kappa
    type:
      - 'null'
      - string
    doc: tv/ts ratio (kappa), 'e' for estimating
    default: e
    inputBinding:
      position: 102
      prefix: -k
  - id: loss_prob_duplication
    type:
      - 'null'
      - float
    doc: probability of a loss following a duplication
    default: 0.2
    inputBinding:
      position: 102
      prefix: -L
  - id: loss_prob_speciation
    type:
      - 'null'
      - float
    doc: probability of a loss following a speciation
    default: 0.1
    inputBinding:
      position: 102
      prefix: -l
  - id: no_mask_low_scoring
    type:
      - 'null'
      - boolean
    doc: do not mask low-scoring segments
    inputBinding:
      position: 102
      prefix: -N
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: quality cut-off
    default: 11
    inputBinding:
      position: 102
      prefix: -F
  - id: rate_categories
    type:
      - 'null'
      - int
    doc: number of rate categories for PHYML-HKY
    default: 2
    inputBinding:
      position: 102
      prefix: -c
  - id: sequenced_species_only
    type:
      - 'null'
      - boolean
    doc: only build tree for genes from sequenced species
    inputBinding:
      position: 102
      prefix: -s
  - id: skip_mmerge
    type:
      - 'null'
      - boolean
    doc: skip the mmerge step and use the constraining tree instead
    inputBinding:
      position: 102
      prefix: -I
  - id: skip_phyml
    type:
      - 'null'
      - boolean
    doc: skip PHYML
    inputBinding:
      position: 102
      prefix: -P
  - id: species_tree
    type:
      - 'null'
      - File
    doc: species tree
    inputBinding:
      position: 102
      prefix: -f
  - id: suppress_phyml_warnings
    type:
      - 'null'
      - boolean
    doc: suppress part of PHYML warnings
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: output tree
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
