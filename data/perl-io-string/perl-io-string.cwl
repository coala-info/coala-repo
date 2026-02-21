cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-string
label: perl-io-string
doc: "The perl-io-string tool (Note: The provided text is an error log indicating
  the executable was not found in the environment and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/gooselinux/perl-IO-String"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-string:1.08--pl526_2
stdout: perl-io-string.out
