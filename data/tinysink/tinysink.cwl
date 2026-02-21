cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinysink
label: tinysink
doc: "No description available (the provided text is a container build log and does
  not contain help information).\n\nTool homepage: https://github.com/mbhall88/tinysink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinysink:1.0--0
stdout: tinysink.out
