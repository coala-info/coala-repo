cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-containers
label: galaxy-containers
doc: "A tool for managing or interacting with Galaxy-related containers. (Note: The
  provided text appears to be an error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-containers:21.9.0--pyhdfd78af_0
stdout: galaxy-containers.out
