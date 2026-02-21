cwlVersion: v1.2
class: CommandLineTool
baseCommand: isotools
label: isotools
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/MatthiasLienhard/isotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isotools:2.0.0--pyhdfd78af_0
stdout: isotools.out
