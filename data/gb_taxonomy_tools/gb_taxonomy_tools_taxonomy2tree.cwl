cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy2tree
label: gb_taxonomy_tools_taxonomy2tree
doc: "Converts the output of taxonomy-reader into a Newick tree file of the taxonomic hierarchy and a tab-separated summary file.\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: tax_dump_file
    type: File
    doc: "Tab-separated taxonomy dump (the output of taxonomy-reader)"
    inputBinding:
      position: 1
  - id: max_tree_level
    type: int
    doc: "Maximum tree level (<=0 to show all)"
    inputBinding:
      position: 2
  - id: tree_output_name
    type: string
    doc: "Name of the Newick tree file to write"
    inputBinding:
      position: 3
  - id: summary_output_name
    type: string
    doc: "Name of the tab-separated summary file to write"
    inputBinding:
      position: 4
  - id: include_empty_nodes
    type:
      - 'null'
      - int
    doc: "Include empty nodes: 0 or 1 (default 0)"
    inputBinding:
      position: 5
outputs:
  - id: tree_output_file
    type: File
    doc: Newick tree file
    outputBinding:
      glob: $(inputs.tree_output_name)
  - id: summary_output_file
    type: File
    doc: Tab-separated summary file
    outputBinding:
      glob: $(inputs.summary_output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
