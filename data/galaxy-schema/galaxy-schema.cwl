cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-schema
label: galaxy-schema
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container execution (no space left
  on device).\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-schema:25.0.4--pyhdfd78af_0
stdout: galaxy-schema.out
