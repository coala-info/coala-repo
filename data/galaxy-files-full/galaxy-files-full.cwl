cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-files-full
label: galaxy-files-full
doc: "A tool for managing Galaxy files (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-files-full:25.0.4--pyhdfd78af_0
stdout: galaxy-files-full.out
