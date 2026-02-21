cwlVersion: v1.2
class: CommandLineTool
baseCommand: shustring
label: shustring
doc: "\nTool homepage: https://github.com/wrbuckley/Shustringer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shustring:2.6--0
stdout: shustring.out
