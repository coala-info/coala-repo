cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit mark
label: nwkit_mark
doc: "Mark nodes in a Newick tree based on a pattern and target type.\n\nTool homepage:
  https://github.com/kfuku52/nwkit"
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
  - id: insert_pos
    type:
      - 'null'
      - string
    doc: Place to insert --insert_txt.
    inputBinding:
      position: 101
      prefix: --insert_pos
  - id: insert_sep
    type:
      - 'null'
      - string
    doc: Separator for --insert_txt.
    inputBinding:
      position: 101
      prefix: --insert_sep
  - id: insert_txt
    type:
      - 'null'
      - string
    doc: Label to insert to the target node labels.
    inputBinding:
      position: 101
      prefix: --insert_txt
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
    type:
      - 'null'
      - string
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
  - id: target
    type:
      - 'null'
      - string
    doc: Nodes to be marked.
    inputBinding:
      position: 101
      prefix: --target
  - id: target_only_clade
    type:
      - 'null'
      - string
    doc: Mark the label of MRCA/clade whose clade contains only target leaves. 
      Use with --target mrca/clade
    inputBinding:
      position: 101
      prefix: --target_only_clade
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
