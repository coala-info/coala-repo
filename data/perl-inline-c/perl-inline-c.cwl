cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-inline-c
label: perl-inline-c
doc: "A Perl module that allows you to write Perl subroutines in C. (Note: The provided
  text is a container build error log and does not contain CLI help information or
  argument definitions).\n\nTool homepage: https://github.com/ingydotnet/inline-c-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-inline-c:0.82--pl5321h7b50bb2_2
stdout: perl-inline-c.out
