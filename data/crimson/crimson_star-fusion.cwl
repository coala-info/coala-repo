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
    type: stdout
    doc: Converted output in JSON format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crimson:1.1.1--pyh7cba7a3_0
stdout: crimson_star-fusion.json
