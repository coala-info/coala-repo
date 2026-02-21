cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitig-caller
label: unitig-caller
doc: "A tool for calling unitigs (Note: The provided text is a container runtime error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/johnlees/unitig-caller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-caller:1.3.1--py311heec5c76_1
stdout: unitig-caller.out
