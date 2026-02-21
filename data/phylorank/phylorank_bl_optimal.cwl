cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - bl_optimal
label: phylorank_bl_optimal
doc: "Determine branch length for best congruency with existing taxonomy.\n\nTool
  homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: input tree to calculate branch length distributions
    inputBinding:
      position: 1
  - id: rank_of_labels
    type: int
    doc: rank of labels (1, 2, 3, 4, 5, or 6)
    inputBinding:
      position: 2
  - id: max_dist
    type:
      - 'null'
      - float
    doc: maximum mean branch length value to evaluate
    default: 1.2
    inputBinding:
      position: 103
      prefix: --max_dist
  - id: min_dist
    type:
      - 'null'
      - float
    doc: minimum mean branch length value to evaluate
    default: 0.5
    inputBinding:
      position: 103
      prefix: --min_dist
  - id: step_size
    type:
      - 'null'
      - float
    doc: step size of mean branch length values
    default: 0.025
    inputBinding:
      position: 103
      prefix: --step_size
outputs:
  - id: output_table
    type: File
    doc: desired named of output table
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
