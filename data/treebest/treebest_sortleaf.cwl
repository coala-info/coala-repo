cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - sortleaf
label: treebest_sortleaf
doc: "Sort leaves in a tree file\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree1
    type: File
    doc: Input tree file to be sorted
    inputBinding:
      position: 1
  - id: tree2
    type:
      - 'null'
      - File
    doc: Optional second tree file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_sortleaf.out
