cwlVersion: v1.2
class: CommandLineTool
baseCommand: rptools
label: rptools
doc: "The provided text does not contain help information for rptools; it appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/RPTools/maptool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rptools:5.13.1
stdout: rptools.out
