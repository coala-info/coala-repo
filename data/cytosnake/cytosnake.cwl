cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytosnake
label: cytosnake
doc: "The provided text is an error log from a container build process and does not
  contain help text or argument definitions for the tool 'cytosnake'.\n\nTool homepage:
  https://github.com/WayScience/CytoSnake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytosnake:0.0.2--pyhdfd78af_0
stdout: cytosnake.out
