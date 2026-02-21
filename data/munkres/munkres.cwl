cwlVersion: v1.2
class: CommandLineTool
baseCommand: munkres
label: munkres
doc: "The Munkres module provides an implementation of the Munkres algorithm (also
  known as the Hungarian algorithm or the Kuhn-Munkres algorithm).\n\nTool homepage:
  https://github.com/bmc/munkres"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/munkres:1.0.7--py34_0
stdout: munkres.out
