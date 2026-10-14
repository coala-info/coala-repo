cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - root_tree.py
label: phyloaln_root_tree.py
doc: "Root a Newick tree by an outgroup or by the midpoint.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
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
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "outgroup sequences, separated by comma (default: the midpoint outgroup)"
    inputBinding:
      position: 3
outputs:
  - id: output_nwk
    type:
      - 'null'
      - File
    doc: "Rooted tree"
    outputBinding:
      glob: "$(inputs.output_nwk_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
