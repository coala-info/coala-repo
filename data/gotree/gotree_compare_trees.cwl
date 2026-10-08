cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compare
  - trees
label: gotree_compare_trees
doc: "Compare a reference tree with a set of trees.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "If true, then just print true (identical tree) or false (different tree) for each compared tree"
    inputBinding:
      position: 101
      prefix: --binary
  - id: rf
    type:
      - 'null'
      - boolean
    doc: "If true, outputs Robinson-Foulds distance, as the sum of reference + compared specific branches"
    inputBinding:
      position: 101
      prefix: --rf
  - id: tips
    type:
      - 'null'
      - boolean
    doc: "Include tips in the comparison"
    inputBinding:
      position: 101
      prefix: --tips
  - id: weighted
    type:
      - 'null'
      - boolean
    doc: "If true, outputs comparison metrics including branch lengths"
    inputBinding:
      position: 101
      prefix: --weighted
  - id: compared_tree
    type: File
    doc: "Compared trees input file"
    inputBinding:
      position: 101
      prefix: --compared
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: reference_tree
    type: File
    doc: "Reference tree input file"
    inputBinding:
      position: 101
      prefix: --reftree
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compare_trees.out
