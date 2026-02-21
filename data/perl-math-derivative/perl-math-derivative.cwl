cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-derivative
label: perl-math-derivative
doc: "A Perl-based tool or module for calculating mathematical derivatives. (Note:
  The provided text is an execution error log and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: http://metacpan.org/pod/Math-Derivative"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-derivative:1.01--pl526_0
stdout: perl-math-derivative.out
