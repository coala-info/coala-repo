cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcov
label: bcov
doc: "A tool for coverage analysis (Note: The provided text contains system error
  logs rather than help documentation).\n\nTool homepage: http://biocomp.unibo.it/savojard/bcov/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcov:1.0--h2431fb8_3
stdout: bcov.out
