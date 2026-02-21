cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - trimpoor
label: treebest_trimpoor
doc: "Trim poor branches from a tree based on a threshold.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for trimming poor branches
    default: '0'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_trimpoor.out
