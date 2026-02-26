cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges tree
label: ibridges_tree
doc: "Show collection/directory tree.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_coll
    type:
      - 'null'
      - string
    doc: Path to collection to make a tree of.
    inputBinding:
      position: 1
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Print the tree in pure ascii.
    inputBinding:
      position: 102
      prefix: --ascii
  - id: depth
    type:
      - 'null'
      - int
    doc: Maximum depth of the tree to be shown, default no limit.
    default: no limit
    inputBinding:
      position: 102
      prefix: --depth
  - id: show_max
    type:
      - 'null'
      - int
    doc: Show only up to this number of dataobject in the same collection, 
      default 10.
    default: 10
    inputBinding:
      position: 102
      prefix: --show-max
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_tree.out
