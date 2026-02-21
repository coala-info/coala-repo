cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-complex
label: perl-math-complex
doc: "Perl module for complex number arithmetic. (Note: The provided help text indicates
  the executable was not found, so no arguments could be extracted.)\n\nTool homepage:
  http://metacpan.org/pod/Math::Complex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-complex:1.59--pl526_0
stdout: perl-math-complex.out
