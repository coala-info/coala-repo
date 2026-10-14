cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prune_tree.py
label: phyloaln_prune_tree.py
doc: "Prune clades (given by their sequence names) from a Newick tree.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_nwk
    type: File
    doc: "input tree in Newick format"
    inputBinding:
      position: 1
  - id: output_nwk_path
    type: string
    doc: "output tree in Newick format"
    inputBinding:
      position: 2
  - id: clades
    type:
      type: array
      items: string
    doc: "one clade per word: its sequences (separated by comma) are deleted; the clade is the smallest one that holds them"
    inputBinding:
      position: 3
outputs:
  - id: output_nwk
    type:
      - 'null'
      - File
    doc: "Pruned tree"
    outputBinding:
      glob: "$(inputs.output_nwk_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
