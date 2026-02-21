cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem3-mapper
label: gem3-mapper
doc: "The provided text does not contain help information for gem3-mapper. It contains
  system log messages and a fatal error regarding container image acquisition (no
  space left on device).\n\nTool homepage: https://github.com/smarco/gem3-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper.out
