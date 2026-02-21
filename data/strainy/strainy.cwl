cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainy
label: strainy
doc: "\nTool homepage: https://github.com/katerinakazantseva/strainy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainy:1.2--pyhdfd78af_1
stdout: strainy.out
