cwlVersion: v1.2
class: CommandLineTool
baseCommand: latch
label: latch
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding disk space during a
  container image conversion.\n\nTool homepage: https://pypi.org/project/latch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/latch:2.67.23--pyhdfd78af_0
stdout: latch.out
