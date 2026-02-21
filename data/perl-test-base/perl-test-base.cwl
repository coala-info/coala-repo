cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-base
label: perl-test-base
doc: "A tool for Perl testing (Note: The provided help text contains only execution
  error logs and no usage information).\n\nTool homepage: https://github.com/ingydotnet/test-base-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-base:0.89--pl526_0
stdout: perl-test-base.out
