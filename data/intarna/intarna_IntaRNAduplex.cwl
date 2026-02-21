cwlVersion: v1.2
class: CommandLineTool
baseCommand: IntaRNAduplex
label: intarna_IntaRNAduplex
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error regarding disk space
  during a container image conversion.\n\nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNAduplex.out
