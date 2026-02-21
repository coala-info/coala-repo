cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - format
label: treebest_format
doc: "Format a tree using treebest\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: single_line
    type:
      - 'null'
      - boolean
    doc: Output the tree on a single line
    inputBinding:
      position: 102
      prefix: '-1'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_format.out
