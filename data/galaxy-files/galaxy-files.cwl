cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-files
label: galaxy-files
doc: "A tool for managing files in Galaxy. (Note: The provided text appears to be
  a system error log regarding a container build failure rather than the tool's help
  documentation.)\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-files:25.1.0--pyhdfd78af_0
stdout: galaxy-files.out
