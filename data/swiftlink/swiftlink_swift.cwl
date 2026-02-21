cwlVersion: v1.2
class: CommandLineTool
baseCommand: swiftlink
label: swiftlink_swift
doc: "SwiftLink is a tool for linkage analysis. (Note: The provided text appears to
  be a container engine log rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/ajm/swiftlink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swiftlink:1.0--1
stdout: swiftlink_swift.out
