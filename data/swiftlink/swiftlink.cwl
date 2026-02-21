cwlVersion: v1.2
class: CommandLineTool
baseCommand: swiftlink
label: swiftlink
doc: "The provided text is a container execution log and does not contain the help
  documentation for the swiftlink tool.\n\nTool homepage: https://github.com/ajm/swiftlink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swiftlink:1.0--1
stdout: swiftlink.out
