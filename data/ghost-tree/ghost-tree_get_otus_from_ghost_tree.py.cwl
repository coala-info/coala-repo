cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghost-tree_get_otus_from_ghost_tree.py
label: ghost-tree_get_otus_from_ghost_tree.py
doc: "A tool to get OTUs from a ghost-tree. (Note: The provided help text contains
  only system error messages and no usage information.)\n\nTool homepage: https://github.com/JTFouquier/ghost-tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghost-tree:0.2.2--py_0
stdout: ghost-tree_get_otus_from_ghost_tree.py.out
