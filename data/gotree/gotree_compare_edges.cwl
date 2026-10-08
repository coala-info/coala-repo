cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compare
  - edges
label: gotree_compare_edges
doc: "Compare edges of a reference tree with another tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: moved_taxa
    type:
      - 'null'
      - boolean
    doc: "only if --transfer-dist is given: Then display, for each branch, taxa that must be moved"
    inputBinding:
      position: 101
      prefix: --moved-taxa
  - id: transfer_dist
    type:
      - 'null'
      - boolean
    doc: "If transfer dist must be computed for each edge"
    inputBinding:
      position: 101
      prefix: --transfer-dist
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
stdout: gotree_compare_edges.out
