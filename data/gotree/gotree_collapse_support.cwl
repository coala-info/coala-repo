cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - collapse
  - support
label: gotree_collapse_support
doc: "Collapse lowly supported branches of the input tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: root
    type:
      - 'null'
      - boolean
    doc: "Applies also to branches connected to the root (may unroot the tree)"
    inputBinding:
      position: 101
      prefix: --root
  - id: support
    type:
      - 'null'
      - float
    doc: "Support cutoff to collapse branches"
    inputBinding:
      position: 101
      prefix: --support
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
  - id: output_file_path
    type: string
    doc: "Collapsed tree output file"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
