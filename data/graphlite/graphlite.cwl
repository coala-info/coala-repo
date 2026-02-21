cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlite
label: graphlite
doc: "A graph processing framework (Note: The provided text contains only system error
  messages and no help documentation).\n\nTool homepage: https://github.com/eugene-eeo/graphlite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphlite:1.0.5--py35_1
stdout: graphlite.out
