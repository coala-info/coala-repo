cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-warn
label: perl-test-warn
doc: "A tool for testing Perl warnings (Note: The provided text contains execution
  logs and an error message rather than help documentation; no arguments could be
  identified).\n\nTool homepage: http://metacpan.org/pod/Test-Warn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-warn:0.36--pl526_0
stdout: perl-test-warn.out
