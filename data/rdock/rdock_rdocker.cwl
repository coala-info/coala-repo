cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdocker
label: rdock_rdocker
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error encountered during
  a container build process.\n\nTool homepage: https://github.com/dvddarias/rdocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdock:2013.1-0
stdout: rdock_rdocker.out
