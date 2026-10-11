cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nw_reroot]
label: newick_utils_nw_reroot
doc: "(Re)roots a tree on the outgroup formed by the given labels (their LCA); with no
  label the tree is rerooted on the longest branch.\n\nTool homepage: http://cegg.unige.ch/newick_utils"
inputs:
  - id: deroot
    type:
      - 'null'
      - boolean
    doc: Deroot - splice out the LCA of the ingroup, attaching its children to the root.
    inputBinding:
      position: 1
      prefix: -d
  - id: lax
    type:
      - 'null'
      - boolean
    doc: Lax - if rerooting on the outgroup is not possible, try the ingroup (all nodes whose labels were NOT given).
    inputBinding:
      position: 2
      prefix: -l
  - id: support
    type:
      - 'null'
      - boolean
    doc: Treat inner node labels as bipartition support values.
    inputBinding:
      position: 3
      prefix: -s
  - id: tree_file
    type: File
    doc: File with Newick trees.
    inputBinding:
      position: 4
  - id: outgroup_nodes
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels of the outgroup nodes.
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Rerooted trees.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_reroot.out
