cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-termreadkey
label: perl-termreadkey
doc: "The provided text does not contain help information or a description for the
  tool. It is an error log indicating that the executable was not found in the system
  PATH.\n\nTool homepage: http://metacpan.org/pod/TermReadKey"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-termreadkey:2.38--pl526h470a237_0
stdout: perl-termreadkey.out
