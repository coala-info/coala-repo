cwlVersion: v1.2
class: CommandLineTool
baseCommand: skc
label: skc
doc: "The provided text is a log of a failed container build process and does not
  contain help documentation for the tool.\n\nTool homepage: https://github.com/mbhall88/skc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skc:0.1.0--h7b50bb2_1
stdout: skc.out
