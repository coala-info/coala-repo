cwlVersion: v1.2
class: CommandLineTool
baseCommand: venndata
label: venndata
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/mandalsubhajit/venndata"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/venndata:0.1.0--pyhdfd78af_0
stdout: venndata.out
