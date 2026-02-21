cwlVersion: v1.2
class: CommandLineTool
baseCommand: softsv
label: softsv
doc: "SoftSV is a tool designed for the detection of structural variants (SVs) using
  soft-clipped reads from alignment data.\n\nTool homepage: https://sourceforge.net/projects/softsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/softsv:1.4.2--hb891895_0
stdout: softsv.out
