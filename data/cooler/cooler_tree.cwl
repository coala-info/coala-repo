cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler tree
label: cooler_tree
doc: "Display a file's data hierarchy.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: uri
    type: string
    doc: URI of the cooler file
    inputBinding:
      position: 1
  - id: level
    type:
      - 'null'
      - int
    doc: Maximum level of the hierarchy to display
    inputBinding:
      position: 102
      prefix: --level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_tree.out
