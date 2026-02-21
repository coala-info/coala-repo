cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crimson
  - star-fusion
label: crimson_star-fusion
doc: "Convert STAR-Fusion output to Crimson format\n\nTool homepage: https://github.com/bow/crimson"
inputs:
  - id: input
    type: File
    doc: Input STAR-Fusion file
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crimson:1.1.1--pyh7cba7a3_0
