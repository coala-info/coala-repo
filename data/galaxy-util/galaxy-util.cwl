cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-util
label: galaxy-util
doc: "A utility tool for Galaxy. Note: The provided help text contains only system
  error messages regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-util:25.1
stdout: galaxy-util.out
