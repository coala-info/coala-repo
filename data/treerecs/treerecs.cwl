cwlVersion: v1.2
class: CommandLineTool
baseCommand: treerecs
label: treerecs
doc: "Treerecs is a tool for gene tree species tree reconciliation, including rooting,
  rearrangement and many other features.\n\nTool homepage: https://project.inria.fr/treerecs/"
inputs:
  - id: ale_evaluation
    type:
      - 'null'
      - boolean
    doc: compute ALE log likelihood for each solution.
    inputBinding:
      position: 101
      prefix: --ale-evaluation
  - id: alignments
    type:
      - 'null'
      - File
    doc: input alignment file. Must contain the pll substitution model and paths to
      multiple alignments.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: use case sensitive mapping.
    inputBinding:
      position: 101
      prefix: --case-sensitive
  - id: costs_estimation
    type:
      - 'null'
      - boolean
    doc: estimate duplication and loss costs.
    inputBinding:
      position: 101
      prefix: --costs-estimation
  - id: dupcost
    type:
      - 'null'
      - float
    doc: specify gene duplication cost.
    default: 2.0
    inputBinding:
      position: 101
      prefix: --dupcost
  - id: fevent
    type:
      - 'null'
      - boolean
    doc: create a file that summarizes orthology/paralogy relationships.
    inputBinding:
      position: 101
      prefix: --fevent
  - id: force
    type:
      - 'null'
      - boolean
    doc: force possible overwrite of existing files.
    inputBinding:
      position: 101
      prefix: --force
  - id: genetree
    type: File
    doc: 'input gene tree(s) (supported formats: Newick, NHX or PhyloXML).'
    inputBinding:
      position: 101
      prefix: --genetree
  - id: info
    type:
      - 'null'
      - boolean
    doc: print informations about genetree(s) with a branch support diagram.
    inputBinding:
      position: 101
      prefix: --info
  - id: losscost
    type:
      - 'null'
      - float
    doc: specify gene loss cost.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --losscost
  - id: output_format
    type:
      - 'null'
      - type: array
        items: string
    doc: 'output format(s): newick, nhx, phyloxml, recphyloxml or svg.'
    default: newick
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_without_description
    type:
      - 'null'
      - boolean
    doc: strip output from gene tree descriptions.
    inputBinding:
      position: 101
      prefix: --output-without-description
  - id: parallelize
    type:
      - 'null'
      - boolean
    doc: run in parallel if possible.
    inputBinding:
      position: 101
      prefix: --parallelize
  - id: prefix
    type:
      - 'null'
      - string
    doc: specify whether the species_name is a prefix of gene_name (Y/N).
    default: N
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: silent mode (no print, no progression bar).
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reroot
    type:
      - 'null'
      - boolean
    doc: find the best root according to the reconciliation cost.
    inputBinding:
      position: 101
      prefix: --reroot
  - id: sample_size
    type:
      - 'null'
      - int
    doc: size of the tree sampling.
    default: 1
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: save_map
    type:
      - 'null'
      - boolean
    doc: save map(s) used during execution.
    inputBinding:
      position: 101
      prefix: --save-map
  - id: sep
    type:
      - 'null'
      - string
    doc: specify separator character for species names embedded in gene names.
    default: _
    inputBinding:
      position: 101
      prefix: --sep
  - id: smap
    type:
      - 'null'
      - File
    doc: input gene-to-species mapping file.
    inputBinding:
      position: 101
      prefix: --smap
  - id: speciestree
    type:
      - 'null'
      - File
    doc: 'input species tree (supported formats: Newick, NHX or PhyloXML).'
    inputBinding:
      position: 101
      prefix: --speciestree
  - id: superverbose
    type:
      - 'null'
      - boolean
    doc: super-verbose mode. Print even more messages than in verbose mode.
    inputBinding:
      position: 101
      prefix: --superverbose
  - id: threshold
    type:
      - 'null'
      - string
    doc: specify branch support thresholds to use while contracting gene trees (EXPRESSION
      | quantiles[N]).
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tree_index
    type:
      - 'null'
      - int
    doc: only consider the VALUE-th gene tree in the gene tree file.
    inputBinding:
      position: 101
      prefix: --tree-index
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode. Causes Treerecs to print messages about its progress.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treerecs:1.2--h9f5acd7_3
