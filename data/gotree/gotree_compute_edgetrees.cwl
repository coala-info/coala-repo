cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compute
  - edgetrees
label: gotree_compute_edgetrees
doc: "For each edge of the input tree, builds a tree with only this edge.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: deepest
    type:
      - 'null'
      - boolean
    doc: "Output a tree only for the deepest bipartition"
    inputBinding:
      position: 101
      prefix: --deepest
  - id: out_prefix
    type: string
    doc: "Output tree files prefix"
    inputBinding:
      position: 101
      prefix: --out
  - id: reference_tree
    type: File
    doc: "Reference tree input file"
    inputBinding:
      position: 101
      prefix: --reftree
  - id: text_format
    type:
      - 'null'
      - boolean
    doc: "Output bipartitions in the form t1,t2,...,tp|tp+1,...tn instead of newick"
    inputBinding:
      position: 101
      prefix: --text-format
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
  - id: out_trees
    type:
      type: array
      items: File
    doc: "Output trees written with the given prefix"
    outputBinding:
      glob: "$(inputs.out_prefix)*"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compute_edgetrees.out
