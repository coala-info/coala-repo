cwlVersion: v1.2
class: CommandLineTool
baseCommand: bindash
label: bindash_To
doc: "B-bit One-Permutation Rolling MinHash with Optimal/Faster\nDensification for
  Genome Search and Comparisons.\nOr Binwise Densified MinHash.\n\nTool homepage:
  https://github.com/zhaoxiaofei/bindash"
inputs:
  - id: command
    type: string
    doc: The command to run (sketch, dist, exact)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bindash:2.6--h077b44d_0
stdout: bindash_To.out
