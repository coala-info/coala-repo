cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tap-harness-env
label: perl-tap-harness-env
doc: 'A tool for running Perl tests via TAP::Harness. Note: The provided input text
  is an error log indicating the executable was not found in the environment, and
  therefore does not contain specific argument definitions.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tap-harness-env:3.30--pl526_1
stdout: perl-tap-harness-env.out
