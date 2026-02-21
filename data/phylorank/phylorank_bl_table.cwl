cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - bl_table
label: phylorank_bl_table
doc: "Generate a branch length table for a given input tree and taxon category.\n\n
  Tool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: taxon_category
    type: string
    doc: Taxon category
    inputBinding:
      position: 2
  - id: step_size
    type:
      - 'null'
      - float
    doc: Step size for branch length calculations
    inputBinding:
      position: 103
      prefix: --step_size
outputs:
  - id: output_table
    type: File
    doc: Output table file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
