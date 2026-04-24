cwlVersion: v1.2
class: CommandLineTool
baseCommand: root_tree.py
label: phyloaln_root_tree.py
doc: "Roots a phylogenetic tree.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_nwk
    type: File
    doc: Input Newick format tree file
    inputBinding:
      position: 1
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Outgroup(s) to root the tree with, separated by comma. Defaults to the 
      midpoint outgroup.
    inputBinding:
      position: 2
outputs:
  - id: output_nwk
    type: File
    doc: Output Newick format tree file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
