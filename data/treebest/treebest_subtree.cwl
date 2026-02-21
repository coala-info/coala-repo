cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - subtree
label: treebest_subtree
doc: "Extract a subtree from a tree based on a list of nodes\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: list
    type: File
    doc: List of nodes to include in the subtree
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_subtree.out
