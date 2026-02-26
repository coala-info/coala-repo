cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy2tree
label: gb_taxonomy_tools_taxonomy2tree
doc: "Converts a taxonomy dump file into a tree structure and a summary.\n\nTool homepage:
  https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: tax_dump_file
    type: File
    doc: tab separated taxonomy dump
    inputBinding:
      position: 1
  - id: max_tree_level
    type: int
    doc: max tree level (<=0 to show all)
    inputBinding:
      position: 2
  - id: include_empty_nodes
    type:
      - 'null'
      - boolean
    doc: include empty nodes; 0 or 1; default 0
    default: 0
    inputBinding:
      position: 103
outputs:
  - id: tree_output_file
    type: File
    doc: write tree file here
    outputBinding:
      glob: '*.out'
  - id: summary_output_file
    type: File
    doc: write tab separated summary here
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
