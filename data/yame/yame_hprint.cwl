cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - hprint
label: yame_hprint
doc: "Print data transposed / horizontally.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: binary_cg
    type: File
    doc: Input binary file
    inputBinding:
      position: 1
  - id: coloring
    type:
      - 'null'
      - boolean
    doc: Coloring the output using ASCII-escape code.
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_hprint.out
