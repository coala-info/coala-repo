cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nwkit
  - rescale
label: nwkit_rescale
doc: "Rescale branch lengths of a newick tree.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: factor
    type: float
    doc: Rescaling factor of branch length.
    inputBinding:
      position: 101
      prefix: --factor
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
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
