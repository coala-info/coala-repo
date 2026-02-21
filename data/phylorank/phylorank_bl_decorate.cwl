cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - bl_decorate
label: phylorank_bl_decorate
doc: "Decorate tree using a mean branch length criterion.\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: input tree to decorate
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: file with taxonomic information for each taxon
    inputBinding:
      position: 2
  - id: threshold
    type: float
    doc: mean branch length threshold
    inputBinding:
      position: 3
  - id: rank
    type: int
    doc: rank of labels (1, 2, 3, 4, 5, or 6)
    inputBinding:
      position: 4
  - id: keep_labels
    type:
      - 'null'
      - boolean
    doc: keep all existing internal labels
    inputBinding:
      position: 105
      prefix: --keep_labels
  - id: prune
    type:
      - 'null'
      - boolean
    doc: prune tree to preserve only the shallowest and deepest taxa in each child
      lineage from newly decorated nodes
    inputBinding:
      position: 105
      prefix: --prune
  - id: retain_named_lineages
    type:
      - 'null'
      - boolean
    doc: retain existing named lineages at the specified rank
    inputBinding:
      position: 105
      prefix: --retain_named_lineages
outputs:
  - id: output_tree
    type: File
    doc: decorate tree
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
