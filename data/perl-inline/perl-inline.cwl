cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-inline
label: perl-inline
doc: "Inline allows you to write Perl subroutines in other programming languages.
  (Note: The provided text contains system error messages regarding container image
  building and does not contain CLI help documentation or argument definitions.)\n\
  \nTool homepage: https://github.com/ingydotnet/inline-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-inline:0.87--pl5321hdfd78af_0
stdout: perl-inline.out
