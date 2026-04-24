cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit printlabel
label: nwkit_printlabel
doc: "Print labels from a newick tree based on a pattern.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
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
  - id: pattern
    type: string
    doc: Regular expression for label search.
    inputBinding:
      position: 101
      prefix: --pattern
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: sister
    type:
      - 'null'
      - string
    doc: Show labels of the sisters instead of targets.
    inputBinding:
      position: 101
      prefix: --sister
  - id: target
    type:
      - 'null'
      - string
    doc: Nodes to be searched.
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
