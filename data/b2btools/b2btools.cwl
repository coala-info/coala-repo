cwlVersion: v1.2
class: CommandLineTool
baseCommand: b2btools
label: b2btools
doc: "The provided text contains system error logs rather than help documentation.
  No description or arguments could be parsed.\n\nTool homepage: https://bio2byte.be/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2btools:3.0.7--py312h9c9b0c2_2
stdout: b2btools.out
