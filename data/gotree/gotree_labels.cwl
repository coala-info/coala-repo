cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree labels
label: gotree_labels
doc: "Lists labels of all tree tips\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: internal_node_labels
    type:
      - 'null'
      - boolean
    doc: Internal node labels are listed
    inputBinding:
      position: 101
      prefix: --internal
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: tip_labels
    type:
      - 'null'
      - boolean
    doc: Tip labels are listed (--tips=false to cancel)
    inputBinding:
      position: 101
      prefix: --tips
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_labels.out
