cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crimson
  - fusioncatcher
label: crimson_fusioncatcher
doc: "Convert FusionCatcher output to a structured format using Crimson.\n\nTool homepage:
  https://github.com/bow/crimson"
inputs:
  - id: input
    type: File
    doc: Input FusionCatcher file
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
