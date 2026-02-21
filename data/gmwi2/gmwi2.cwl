cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmwi2
label: gmwi2
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system log messages and a fatal error regarding
  container image creation.\n\nTool homepage: https://github.com/danielchang2002/GMWI2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmwi2:1.6--pyhdfd78af_0
stdout: gmwi2.out
