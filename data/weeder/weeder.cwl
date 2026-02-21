cwlVersion: v1.2
class: CommandLineTool
baseCommand: weeder
label: weeder
doc: "Weeder is a tool for finding novel motifs in a set of sequences.\n\nTool homepage:
  https://github.com/ocharles/weeder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/weeder:2.0--h9948957_10
stdout: weeder.out
