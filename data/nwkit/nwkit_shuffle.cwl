cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit_shuffle
label: nwkit_shuffle
doc: "Shuffle newick trees\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: branch_length
    type:
      - 'null'
      - string
    doc: Shuffle branch length. Automatically activated when --topology yes.
    inputBinding:
      position: 101
      prefix: --branch_length
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
  - id: label
    type:
      - 'null'
      - string
    doc: Shuffle leaf labels.
    inputBinding:
      position: 101
      prefix: --label
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
  - id: topology
    type:
      - 'null'
      - string
    doc: Randomize entire tree topology and branch length. Without --label yes, 
      new topology preserve the leaf label orders and is not completely 
      randomized.
    inputBinding:
      position: 101
      prefix: --topology
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
