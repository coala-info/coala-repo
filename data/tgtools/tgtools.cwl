cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgtools
label: tgtools
doc: "The provided text does not contain help information or usage instructions for
  tgtools; it contains system logs and a fatal error message related to building a
  container image.\n\nTool homepage: https://github.com/jodyphelan/tgtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
stdout: tgtools.out
