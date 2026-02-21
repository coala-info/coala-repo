cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-canary-stability
label: perl-canary-stability
doc: "A tool for checking Perl canary stability. (Note: The provided text contains
  execution logs and an error indicating the executable was not found, rather than
  standard help text. No arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Canary::Stability"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-canary-stability:2013--pl526_0
stdout: perl-canary-stability.out
