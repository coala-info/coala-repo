cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - divide
label: gotree_divide
doc: "Divide an input tree file into several tree files.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree
    type: File
    doc: "Input tree(s) file"
    inputBinding:
      position: 101
      prefix: --input
  - id: out_prefix
    type: string
    doc: "Divided trees output file prefix"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: divided_trees
    type:
      type: array
      items: File
    doc: "Divided trees written with the given prefix"
    outputBinding:
      glob: "$(inputs.out_prefix)*"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_divide.out
