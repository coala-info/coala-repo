cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit_transfer
label: nwkit_transfer
doc: "Transfer information between two Newick trees.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: fill
    type:
      - 'null'
      - string
    doc: Fill values instead of leaving as is, if no corresponding node is 
      found.
    inputBinding:
      position: 101
      prefix: --fill
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    inputBinding:
      position: 101
      prefix: --format
  - id: format2
    type:
      - 'null'
      - int
    doc: ETE tree format for --infile2.
    inputBinding:
      position: 101
      prefix: --format2
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --infile
  - id: infile2
    type:
      - 'null'
      - File
    doc: Input newick file 2. Specified infor will be transferred from this file
      to --infile. Topologies may deviate but leaf labels should be matched 
      between the two trees.
    inputBinding:
      position: 101
      prefix: --infile2
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
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: target
    type:
      - 'null'
      - string
    doc: Nodes to be edited.
    inputBinding:
      position: 101
      prefix: --target
  - id: transfer_length
    type:
      - 'null'
      - boolean
    doc: transfer branch length.
    inputBinding:
      position: 101
      prefix: --length
  - id: transfer_name
    type:
      - 'null'
      - boolean
    doc: transfer node names.
    inputBinding:
      position: 101
      prefix: --name
  - id: transfer_support
    type:
      - 'null'
      - boolean
    doc: transfer support values.
    inputBinding:
      position: 101
      prefix: --support
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
