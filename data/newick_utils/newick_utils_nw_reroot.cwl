cwlVersion: v1.2
class: CommandLineTool
baseCommand: nw_reroot
label: newick_utils_nw_reroot
doc: "Reroot a phylogenetic tree at a specified node or outgroup.\n\nTool homepage:
  http://cegg.unige.ch/newick_utils"
inputs:
  - id: tree_file
    type: File
    doc: Input Newick tree file
    inputBinding:
      position: 1
  - id: outgroup_nodes
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels of nodes to be used as the outgroup
    inputBinding:
      position: 2
  - id: drop_node
    type:
      - 'null'
      - boolean
    doc: Drop the rerooting node if it is a leaf
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_reroot.out
