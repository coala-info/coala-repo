cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-toolbox
label: perl-test-toolbox
doc: "Perl testing toolbox (Note: The provided input text contains execution logs
  and an error message indicating the executable was not found, rather than help documentation.
  No arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Test::Toolbox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-toolbox:0.4--pl526_1
stdout: perl-test-toolbox.out
