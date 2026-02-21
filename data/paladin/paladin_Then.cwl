cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - then
label: paladin_Then
doc: "The provided text indicates an unrecognized command error for 'paladin then'.
  No help documentation or arguments were found in the input.\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_Then.out
