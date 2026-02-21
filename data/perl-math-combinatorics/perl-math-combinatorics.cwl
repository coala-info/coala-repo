cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-combinatorics
label: perl-math-combinatorics
doc: 'A Perl-based tool for combinatorics. (Note: The provided input contains execution
  logs and an error indicating the executable was not found, rather than the help
  text. No arguments could be parsed.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-combinatorics:0.09--0
stdout: perl-math-combinatorics.out
