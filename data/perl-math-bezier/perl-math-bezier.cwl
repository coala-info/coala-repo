cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-bezier
label: perl-math-bezier
doc: "A Perl module for the solution of Bezier curves. Note: The provided help text
  indicates a system error where the executable was not found, so no specific arguments
  could be parsed from the output.\n\nTool homepage: https://github.com/pld-linux/perl-Math-Bezier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-bezier:0.01--0
stdout: perl-math-bezier.out
