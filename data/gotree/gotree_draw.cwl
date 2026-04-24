cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - draw
label: gotree_draw
doc: "Draw trees\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - string
    doc: "Annotation file to add colored circles to tip nodes (svg & png)\n      \
      \                           Tab separated, with <tip-name  Red  Green  Blue>
      or\n                                 <tip-name hex-value> on each line"
    inputBinding:
      position: 101
      prefix: --annotation-file
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type:
      - 'null'
      - string
    doc: Input tree
    inputBinding:
      position: 101
      prefix: -i
  - id: no_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Draw the tree without branch lengths (all the same length)
    inputBinding:
      position: 101
      prefix: --no-branch-lengths
  - id: no_tip_labels
    type:
      - 'null'
      - boolean
    doc: Draw the tree without tip labels
    inputBinding:
      position: 101
      prefix: --no-tip-labels
  - id: output
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 101
      prefix: -o
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: support_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff for highlithing supported branches
    inputBinding:
      position: 101
      prefix: --support-cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: with_branch_support
    type:
      - 'null'
      - boolean
    doc: Highlight highly supported branches
    inputBinding:
      position: 101
      prefix: --with-branch-support
  - id: with_node_comments
    type:
      - 'null'
      - boolean
    doc: Draw the tree with internal node comments (if --with-node-labels is not
      set)
    inputBinding:
      position: 101
      prefix: --with-node-comments
  - id: with_node_labels
    type:
      - 'null'
      - boolean
    doc: Draw the tree with internal node labels
    inputBinding:
      position: 101
      prefix: --with-node-labels
  - id: with_node_symbols
    type:
      - 'null'
      - boolean
    doc: Draw the tree with internal node symbols
    inputBinding:
      position: 101
      prefix: --with-node-symbols
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_draw.out
