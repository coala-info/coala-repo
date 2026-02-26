cwlVersion: v1.2
class: CommandLineTool
baseCommand: TreeCluster.py
label: treecluster_TreeCluster.py
doc: "TreeCluster.py is a Python script for clustering phylogenetic trees.\n\nTool
  homepage: https://github.com/niemasd/TreeCluster"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input Tree File
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: 'Clustering Method (options: avg_clade, leaf_dist_avg, leaf_dist_max, leaf_dist_min,
      length, length_clade, max, max_clade, med_clade, root_dist, single_linkage,
      single_linkage_cut, single_linkage_union, sum_branch, sum_branch_clade)'
    default: max_clade
    inputBinding:
      position: 101
      prefix: --method
  - id: support
    type:
      - 'null'
      - float
    doc: Branch Support Threshold
    default: -inf
    inputBinding:
      position: 101
      prefix: --support
  - id: threshold
    type:
      - 'null'
      - float
    doc: Length Threshold
    default: None
    inputBinding:
      position: 101
      prefix: --threshold
  - id: threshold_free
    type:
      - 'null'
      - string
    doc: 'Threshold-Free Approach (options: argmax_clusters)'
    default: None
    inputBinding:
      position: 101
      prefix: --threshold_free
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose Mode
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output File
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treecluster:1.0.5--pyh7e72e81_0
