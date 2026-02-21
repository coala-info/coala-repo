cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitig-counter
label: unitig-counter
doc: "A tool for counting unitigs (Note: The provided help text contains only container
  execution errors and no usage information).\n\nTool homepage: https://github.com/johnlees/unitig-counter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
stdout: unitig-counter.out
