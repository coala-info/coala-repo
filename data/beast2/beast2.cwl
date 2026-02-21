cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast2
doc: "BEAST is a cross-platform program for Bayesian evolutionary analysis of molecular
  sequences.\n\nTool homepage: http://www.beast2.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beast2:2.6.3--he65b2d3_2
stdout: beast2.out
