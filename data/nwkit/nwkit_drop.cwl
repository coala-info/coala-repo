cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit drop
label: nwkit_drop
doc: "Drop nodes from a newick tree.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: drop_length
    type:
      - 'null'
      - boolean
    doc: Drop branch length.
    default: no
    inputBinding:
      position: 101
      prefix: --length
  - id: drop_names
    type:
      - 'null'
      - boolean
    doc: Drop node names.
    default: no
    inputBinding:
      position: 101
      prefix: --name
  - id: drop_support
    type:
      - 'null'
      - boolean
    doc: Drop support values.
    default: no
    inputBinding:
      position: 101
      prefix: --support
  - id: fill
    type:
      - 'null'
      - string
    doc: Fill values instead of simply dropping them.
    default: None
    inputBinding:
      position: 101
      prefix: --fill
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    default: yes
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: target
    type:
      - 'null'
      - string
    doc: Nodes to be edited.
    default: all
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
