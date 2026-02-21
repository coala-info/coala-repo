cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-implementation
label: perl-module-implementation
doc: "A tool for Perl module implementation (Note: The provided text is an error log
  indicating the executable was not found, and does not contain usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/libwww-perl/libwww-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-implementation:0.09--pl526_2
stdout: perl-module-implementation.out
