cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathwaymatcher
  - modifications
label: pathwaymatcher_modifications
doc: "A tool for matching biological entities (likely modified peptides) to pathways.
  Note: The provided help text indicates an error or invalid subcommand.\n\nTool homepage:
  https://github.com/LuisFranciscoHS/PathwayMatcher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathwaymatcher:1.9.1--1
stdout: pathwaymatcher_modifications.out
