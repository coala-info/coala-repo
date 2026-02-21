cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem2
label: gem2
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding disk space during a container image
  conversion.\n\nTool homepage: https://github.com/fedora-ruby/gem2rpm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem2:20200110--h9ee0642_1
stdout: gem2.out
