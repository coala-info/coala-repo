cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-perl-ostype
label: perl-perl-ostype
doc: "A tool related to the Perl module Perl::OSType, which maps operating system
  names to generic types.\n\nTool homepage: https://github.com/Perl-Toolchain-Gang/Perl-OSType"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perl-ostype:1.010--pl526_1
stdout: perl-perl-ostype.out
