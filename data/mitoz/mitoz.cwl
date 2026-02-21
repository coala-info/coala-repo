cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitoz
label: mitoz
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
stdout: mitoz.out
