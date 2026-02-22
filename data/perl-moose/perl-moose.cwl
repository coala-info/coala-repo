cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-moose
doc: "Moose is a postmodern object system for Perl 5. Note: The provided text contains
  system error messages regarding disk space and container image conversion rather
  than command-line help documentation.\n\nTool homepage: http://moose.perl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moose:2.2202--pl5321hec16e2b_0
stdout: perl-moose.out
