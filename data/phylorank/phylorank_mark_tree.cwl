cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - mark_tree
label: phylorank_mark_tree
doc: "Mark nodes with distribution information and predicted taxonomic ranks.\n\n
  Tool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: input tree to mark
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - float
    doc: only mark nodes with a parent branch above the specified length (default=0)
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_support
    type:
      - 'null'
      - int
    doc: only mark nodes above the specified support value (default=0)
    inputBinding:
      position: 102
      prefix: --min_support
  - id: no_percentile
    type:
      - 'null'
      - boolean
    doc: do not mark with percentile information
    inputBinding:
      position: 102
      prefix: --no_percentile
  - id: no_prediction
    type:
      - 'null'
      - boolean
    doc: do not mark with predicted rank information
    inputBinding:
      position: 102
      prefix: --no_prediction
  - id: no_relative_divergence
    type:
      - 'null'
      - boolean
    doc: do not mark with relative divergence information
    inputBinding:
      position: 102
      prefix: --no_relative_divergence
  - id: only_named_clades
    type:
      - 'null'
      - boolean
    doc: only mark nodes with an existing label
    inputBinding:
      position: 102
      prefix: --only_named_clades
  - id: thresholds
    type:
      - 'null'
      - string
    doc: relative divergence thresholds for taxonomic ranks
    inputBinding:
      position: 102
      prefix: --thresholds
outputs:
  - id: output_tree
    type: File
    doc: output tree with assigned taxonomic ranks
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
