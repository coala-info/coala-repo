cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxtcomb]
label: phyx_pxtcomb
doc: |-
  Combine a set of trees from one file into a tree from another.
  Pass in 2 trees with `t` and `a`.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "reference treefile"
    inputBinding:
      prefix: -t
  - id: add_tree_file
    type: File
    doc: "alternate treefile"
    inputBinding:
      prefix: -a
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "combined tree"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
