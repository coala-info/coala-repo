cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-differences
label: perl-test-differences
doc: "The provided text is an error log indicating that the executable 'perl-test-differences'
  was not found in the system PATH. No help text or usage information was available
  to parse.\n\nTool homepage: http://metacpan.org/pod/Test-Differences"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-differences:0.67--pl526_0
stdout: perl-test-differences.out
