cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-onto-perl
label: perl-onto-perl
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container build/execution environment.\n\nTool homepage:
  https://github.com/ajay04323/cpanel_CPSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-onto-perl:1.45--pl526_2
stdout: perl-onto-perl.out
