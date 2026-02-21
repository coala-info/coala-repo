cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathwaymatcher
  - base
label: pathwaymatcher_base
doc: "PathwayMatcher is a tool for mapping biological entities (genes, proteins, variants,
  etc.) to pathways. (Note: The provided text indicates an execution error or unrecognized
  subcommand).\n\nTool homepage: https://github.com/LuisFranciscoHS/PathwayMatcher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathwaymatcher:1.9.1--1
stdout: pathwaymatcher_base.out
