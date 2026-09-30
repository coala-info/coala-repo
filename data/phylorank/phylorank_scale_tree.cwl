cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - scale_tree
label: phylorank_scale_tree
doc: "Scale a phylogenetic tree using phylorank\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: Path to the input phylogenetic tree file
    inputBinding:
      position: 1
  - id: output_tree
    type: string
    doc: Path where the scaled output tree will be written
    inputBinding:
      position: 2
outputs:
  - id: out_output_tree
    type: File
    doc: Path where the scaled output tree will be written
    outputBinding:
      glob: '$(inputs.output_tree)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
