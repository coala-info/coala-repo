cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - draw
  - text
label: gotree_draw_text
doc: "Print trees in ASCII.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: width
    type:
      - 'null'
      - int
    doc: "Width of tree/terminal (in characters)"
    inputBinding:
      position: 101
      prefix: --width
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: "Annotation file to add colored circles to tip nodes (svg & png) Tab separated, with <tip-name  Red  Green  Blue> or <tip-name hex-value> on each line"
    inputBinding:
      position: 101
      prefix: --annotation-file
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: no_branch_lengths
    type:
      - 'null'
      - boolean
    doc: "Draw the tree without branch lengths (all the same length)"
    inputBinding:
      position: 101
      prefix: --no-branch-lengths
  - id: no_tip_labels
    type:
      - 'null'
      - boolean
    doc: "Draw the tree without tip labels"
    inputBinding:
      position: 101
      prefix: --no-tip-labels
  - id: output_file_path
    type: string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: support_cutoff
    type:
      - 'null'
      - float
    doc: "Cutoff for highlithing supported branches"
    inputBinding:
      position: 101
      prefix: --support-cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: with_branch_support
    type:
      - 'null'
      - boolean
    doc: "Highlight highly supported branches"
    inputBinding:
      position: 101
      prefix: --with-branch-support
  - id: with_node_comments
    type:
      - 'null'
      - boolean
    doc: "Draw the tree with internal node comments (if --with-node-labels is not set)"
    inputBinding:
      position: 101
      prefix: --with-node-comments
  - id: with_node_labels
    type:
      - 'null'
      - boolean
    doc: "Draw the tree with internal node labels"
    inputBinding:
      position: 101
      prefix: --with-node-labels
  - id: with_node_symbols
    type:
      - 'null'
      - boolean
    doc: "Draw the tree with internal node symbols"
    inputBinding:
      position: 101
      prefix: --with-node-symbols
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
