cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytabix
label: pytabix
doc: "A Python module that allows for querying Tabix-indexed files. Note: The provided
  text appears to be a container runtime error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/slowkow/pytabix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytabix:0.1--py311hc84137b_7
stdout: pytabix.out
