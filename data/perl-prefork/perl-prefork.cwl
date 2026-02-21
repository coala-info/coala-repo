cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-prefork
label: perl-prefork
doc: "The provided text does not contain help information or documentation for 'perl-prefork'.
  It consists of system logs indicating a failed attempt to locate the executable
  within a container environment.\n\nTool homepage: https://github.com/karenetheridge/prefork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-prefork:1.05--pl526_0
stdout: perl-prefork.out
