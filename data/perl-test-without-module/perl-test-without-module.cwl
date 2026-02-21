cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-without-module
label: perl-test-without-module
doc: "A tool to test Perl code as if specific modules were not installed. (Note: The
  provided text contains execution logs and an error message rather than help documentation;
  no arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Test-Without-Module"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-without-module:0.20--pl526_0
stdout: perl-test-without-module.out
